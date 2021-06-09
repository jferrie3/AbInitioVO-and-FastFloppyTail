#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1shf
#$ -S /bin/bash
#$ -o Ab1shf.log
#$ -e Ab1shf.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1shf/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1shf.fasta.txt $targetdir
cp 1shf.diso $targetdir
cp 1shf_dcor_frags.200.9mers $targetdir
cp 1shf_dcor_frags.200.3mers $targetdir
cp 1shf_frags.200.9mers $targetdir
cp 1shf_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1shf.fasta.txt -abinitiovo -abnstruct 2 -diso 1shf.diso -t_frag 1shf_dcor_frags.200.3mers -n_frag 1shf_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1shf.fasta.txt -abnstruct 2 -diso 1shf.diso -t_frag 1shf_frags.200.3mers -n_frag 1shf_frags.200.9mers -relnstruct 2 > /dev/null
