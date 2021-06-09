#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ansic1
#$ -S /bin/bash
#$ -o Ansic1.log
#$ -e Ansic1.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Absic1/
python ../AbInitio_Analysis.py D 1 92 ../sic1_STD.pdb Absic1_*/
