#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1enh
#$ -S /bin/bash
#$ -o An1enh.log
#$ -e An1enh.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1enh/
python ../AbInitio_Analysis.py O 1 54 ../1enh_STD.pdb Ab1enh_*/
