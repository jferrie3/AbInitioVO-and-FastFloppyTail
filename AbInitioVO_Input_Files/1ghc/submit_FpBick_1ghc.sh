#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB1ghc
#$ -S /bin/bash
#$ -o FpB1ghc.log
#$ -e FpB1ghc.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1ghc.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1ghc_dcor.best.flags
