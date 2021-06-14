#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFAntal
#$ -S /bin/bash
#$ -o FFAntal.log
#$ -e FFAntal.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTntal/
python ../FloppyTail_Analysis.py D 1 140 ../ntal_STD.pdb FFTntal_*/
cd ../FTntal/
python ../FloppyTail_Analysis.py D 1 140 ../ntal_STD.pdb FTntal_*/