#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFAdsh3
#$ -S /bin/bash
#$ -o FFAdsh3.log
#$ -e FFAdsh3.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTdsh3/
python ../FloppyTail_Analysis.py D 1 140 ../dsh3_STD.pdb FFTdsh3_*/
cd ../FTdsh3/
python ../FloppyTail_Analysis.py D 1 140 ../dsh3_STD.pdb FTdsh3_*/