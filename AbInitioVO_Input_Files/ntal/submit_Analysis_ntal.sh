#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Anntal
#$ -S /bin/bash
#$ -o Anntal.log
#$ -e Anntal.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Abntal/
python ../AbInitio_Analysis.py D 1 125 ../ntal_STD.pdb Abntal_*/
