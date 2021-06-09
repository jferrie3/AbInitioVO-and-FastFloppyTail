#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB2l42
#$ -S /bin/bash
#$ -o FpB2l42.log
#$ -e FpB2l42.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @2l42.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @2l42_dcor.best.flags
