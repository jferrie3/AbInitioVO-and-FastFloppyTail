#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpBdsh3
#$ -S /bin/bash
#$ -o FpBdsh3.log
#$ -e FpBdsh3.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @dsh3.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @dsh3_dcor.best.flags
