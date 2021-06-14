#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FTsic1
#$ -S /bin/bash
#$ -o FTsic1.log
#$ -e FTsic1.error
#$ -l h_rt=900:00:00
#$ -t 1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared rosetta/3.9
 
# Execute Script
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @sic1.self.flags
/cm/shared/apps/rosetta/rosetta3.9/main/source/bin/fragment_picker.static.linuxgccrelease @sic1.best.flags