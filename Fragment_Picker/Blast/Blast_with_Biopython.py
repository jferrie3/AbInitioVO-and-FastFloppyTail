### BIOPYTHON IMPORTS ###
from Bio.Blast.Applications import NcbipsiblastCommandline as psiblast

### PerformBlast: Performs a BLAST search on the linker sequence ###
def PerformBlast(fusion_sequence):
	psiblast_cline = psiblast(cmd = 'psiblast',\
	db = BLAST_DATABASE_LOCATION,\
	query = args.Output_Name + '.fasta',\
	evalue = 0.000001,\
	inclusion_ethresh = 0.000001,\
	max_hsps = 100000,\
	num_alignments = 100000,\
	num_iterations = 2,\
	num_threads = int(multiprocessing.cpu_count()/2),\
	outfmt = 6,\
	out = args.Output_Name+'.psi',\
	out_pssm = args.Output_Name+'.pssm',\
	out_ascii_pssm = args.Output_Name+'.ascii.pssm',\
	save_pssm_after_last_round = True,\
	show_gis = True)
	stdout, stderr = psiblast_cline()
	return 'Blast Complete'
	
bl_com_stat = PerformBlast(FLseq)
	