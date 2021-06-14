#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFAsic1
#$ -S /bin/bash
#$ -o FFAsic1.log
#$ -e FFAsic1.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTsic1/
python ../FloppyTail_Analysis.py D 1 140 ../sic1_STD.pdb FFTsic1_*/
cd ../FTsic1/
python ../FloppyTail_Analysis.py D 1 140 ../sic1_STD.pdb FTsic1_*/