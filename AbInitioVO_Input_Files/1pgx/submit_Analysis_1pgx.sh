#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1pgx
#$ -S /bin/bash
#$ -o An1pgx.log
#$ -e An1pgx.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1pgx/
python ../AbInitio_Analysis.py O 1 70 ../1pgx_STD.pdb Ab1pgx_*/
