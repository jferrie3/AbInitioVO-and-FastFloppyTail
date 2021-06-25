## HOW TO RUN ##
### run BlastingForPSSM.py -in INPUT.FASTA -out OUTPUT_NAME -db DATABASE LOCATION
#### The last two flags are optional with defaults that can be changed

'''
In the original make_fragment.pl the command for running PSIBLAST is as follows:
"$PSIBLAST 
-t 1 (Uses composition-based statistics. With this set to T, the score is adjusted based on composition biases in the query and subject sequences. Using it helps avoid possible corruption of the PSSM because it introduces low-entropy false positives in the multiple sequence alignment.  )
-i $options{fastafile} 
-F F (Filters the query sequence)
-j2 (number of rounds)
-o $options{runid}.blast 
-d $NR 
-v10000 (The number of one-line descriptions to show)
#-b10000 (the multiple-hit window size)
-K1000  (number of best hit from a region to keep)
#-h0.0009 ( is the e-value threshold for including sequences in the score matrix model (default 0.001) )
#-e0.0009  (the expectation value)
-C $options{runid}.chk 
-Q $options{runid}.pssm"
'''

### BIOPYTHON IMPORTS ###
from Bio.Blast.Applications import NcbipsiblastCommandline as psiblast
### GENERAL PYTHON IMPORTS ###
import multiprocessing
import argparse

## ARGUEMENT PARSER ##
parser = argparse.ArgumentParser(description='Program')
parser.add_argument('-in', '--Input_FASTA', action='store', type=str, required=True,
	help='FASTA sequence of the protein of interest')
parser.add_argument('-out', '--Output_Name', action='store', type=str, required=False,
	help='FASTA sequence of the protein of interest')
parser.add_argument('-db', '--Blast_Database_Location', action='store', type=str, required=False,
	default='/mnt/e/Blast/nr', help='Location of the database you want to blast against')
parser.add_argument('-legacy', '--Blastpgp_Legacy_Settings', action='store_true', required=False,
	default=False, help='Uses settings for Blast search from the original make_fragments.pl script')
args = parser.parse_args()

### PerformBlast: Performs a BLAST search on the linker sequence ###
def PerformBlast(input_fasta):
	if args.Blastpgp_Legacy_Settings:
		psiblast_cline = psiblast(cmd = 'psiblast',\
		db = args.Blast_Database_Location,\
		query = input_fasta,\
		evalue = 0.0009,\
		inclusion_ethresh = 0.0009,\
		max_hsps = 10000,\
		num_alignments = 100000,\
		num_descriptions = 10000,\
		num_iterations = 2,\
		num_threads = int(multiprocessing.cpu_count()/2),\
		outfmt = 6,\
		out = output_name+'.psi',\
		out_pssm = output_name+'.pssm',\
		out_ascii_pssm = output_name+'.ascii.pssm',\
		save_pssm_after_last_round = True,\
		show_gis = True,\
		window_size = 10000)
		stdout, stderr = psiblast_cline()
	else:
		psiblast_cline = psiblast(cmd = 'psiblast',\
		db = args.Blast_Database_Location,\
		query = input_fasta,\
		evalue = 0.000001,\
		inclusion_ethresh = 0.000001,\
		max_hsps = 100000,\
		num_alignments = 100000,\
		num_iterations = 2,\
		num_threads = int(multiprocessing.cpu_count()/2),\
		outfmt = 6,\
		out = output_name+'.psi',\
		out_pssm = output_name+'.pssm',\
		out_ascii_pssm = output_name+'.ascii.pssm',\
		save_pssm_after_last_round = True,\
		show_gis = True)
		stdout, stderr = psiblast_cline()
	return 'Blast Complete'

### Setting a default Output Name if one isn't supplied
output_name = ''
if not args.Output_Name:
	output_name = args.Input_FASTA.split('.')[0]
else:
	output_name = args.Output_Name

bl_com_stat = PerformBlast(args.Input_FASTA)
print(bl_com_stat)