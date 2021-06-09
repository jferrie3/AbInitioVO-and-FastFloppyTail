#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1ghc
#$ -S /bin/bash
#$ -o An1ghc.log
#$ -e An1ghc.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1ghc/
python ../AbInitio_Analysis.py P 41 114 ../1ghc_STD.pdb Ab1ghc_*/
