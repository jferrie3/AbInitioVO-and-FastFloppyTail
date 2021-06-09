#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpBntal
#$ -S /bin/bash
#$ -o FpBntal.log
#$ -e FpBntal.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @ntal.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @ntal_dcor.best.flags
