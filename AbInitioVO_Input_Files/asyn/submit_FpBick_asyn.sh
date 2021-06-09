#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpBasyn
#$ -S /bin/bash
#$ -o FpBasyn.log
#$ -e FpBasyn.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @asyn.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @asyn_dcor.best.flags
