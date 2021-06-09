#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1hz6
#$ -S /bin/bash
#$ -o An1hz6.log
#$ -e An1hz6.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1hz6/
python ../AbInitio_Analysis.py O 1 64 ../1hz6_STD.pdb Ab1hz6_*/
