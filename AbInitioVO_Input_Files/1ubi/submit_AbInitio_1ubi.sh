#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1ubi
#$ -S /bin/bash
#$ -o Ab1ubi.log
#$ -e Ab1ubi.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1ubi/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1ubi.fasta.txt $targetdir
cp 1ubi.diso $targetdir
cp 1ubi_dcor_frags.200.9mers $targetdir
cp 1ubi_dcor_frags.200.3mers $targetdir
cp 1ubi_frags.200.9mers $targetdir
cp 1ubi_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1ubi.fasta.txt -abinitiovo -abnstruct 2 -diso 1ubi.diso -t_frag 1ubi_dcor_frags.200.3mers -n_frag 1ubi_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1ubi.fasta.txt -abnstruct 2 -diso 1ubi.diso -t_frag 1ubi_frags.200.3mers -n_frag 1ubi_frags.200.9mers -relnstruct 2 > /dev/null
