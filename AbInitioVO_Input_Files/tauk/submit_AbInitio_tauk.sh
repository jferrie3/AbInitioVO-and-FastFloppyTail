#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Abtauk
#$ -S /bin/bash
#$ -o Abtauk.log
#$ -e Abtauk.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Abtauk/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp tauk.fasta.txt $targetdir
cp tauk.diso $targetdir
cp tauk_dcor_frags.200.9mers $targetdir
cp tauk_dcor_frags.200.3mers $targetdir
cp tauk_frags.200.9mers $targetdir
cp tauk_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in tauk.fasta.txt -abinitiovo -abnstruct 2 -diso tauk.diso -t_frag tauk_dcor_frags.200.3mers -n_frag tauk_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in tauk.fasta.txt -abnstruct 2 -diso tauk.diso -t_frag tauk_frags.200.3mers -n_frag tauk_frags.200.9mers -relnstruct 2 > /dev/null
