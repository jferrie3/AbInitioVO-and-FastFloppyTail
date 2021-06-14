#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFAtauk
#$ -S /bin/bash
#$ -o FFAtauk.log
#$ -e FFAtauk.error
#$ -l h_rt=900:00:00

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
cd FFTtauk/
python ../FloppyTail_Analysis.py D 1 140 ../tauk_STD.pdb FFTtauk_*/
cd ../FTtauk/
python ../FloppyTail_Analysis.py D 1 140 ../tauk_STD.pdb FTtauk_*/