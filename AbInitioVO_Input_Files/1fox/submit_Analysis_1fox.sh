#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1fox
#$ -S /bin/bash
#$ -o An1fox.log
#$ -e An1fox.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1fox/
python ../AbInitio_Analysis.py P 1 76 ../1fox_STD.pdb Ab1fox_*/
