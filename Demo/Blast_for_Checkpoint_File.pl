#!/usr/bin/perl -w
use strict;
# Resolve symlinks to find source deploymnet
use FindBin qw( $RealBin );
my $Bin = $RealBin;
use constant VERSION => 3.10;
$| = 1; # disable stdout buffering
use File::Path;
use File::Copy qw/ copy /;
use File::Basename;
use Time::Local;
my %options;
use Cwd qw/ cwd abs_path /;

# initialize options
my %opts = &getCommandLineOptions();
$options{fastafile} = abs_path( $opts{f} );
$options{rundir} = cwd();     # get the full path (needed for sam stuff)

################## Protein Name Here
$options{runid} = "OUTPUT";
# NR database path
my $NR = "/mnt/f/Blast/nr";

#################### THESE FILE LOCATIONS DEPEND ON THE SOFTWARE PACKAGE
my $PSIBLAST = "/mnt/f/Blaster/blast-2.2.26/bin/blastpgp";

mkpath( $options{rundir} );
$options{rundir} = abs_path( $options{rundir} );
chop( $options{rundir} ) if ( substr( $options{rundir}, -1, 1 ) eq '/' );
&chkExist( 'd', $options{rundir} );

my $abs_path_fasta = abs_path( $options{fastafile} );
$options{fastafile} = basename( $options{fastafile} );
if ( $abs_path_fasta ne abs_path("$options{rundir}/$options{fastafile}") ) {
    copy( $options{fastafile}, "$options{rundir}/" )
      or die "Error copying $options{fastafile} into $options{rundir}!\n";
}

chdir( $options{rundir} );

# get the sequence from the fasta file
my $sequence = read_fasta( $options{fastafile} );
print_debug("Sequence: $sequence");

# run blast
unless ( &nonempty_file_exists("$options{runid}.chk") ) {
    print_debug("Running psiblast for sequence profile");
    print_debug("Using nr: $NR");
    if (
        !&try_try_again(
"$PSIBLAST -t 1 -i $options{fastafile} -F F -j2 -o $options{runid}.blast -d $NR -v10000 -b10000 -K1000 -h0.0009 -e0.0009 -C $options{runid}.chk -Q $options{runid}.pssm",
            2,
            ["$options{runid}.chk"],
            [
                "$options{runid}.chk", "$options{runid}.blast",
                "$options{runid}.pssm",  "error.log"
            ]
        )
      )
    {
        die("chk psi-blast failed!\n");
    }
}
############################################## this is to by pass this unless and keep code continuing
unless ( &nonempty_file_exists("$options{runid}.chunkyyyy") ) {

    # parse & fortran-ify the chk matrix.
    my @chk_matrix;
    @chk_matrix = &parse_chk_file("$options{runid}.chk");
    @chk_matrix =
      &finish_chk_matrix( $sequence, @chk_matrix );
    &write_chk_file( "$options{runid}.chk", $sequence,
        @chk_matrix );
}



## parse_chk_file -- parses a PSI-BLAST binary chk file.
#
# args:  filename of chk file.
# rets:  N x 20 array containing chk weight values, where N
#        is the size of the protein that BLAST thought it saw...

sub parse_chk_file {
    my $filename = shift;
    my $buf;
    my $seqlen;
    my $seqstr;
    my $i;
    my $j;
    my @aa_order = split( //, 'ACDEFGHIKLMNPQRSTVWY' );
    my @altschul_mapping =
      ( 0, 4, 3, 6, 13, 7, 8, 9, 11, 10, 12, 2, 14, 5, 1, 15, 16, 19, 17, 18 );
    my @w;
    my @output;

    open( INPUT, $filename ) or die("Couldn't open $filename for reading.\n");

    read( INPUT, $buf, 4 ) or die("Couldn't read $filename!\n");
    $seqlen = unpack( "i", $buf );

    print_debug("Sequence length: $seqlen");

    read( INPUT, $buf, $seqlen ) or die("Premature end: $filename.\n");
    $seqstr = unpack( "a$seqlen", $buf );

    for ( $i = 0 ; $i < $seqlen ; ++$i ) {
        read( INPUT, $buf, 160 ) or die("Premature end: $filename, line: $i\n");
        @w = unpack( "d20", $buf );

        for ( $j = 0 ; $j < 20 ; ++$j ) {
            $output[$i][$j] = $w[ $altschul_mapping[$j] ];
        }
    }

    return @output;
}

## finish_chk_matrix -- "finishes" the parsed PSI-BLAST chk matrix,
##                             by adding pseudo-counts to any empty columns.
#
# args:  1) sequence string  2) array returned by parse_chk_file
# rets:  "finished" array.  suitable for printing, framing, etc.

sub finish_chk_matrix {
    my ( $s, @matrix ) = @_;
    my @sequence = split( //, $s );
    my $i;
    my $j;
    my $sum;
    my @words;
    my @b62;
    my @blos_aa =
      ( 0, 14, 11, 2, 1, 13, 3, 5, 6, 7, 9, 8, 10, 4, 12, 15, 16, 18, 19, 17 );

    my %aaNum = (
        A => 0,
        C => 1,
        D => 2,
        E => 3,
        F => 4,
        G => 5,
        H => 6,
        I => 7,
        K => 8,
        L => 9,
        M => 10,
        N => 11,
        P => 12,
        Q => 13,
        R => 14,
        S => 15,
        T => 16,
        V => 17,
        W => 18,
        Y => 19,
        X => 0
    );

    ( length($s) == scalar(@matrix) )
      or die("Length mismatch between sequence and chk file!\n");

    my $blosum62 = <<BLOSUM;
#  BLOSUM Clustered Target Frequencies=qij
#  Blocks Database = /data/blocks_5.0/blocks.dat
#  Cluster Percentage: >= 62
   A      R      N      D      C      Q      E      G      H      I      L      K      M      F      P      S      T      W      Y      V
0.0215
0.0023 0.0178
0.0019 0.0020 0.0141
0.0022 0.0016 0.0037 0.0213
0.0016 0.0004 0.0004 0.0004 0.0119
0.0019 0.0025 0.0015 0.0016 0.0003 0.0073
0.0030 0.0027 0.0022 0.0049 0.0004 0.0035 0.0161
0.0058 0.0017 0.0029 0.0025 0.0008 0.0014 0.0019 0.0378
0.0011 0.0012 0.0014 0.0010 0.0002 0.0010 0.0014 0.0010 0.0093
0.0032 0.0012 0.0010 0.0012 0.0011 0.0009 0.0012 0.0014 0.0006 0.0184
0.0044 0.0024 0.0014 0.0015 0.0016 0.0016 0.0020 0.0021 0.0010 0.0114 0.0371
0.0033 0.0062 0.0024 0.0024 0.0005 0.0031 0.0041 0.0025 0.0012 0.0016 0.0025 0.0161
0.0013 0.0008 0.0005 0.0005 0.0004 0.0007 0.0007 0.0007 0.0004 0.0025 0.0049 0.0009 0.0040
0.0016 0.0009 0.0008 0.0008 0.0005 0.0005 0.0009 0.0012 0.0008 0.0030 0.0054 0.0009 0.0012 0.0183
0.0022 0.0010 0.0009 0.0012 0.0004 0.0008 0.0014 0.0014 0.0005 0.0010 0.0014 0.0016 0.0004 0.0005 0.0191
0.0063 0.0023 0.0031 0.0028 0.0010 0.0019 0.0030 0.0038 0.0011 0.0017 0.0024 0.0031 0.0009 0.0012 0.0017 0.0126
0.0037 0.0018 0.0022 0.0019 0.0009 0.0014 0.0020 0.0022 0.0007 0.0027 0.0033 0.0023 0.0010 0.0012 0.0014 0.0047 0.0125
0.0004 0.0003 0.0002 0.0002 0.0001 0.0002 0.0003 0.0004 0.0002 0.0004 0.0007 0.0003 0.0002 0.0008 0.0001 0.0003 0.0003 0.0065
0.0013 0.0009 0.0007 0.0006 0.0003 0.0007 0.0009 0.0008 0.0015 0.0014 0.0022 0.0010 0.0006 0.0042 0.0005 0.0010 0.0009 0.0009 0.0102
0.0051 0.0016 0.0012 0.0013 0.0014 0.0012 0.0017 0.0018 0.0006 0.0120 0.0095 0.0019 0.0023 0.0026 0.0012 0.0024 0.0036 0.0004 0.0015 0.0196
BLOSUM

    $i = 0;
    my @blosum62 = split( /\n/, $blosum62 );

    # read/build the blosum matrix
    foreach my $blosumline (@blosum62) {
        next if ( $blosumline !~ /^\d/ );
        chomp $blosumline;
        @words = split( /\s/, $blosumline );

        for ( $j = 0 ; $j <= $#words ; ++$j ) {
            $b62[ $blos_aa[$i] ][ $blos_aa[$j] ] = $words[$j];
            $b62[ $blos_aa[$j] ][ $blos_aa[$i] ] = $words[$j];
        }

        ++$i;
    }

    # normalize the blosum matrix so that each row sums to 1.0
    for ( $i = 0 ; $i < 20 ; ++$i ) {
        $sum = 0.0;

        for ( $j = 0 ; $j < 20 ; ++$j ) {
            $sum += $b62[$i][$j];
        }

        for ( $j = 0 ; $j < 20 ; ++$j ) {
            $b62[$i][$j] = ( $b62[$i][$j] / $sum );
        }
    }

    # substitute appropriate blosum row for 0 rows
    for ( $i = 0 ; $i <= $#matrix ; ++$i ) {
        $sum = 0;

        for ( $j = 0 ; $j < 20 ; ++$j ) {
            $sum += $matrix[$i][$j];
        }

        if ( $sum == 0 ) {
            for ( $j = 0 ; $j < 20 ; ++$j ) {
                $matrix[$i][$j] = $b62[ $aaNum{ $sequence[$i] } ][$j];
            }
        }
    }

    return @matrix;
}

sub write_chk_file {
    my ( $filename, $sequence, @matrix ) = @_;
    my $row;
    my $col;
    my @seq = split( //, $sequence );

    open( OUTPUT, ">$filename" );

    die("Length mismatch between sequence and chk matrix!\n")
      unless ( length($sequence) == scalar(@matrix) );

    print OUTPUT scalar(@matrix), "\n";

    for ( $row = 0 ; $row <= $#matrix ; ++$row ) {
        print OUTPUT "$seq[$row] ";
        for ( $col = 0 ; $col < 20 ; ++$col ) {
            printf OUTPUT "%6.4f ", $matrix[$row][$col];
        }
        print OUTPUT "\n";
    }

    print OUTPUT "END";

    close(OUTPUT);
}
sub read_fasta {
    my $fn = shift;

    open( SEQFILE, $fn ) or die "Error opening fasta file $fn!\n";
    my $has_comment = 0;
    my $eof;
    my $seq = '';
    while ( my $line = <SEQFILE> ) {
        $eof = $line;
        $line =~ s/\s//g;
        if ( $line =~ /^>/ ) {
            $has_comment = 1;
        }
        else {
            chomp $line;
            $seq .= $line;
        }
    }

    my $has_eof = ( $eof =~ /\n$/ );
    ( $has_comment && $has_eof )
      or die
      "fasta file (given $fn) must have a comment and end with a new line!\n";
    close SEQFILE or die $!;

    return $seq;
}
# getCommandLineOptions()
# rets: \%opts  pointer to hash of kv pairs of command line options
sub getCommandLineOptions {
    use Getopt::Long;

    my $usage =
      qq{usage: $0  [-rundir <full path to run directory (default = ./)>
		\t-verbose  specify for chatty output
		\t-id  <5 character pdb code/chain id, e.g. 1tum_>
		\t-csbuild_profile Generate sequence profile via csbuild, rather than psiblast.
		\t-nopsipred  don\'t run psipred. (run by default)
		\t-sam  run sam.
		\t-porter  run porter.
		\t-nohoms  specify to omit homologs from search
		\t-exclude_homologs_by_pdb_date <mm/dd/yy or yyyymmdd>
		\t-psipredfile  <path to file containing psipred ss prediction>
		\t-samfile  <path to file containing sam ss prediction>
		\t-porterfile  <path to file containing porter ss prediction>
		\t-nocleanup  specify to keep all the temporary files
		\t-add_vall_files <vall1,vall2,...> add extra Vall files
		\t-use_vall_files <vall1,vall2,...> use only the following Vall files
		\t-add_pdbs_to_vall <codechain,codechain,...> add extra pdb Vall files
		\t-frag_sizes <size1,size2,...n>
		\t-n_frags <number of fragments>
		\t-n_candidates <number of candidates>
		\t-nofrags specify to not make fragments but run everything else
		\t-old_name_format  use old name format e.g. aa1tum_05.200_v1_3
		\t<fasta file>
	};
    $usage = "$usage\n\n" . join ' ', ( 'Version:', VERSION, "\n" );

    # Get args
    my %opts;
    &GetOptions(
        \%opts,             "psipred!", "csbuild_profile!",
        "sam!",             "homs!",
        "frags!",           "porter!",
        "psipredfile=s",    "samfile=s",
        "porterfile=s",     "verbose!",
        "rundir=s",         "id=s",
        "cleanup!",         "frag_sizes=s",
        "n_frags=i",        "n_candidates=i",
        "add_vall_files=s", "use_vall_files=s",
        "torsion_bin=s",    "exclude_homologs_by_pdb_date=s",
        "old_name_format!", "add_pdbs_to_vall=s"
    );

    if ( scalar(@ARGV) != 1 ) {
        die "$usage\n";
    }

    $opts{f} = $ARGV[0];

    if ( $opts{f} =~ /[^\w\.\/]/ ) {
        die(
"Only alphanumeric characters, . and _ are allowed in the filename.\n"
        );
    }

    &chkExist( "f", $opts{f} );
    if ( defined $opts{frag_sizes} && $opts{frag_sizes} !~ /^[\d\,]+$/ ) {
        die "Fragment sizes are invalid\n";
    }

    if (wantarray) { return %opts; }
    return \%opts;
}
sub chkExist {
    my ( $type, $path ) = @_;
    if ( $type eq 'd' ) {
        if ( !-d $path ) {
            print STDERR "$0: dirnotfound: $path\n";
            exit -3;
        }
    }
    elsif ( $type eq 'f' ) {
        if ( !-f $path ) {
            print STDERR "$0: filenotfound: $path\n";
            exit -3;
        }
        elsif ( !-s $path ) {
            print STDERR "$0: emptyfile: $path\n";
            exit -3;
        }
    }
}

sub nonempty_file_exists {
    my $file = shift;
    return ( -f $file && !-z $file );
}
sub print_debug {
    if ( $options{DEBUG} ) {
        foreach my $line (@_) {
            print "$line\n";
        }
    }
}
sub try_try_again {
    my ( $cmd, $max_tries, $success_files, $cleanup_files ) = @_;
    my $try_count     = 0;
    my $missing_files = 1;
    my $f;

    # if at first you don't succeed in running $cmd, try, try again.
    while ( ( $try_count < $max_tries ) && ( $missing_files > 0 ) ) {
        sleep 10;
        &run( $cmd, @$cleanup_files );
        ++$try_count;

        $missing_files = 0;

        foreach $f (@$success_files) {
            if ( !&nonempty_file_exists($f) ) {
                ++$missing_files;
            }
        }
    }

    # but if you've tried $max_tries times, give up.
    # there's no use being a damn fool about things.
    if ( $missing_files > 0 ) {
        return 0;
    }

    return 1;
}

sub run {
    my ( $cmd, @files ) = @_;
    my $pid;

    print_debug("cmd is: $cmd");

  FORK: {
        if ( $pid = fork ) {

            # parent
            local $SIG{TERM} = sub {
                kill 9, $pid;
                `rm -f @files`;
                exit;
            };

            local $SIG{INT} = sub {
                kill 9, $pid;
                `rm -f @files`;
                exit;
            };

            wait;

            return $?;
        }
        elsif ( defined $pid ) {

            # child process
            exec($cmd);
        }
        elsif ( $! =~ /No more process/ ) {

            # recoverable error
            sleep 5;
            redo FORK;
        }
        else {

            # unrecoverable error
            die("couldn't fork: $!\n");
        }
    }
}
