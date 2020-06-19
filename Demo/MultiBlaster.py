## Run as: run MultiBlaster.py Input_files/*/*.fasta.txt
import sys, os, glob

for fasta_file in sys.argv[1:]:
    print(fasta_file)
    check_file = str(fasta_file.split('.')[0] + '.chk')
    if os.path.isfile(check_file) == False:
    	#os.system('cp ' + str(fasta_file) + ' ' + str(fasta_file.split('/')[1]))
    	os.system('/mnt/f/JF_JACS_Extra/Blast_for_Checkpoint_File.pl ' + str(fasta_file.split('/')[1]))
    	for OUTPUT_file in glob.glob("OUTPUT*"):
    		os.system('mv ' + OUTPUT_file + ' ' + str(fasta_file.split('/')[0]) + '/' + str(fasta_file.split('/')[0]) + '.' + str(OUTPUT_file.split('.')[1]))
    	os.system('rm ' + str(fasta_file.split('/')[1]))