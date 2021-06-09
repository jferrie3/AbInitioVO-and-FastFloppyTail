# Input Files for AbInitioVO Simulations

This folder contains all of the input files necessary for running the AbInitioVO simulations
run in Ferrie et. al. JPBC. 2020

__Each folder includes:__

-XXXX.best.flags - file for running non-corrected fragment selection
-XXXX.chk - output file from BLAST search used as FragmentPicker input
-XXXX.dcor.ppred.ss2 - disorder corrected SS2 generated from the PsiPred prediction server
-XXXX.diso - disorder probability prediction file from RaptorX
-XXXX.fasta.txt - FASTA sequence of protein
-XXXX.flags
-XXXX.ncor.ppred.ss2 - disorder corrected SS2 generated from the PsiPred prediction server
-XXXX_dcor.best.flags - file for running disorder probability corrected fragment selection
-XXXX_STD.pdb - numbering and format adjusted PDB file compatible with AbInitio_Analysis.py
-AbInitio_Analysis.py - script used to compare outputs to known structure
-AbInitioVO.py - script used to run AbInitioVO
-best-protocol.wghts - Weights file used by FragmentPicker for Best Protocol fragment selection
-psipred.ss2 - PsiPred server output SS2 file
-submit_AbInitio_XXXX.sh - shell script for submitting AbInitio/AbInitioVO to server (contains run command)
-submit_Analysis.XXXX.sh - shell script for submitting AbInitio_Analaysis to server (contains run command)
-submit_FpBick_XXXX.sh - shell script for submitting FragmentPicking to server (contains run command)

__Additional files in folder used in testing but not used in the final method:__
-A folder containing the outputs from the RaptorX server
-XXXX.blast - output file from BLAST search
-XXXX.dcor.jufo.ss2 - disorder corrected SS2 generated from the Jufo prediction server
-XXXX.dcor.rapx.ss2 - disorder corrected SS2 generated from the RaptorX prediction server
-XXXX.flags - file for running Quota-based fragment selection, which was non-optimal for this task
-XXXX.ncor.jufo.ss2 - disorder corrected SS2 generated from the Jufo prediction server
-XXXX.ncor.rapx.ss2 - disorder corrected SS2 generated from the RaptorX prediction server
-XXXX.pdb - the structure filed downloaded from the PDB
-XXXX.pssm - output file from BLAST search which can be used in place of .chk
-juso.ss2 - Jufo server output SS2 file
-raptorx.ss2 - RaptorX server output SS2 file