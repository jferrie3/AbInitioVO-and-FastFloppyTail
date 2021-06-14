#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFTntal
#$ -S /bin/bash
#$ -o FFTntal.log
#$ -e FFTntal.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd FloppyTail
targetdir="FFTntal/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FastFloppyTail.py $targetdir
chmod +x $targetdir/*
cp ntal.fasta.txt $targetdir
cp ntal.best.diso $targetdir
cp ntal_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FastFloppyTail.py -in ntal.fasta.txt -ftnstruct 500 -diso ntal.best.diso -t_frag ntal_best_frags.200.3mers > /dev/null


# Setup Output dir
cd FloppyTail
targetdir="FTntal/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp FloppyTail.py $targetdir
chmod +x $targetdir/*
cp ntal.fasta.txt $targetdir
cp ntal.best.diso $targetdir
cp ntal_best_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python FloppyTail.py -in ntal.fasta.txt -ftnstruct 400 -diso ntal.best.diso -t_frag ntal_best_frags.200.3mers > /dev/null