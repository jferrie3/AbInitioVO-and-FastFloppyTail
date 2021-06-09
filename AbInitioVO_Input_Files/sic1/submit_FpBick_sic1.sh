#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpBsic1
#$ -S /bin/bash
#$ -o FpBsic1.log
#$ -e FpBsic1.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @sic1.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @sic1_dcor.best.flags
