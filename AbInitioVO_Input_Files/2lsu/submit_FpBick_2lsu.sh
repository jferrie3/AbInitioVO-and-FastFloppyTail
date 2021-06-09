#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FpB2lsu
#$ -S /bin/bash
#$ -o FpB2lsu.log
#$ -e FpB2lsu.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
cd AbInitioVO
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @2lsu.best.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @2lsu_dcor.best.flags
