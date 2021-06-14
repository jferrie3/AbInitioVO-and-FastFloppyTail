#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FTasyn
#$ -S /bin/bash
#$ -o FTasyn.log
#$ -e FTasyn.error
#$ -l h_rt=900:00:00
#$ -t 1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @asyn.self.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @asyn.best.flags