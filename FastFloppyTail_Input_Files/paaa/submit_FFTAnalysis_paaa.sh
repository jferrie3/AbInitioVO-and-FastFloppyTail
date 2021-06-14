#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFApaaa
#$ -S /bin/bash
#$ -o FFApaaa.log
#$ -e FFApaaa.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTpaaa/
python ../FloppyTail_Analysis.py D 1 140 ../paaa_STD.pdb FFTpaaa_*/
cd ../FTpaaa/
python ../FloppyTail_Analysis.py D 1 140 ../paaa_STD.pdb FTpaaa_*/