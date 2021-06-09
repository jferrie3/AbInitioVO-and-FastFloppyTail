#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Abpaaa
#$ -S /bin/bash
#$ -o Abpaaa.log
#$ -e Abpaaa.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Abpaaa/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp paaa.fasta.txt $targetdir
cp paaa.diso $targetdir
cp paaa_dcor_frags.200.9mers $targetdir
cp paaa_dcor_frags.200.3mers $targetdir
cp paaa_frags.200.9mers $targetdir
cp paaa_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in paaa.fasta.txt -abinitiovo -abnstruct 2 -diso paaa.diso -t_frag paaa_dcor_frags.200.3mers -n_frag paaa_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in paaa.fasta.txt -abnstruct 2 -diso paaa.diso -t_frag paaa_frags.200.3mers -n_frag paaa_frags.200.9mers -relnstruct 2 > /dev/null
