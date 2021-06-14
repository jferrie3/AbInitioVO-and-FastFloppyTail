#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N FFRpaaa
#$ -S /bin/bash
#$ -o FFRpaaa.log
#$ -e FFRpaaa.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion
    
# Execute Script
cd FloppyTail/
targetdir="FFTpaaa/FloppyTail_Relaxed_${SGE_TASK_ID}"
mkdir -p $targetdir
targetscript="FloppyTail_Relax_${SGE_TASK_ID}.py"
sed -e 's/FOLDERNUMBER/'"${SGE_TASK_ID}"'/g' < FloppyTail_Relax.py > $targetdir/$targetscript
chmod +x $targetdir/*
cd $targetdir

python $targetscript

targetdir="FTpaaa/FloppyTail_Relaxed_${SGE_TASK_ID}"
mkdir -p $targetdir
targetscript="FloppyTail_Relax_${SGE_TASK_ID}.py"
sed -e 's/FOLDERNUMBER/'"${SGE_TASK_ID}"'/g' < FloppyTail_Relax.py > $targetdir/$targetscript
chmod +x $targetdir/*
cd $targetdir

python $targetscript