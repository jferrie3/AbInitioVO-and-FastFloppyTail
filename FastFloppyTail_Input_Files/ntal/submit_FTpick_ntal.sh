#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FTntal
#$ -S /bin/bash
#$ -o FTntal.log
#$ -e FTntal.error
#$ -l h_rt=900:00:00
#$ -t 1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @ntal.self.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @ntal.best.flags