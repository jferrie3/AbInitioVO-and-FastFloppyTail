#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1b3a
#$ -S /bin/bash
#$ -o An1b3a.log
#$ -e An1b3a.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1b3a/
python ../AbInitio_Analysis.py O 1 67 ../1b3a_STD.pdb Ab1b3a_*/
