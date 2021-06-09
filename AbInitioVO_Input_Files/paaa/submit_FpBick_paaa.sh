#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpBpaaa
#$ -S /bin/bash
#$ -o FpBpaaa.log
#$ -e FpBpaaa.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @paaa.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @paaa_dcor.best.flags
