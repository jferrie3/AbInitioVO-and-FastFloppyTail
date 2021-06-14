#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFTpaaa
#$ -S /bin/bash
#$ -o FFTpaaa.log
#$ -e FFTpaaa.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd FloppyTail
targetdir="FFTpaaa/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FastFloppyTail.py $targetdir
chmod +x $targetdir/*
cp paaa.fasta.txt $targetdir
cp paaa.best.diso $targetdir
cp paaa_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FastFloppyTail.py -in paaa.fasta.txt -ftnstruct 500 -diso paaa.best.diso -t_frag paaa_best_frags.200.3mers > /dev/null


# Setup Output dir
cd FloppyTail
targetdir="FTpaaa/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FloppyTail.py $targetdir
chmod +x $targetdir/*
cp paaa.fasta.txt $targetdir
cp paaa.best.diso $targetdir
cp paaa_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FloppyTail.py -in paaa.fasta.txt -ftnstruct 400 -diso paaa.best.diso -t_frag paaa_best_frags.200.3mers > /dev/null