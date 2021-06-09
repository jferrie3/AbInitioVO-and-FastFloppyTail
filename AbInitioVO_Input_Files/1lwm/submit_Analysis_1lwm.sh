#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N An1lwm
#$ -S /bin/bash
#$ -o An1lwm.log
#$ -e An1lwm.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd AbInitioVO
cd Ab1lwm/
python ../AbInitio_Analysis.py P 26 93 ../1lwm_STD.pdb Ab1lwm_*/
