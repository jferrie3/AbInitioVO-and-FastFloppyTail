#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFTsic1
#$ -S /bin/bash
#$ -o FFTsic1.log
#$ -e FFTsic1.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd FloppyTail
targetdir="FFTsic1/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FastFloppyTail.py $targetdir
chmod +x $targetdir/*
cp sic1.fasta.txt $targetdir
cp sic1.best.diso $targetdir
cp sic1_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FastFloppyTail.py -in sic1.fasta.txt -ftnstruct 500 -diso sic1.best.diso -t_frag sic1_best_frags.200.3mers > /dev/null


# Setup Output dir
cd FloppyTail
targetdir="FTsic1/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FloppyTail.py $targetdir
chmod +x $targetdir/*
cp sic1.fasta.txt $targetdir
cp sic1.best.diso $targetdir
cp sic1_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FloppyTail.py -in sic1.fasta.txt -ftnstruct 400 -diso sic1.best.diso -t_frag sic1_best_frags.200.3mers > /dev/null