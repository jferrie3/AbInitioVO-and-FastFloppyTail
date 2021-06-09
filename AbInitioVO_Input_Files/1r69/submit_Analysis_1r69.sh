#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1r69
#$ -S /bin/bash
#$ -o An1r69.log
#$ -e An1r69.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1r69/
python ../AbInitio_Analysis.py O 1 63 ../1r69_STD.pdb Ab1r69_*/
