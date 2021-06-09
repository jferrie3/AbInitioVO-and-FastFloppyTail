#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1b3a
#$ -S /bin/bash
#$ -o Ab1b3a.log
#$ -e Ab1b3a.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1b3a/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1b3a.fasta.txt $targetdir
cp 1b3a.diso $targetdir
cp 1b3a_dcor_frags.200.9mers $targetdir
cp 1b3a_dcor_frags.200.3mers $targetdir
cp 1b3a_frags.200.9mers $targetdir
cp 1b3a_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1b3a.fasta.txt -abinitiovo -abnstruct 2 -diso 1b3a.diso -t_frag 1b3a_dcor_frags.200.3mers -n_frag 1b3a_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1b3a.fasta.txt -abnstruct 2 -diso 1b3a.diso -t_frag 1b3a_frags.200.3mers -n_frag 1b3a_frags.200.9mers -relnstruct 2 > /dev/null
