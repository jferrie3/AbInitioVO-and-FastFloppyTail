#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1d7q
#$ -S /bin/bash
#$ -o An1d7q.log
#$ -e An1d7q.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1d7q/
python ../AbInitio_Analysis.py P 27 115 ../1d7q_STD.pdb Ab1d7q_*/
