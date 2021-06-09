#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1ejf
#$ -S /bin/bash
#$ -o An1ejf.log
#$ -e An1ejf.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1ejf/
python ../AbInitio_Analysis.py P 1 110 ../1ejf_STD.pdb Ab1ejf_*/
