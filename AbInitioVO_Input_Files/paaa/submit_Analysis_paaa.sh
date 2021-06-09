#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Anpaaa
#$ -S /bin/bash
#$ -o Anpaaa.log
#$ -e Anpaaa.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Abpaaa/
python ../AbInitio_Analysis.py D 1 142 ../paaa_STD.pdb Abpaaa_*/
