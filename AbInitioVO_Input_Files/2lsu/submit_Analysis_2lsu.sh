#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An2lsu
#$ -S /bin/bash
#$ -o An2lsu.log
#$ -e An2lsu.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab2lsu/
python ../AbInitio_Analysis.py P 1 89 ../2lsu_STD.pdb Ab2lsu_*/
