#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFTtauk
#$ -S /bin/bash
#$ -o FFTtauk.log
#$ -e FFTtauk.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd FloppyTail
targetdir="FFTtauk/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FastFloppyTail.py $targetdir
chmod +x $targetdir/*
cp tauk.fasta.txt $targetdir
cp tauk.best.diso $targetdir
cp tauk_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FastFloppyTail.py -in tauk.fasta.txt -ftnstruct 500 -diso tauk.best.diso -t_frag tauk_best_frags.200.3mers > /dev/null


# Setup Output dir
cd FloppyTail
targetdir="FTtauk/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FloppyTail.py $targetdir
chmod +x $targetdir/*
cp tauk.fasta.txt $targetdir
cp tauk.best.diso $targetdir
cp tauk_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FloppyTail.py -in tauk.fasta.txt -ftnstruct 400 -diso tauk.best.diso -t_frag tauk_best_frags.200.3mers > /dev/null