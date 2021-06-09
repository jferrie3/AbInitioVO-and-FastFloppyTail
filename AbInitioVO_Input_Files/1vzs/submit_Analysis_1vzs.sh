#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1vzs
#$ -S /bin/bash
#$ -o An1vzs.log
#$ -e An1vzs.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1vzs/
python ../AbInitio_Analysis.py P 1 49 ../1vzs_STD.pdb Ab1vzs_*/
