#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFTdsh3
#$ -S /bin/bash
#$ -o FFTdsh3.log
#$ -e FFTdsh3.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd FloppyTail
targetdir="FFTdsh3/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FastFloppyTail.py $targetdir
chmod +x $targetdir/*
cp dsh3.fasta.txt $targetdir
cp dsh3.best.diso $targetdir
cp dsh3_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FastFloppyTail.py -in dsh3.fasta.txt -ftnstruct 500 -diso dsh3.best.diso -t_frag dsh3_best_frags.200.3mers > /dev/null


# Setup Output dir
cd FloppyTail
targetdir="FTdsh3/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FloppyTail.py $targetdir
chmod +x $targetdir/*
cp dsh3.fasta.txt $targetdir
cp dsh3.best.diso $targetdir
cp dsh3_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FloppyTail.py -in dsh3.fasta.txt -ftnstruct 400 -diso dsh3.best.diso -t_frag dsh3_best_frags.200.3mers > /dev/null