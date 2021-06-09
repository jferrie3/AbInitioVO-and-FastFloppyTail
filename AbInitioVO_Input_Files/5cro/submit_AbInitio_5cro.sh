#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab5cro
#$ -S /bin/bash
#$ -o Ab5cro.log
#$ -e Ab5cro.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab5cro/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 5cro.fasta.txt $targetdir
cp 5cro.diso $targetdir
cp 5cro_dcor_frags.200.9mers $targetdir
cp 5cro_dcor_frags.200.3mers $targetdir
cp 5cro_frags.200.9mers $targetdir
cp 5cro_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 5cro.fasta.txt -abinitiovo -abnstruct 2 -diso 5cro.diso -t_frag 5cro_dcor_frags.200.3mers -n_frag 5cro_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 5cro.fasta.txt -abnstruct 2 -diso 5cro.diso -t_frag 5cro_frags.200.3mers -n_frag 5cro_frags.200.9mers -relnstruct 2 > /dev/null
