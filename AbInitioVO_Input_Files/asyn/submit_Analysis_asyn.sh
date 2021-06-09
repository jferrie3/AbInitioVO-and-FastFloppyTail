#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Anasyn
#$ -S /bin/bash
#$ -o Anasyn.log
#$ -e Anasyn.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Abasyn/
python ../AbInitio_Analysis.py D 1 140 ../asyn_STD.pdb Abasyn_*/
