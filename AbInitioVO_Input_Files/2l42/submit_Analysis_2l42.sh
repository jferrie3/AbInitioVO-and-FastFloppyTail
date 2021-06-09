#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An2l42
#$ -S /bin/bash
#$ -o An2l42.log
#$ -e An2l42.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab2l42/
python ../AbInitio_Analysis.py P 14 90 ../2l42_STD.pdb Ab2l42_*/
