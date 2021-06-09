#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB1bk2
#$ -S /bin/bash
#$ -o FpB1bk2.log
#$ -e FpB1bk2.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1bk2.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1bk2_dcor.best.flags
