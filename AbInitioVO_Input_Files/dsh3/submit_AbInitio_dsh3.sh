#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Abdsh3
#$ -S /bin/bash
#$ -o Abdsh3.log
#$ -e Abdsh3.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Abdsh3/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp dsh3.fasta.txt $targetdir
cp dsh3.diso $targetdir
cp dsh3_dcor_frags.200.9mers $targetdir
cp dsh3_dcor_frags.200.3mers $targetdir
cp dsh3_frags.200.9mers $targetdir
cp dsh3_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in dsh3.fasta.txt -abinitiovo -abnstruct 2 -diso dsh3.diso -t_frag dsh3_dcor_frags.200.3mers -n_frag dsh3_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in dsh3.fasta.txt -abnstruct 2 -diso dsh3.diso -t_frag dsh3_frags.200.3mers -n_frag dsh3_frags.200.9mers -relnstruct 2 > /dev/null
