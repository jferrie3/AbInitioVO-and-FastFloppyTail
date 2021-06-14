#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFAasyn
#$ -S /bin/bash
#$ -o FFAasyn.log
#$ -e FFAasyn.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTasyn/
python ../FloppyTail_Analysis.py D 1 140 ../asyn_STD.pdb FFTasyn_*/
cd ../FTasyn/
python ../FloppyTail_Analysis.py D 1 140 ../asyn_STD.pdb FTasyn_*/