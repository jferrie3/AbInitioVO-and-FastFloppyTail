## HOW TO RUN ##
### run BlastingForPSSM.py -in INPUT.FASTA -out OUTPUT_NAME -db DATABASE LOCATION
#### The last two flags are optional with defaults that can be changed

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
args = parser.parse_args()

### PerformBlast: Performs a BLAST search on the linker sequence ###
def PerformBlast(input_fasta):
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