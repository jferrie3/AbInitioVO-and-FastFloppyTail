#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Andsh3
#$ -S /bin/bash
#$ -o Andsh3.log
#$ -e Andsh3.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Abdsh3/
python ../AbInitio_Analysis.py D 1 59 ../dsh3_STD.pdb Abdsh3_*/
