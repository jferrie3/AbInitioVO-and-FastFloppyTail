#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB1enh
#$ -S /bin/bash
#$ -o FpB1enh.log
#$ -e FpB1enh.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1enh.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1enh_dcor.best.flags
