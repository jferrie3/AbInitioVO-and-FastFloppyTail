#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1pgx
#$ -S /bin/bash
#$ -o Ab1pgx.log
#$ -e Ab1pgx.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1pgx/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1pgx.fasta.txt $targetdir
cp 1pgx.diso $targetdir
cp 1pgx_dcor_frags.200.9mers $targetdir
cp 1pgx_dcor_frags.200.3mers $targetdir
cp 1pgx_frags.200.9mers $targetdir
cp 1pgx_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1pgx.fasta.txt -abinitiovo -abnstruct 2 -diso 1pgx.diso -t_frag 1pgx_dcor_frags.200.3mers -n_frag 1pgx_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1pgx.fasta.txt -abnstruct 2 -diso 1pgx.diso -t_frag 1pgx_frags.200.3mers -n_frag 1pgx_frags.200.9mers -relnstruct 2 > /dev/null
