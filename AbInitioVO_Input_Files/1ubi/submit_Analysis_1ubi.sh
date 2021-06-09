#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1ubi
#$ -S /bin/bash
#$ -o An1ubi.log
#$ -e An1ubi.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1ubi/
python ../AbInitio_Analysis.py O 1 76 ../1ubi_STD.pdb Ab1ubi_*/
