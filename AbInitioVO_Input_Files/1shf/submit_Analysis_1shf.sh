#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1shf
#$ -S /bin/bash
#$ -o An1shf.log
#$ -e An1shf.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1shf/
python ../AbInitio_Analysis.py O 1 59 ../1shf_STD.pdb Ab1shf_*/
