#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Antauk
#$ -S /bin/bash
#$ -o Antauk.log
#$ -e Antauk.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Abtauk/
python ../AbInitio_Analysis.py D 1 130 ../tauk_STD.pdb Abtauk_*/
