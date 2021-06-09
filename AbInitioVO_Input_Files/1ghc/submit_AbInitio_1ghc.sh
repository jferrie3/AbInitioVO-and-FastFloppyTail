#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Ab1ghc
#$ -S /bin/bash
#$ -o Ab1ghc.log
#$ -e Ab1ghc.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Ab1ghc/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp 1ghc.fasta.txt $targetdir
cp 1ghc.diso $targetdir
cp 1ghc_dcor_frags.200.9mers $targetdir
cp 1ghc_dcor_frags.200.3mers $targetdir
cp 1ghc_frags.200.9mers $targetdir
cp 1ghc_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in 1ghc.fasta.txt -abinitiovo -abnstruct 2 -diso 1ghc.diso -t_frag 1ghc_dcor_frags.200.3mers -n_frag 1ghc_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in 1ghc.fasta.txt -abnstruct 2 -diso 1ghc.diso -t_frag 1ghc_frags.200.3mers -n_frag 1ghc_frags.200.9mers -relnstruct 2 > /dev/null
