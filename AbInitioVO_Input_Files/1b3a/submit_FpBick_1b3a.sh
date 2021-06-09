#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB1b3a
#$ -S /bin/bash
#$ -o FpB1b3a.log
#$ -e FpB1b3a.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1b3a.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @1b3a_dcor.best.flags
