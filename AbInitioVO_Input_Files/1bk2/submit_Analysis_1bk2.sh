#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1bk2
#$ -S /bin/bash
#$ -o An1bk2.log
#$ -e An1bk2.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1bk2/
python ../AbInitio_Analysis.py O 1 57 ../1bk2_STD.pdb Ab1bk2_*/
