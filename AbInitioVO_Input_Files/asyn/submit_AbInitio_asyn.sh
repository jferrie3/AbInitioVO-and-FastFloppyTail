#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Abasyn
#$ -S /bin/bash
#$ -o Abasyn.log
#$ -e Abasyn.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Abasyn/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp asyn.fasta.txt $targetdir
cp asyn.diso $targetdir
cp asyn_dcor_frags.200.9mers $targetdir
cp asyn_dcor_frags.200.3mers $targetdir
cp asyn_frags.200.9mers $targetdir
cp asyn_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in asyn.fasta.txt -abinitiovo -abnstruct 2 -diso asyn.diso -t_frag asyn_dcor_frags.200.3mers -n_frag asyn_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in asyn.fasta.txt -abnstruct 2 -diso asyn.diso -t_frag asyn_frags.200.3mers -n_frag asyn_frags.200.9mers -relnstruct 2 > /dev/null
