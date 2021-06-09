#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An5cro
#$ -S /bin/bash
#$ -o An5cro.log
#$ -e An5cro.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab5cro/
python ../AbInitio_Analysis.py O 1 61 ../5cro_STD.pdb Ab5cro_*/
