#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1hz6
#$ -S /bin/bash
#$ -o Ab1hz6.log
#$ -e Ab1hz6.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1hz6/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1hz6.fasta.txt $targetdir
cp 1hz6.diso $targetdir
cp 1hz6_dcor_frags.200.9mers $targetdir
cp 1hz6_dcor_frags.200.3mers $targetdir
cp 1hz6_frags.200.9mers $targetdir
cp 1hz6_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1hz6.fasta.txt -abinitiovo -abnstruct 2 -diso 1hz6.diso -t_frag 1hz6_dcor_frags.200.3mers -n_frag 1hz6_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1hz6.fasta.txt -abnstruct 2 -diso 1hz6.diso -t_frag 1hz6_frags.200.3mers -n_frag 1hz6_frags.200.9mers -relnstruct 2 > /dev/null
