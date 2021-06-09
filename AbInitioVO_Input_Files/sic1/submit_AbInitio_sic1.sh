#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Absic1
#$ -S /bin/bash
#$ -o Absic1.log
#$ -e Absic1.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Absic1/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp sic1.fasta.txt $targetdir
cp sic1.diso $targetdir
cp sic1_dcor_frags.200.9mers $targetdir
cp sic1_dcor_frags.200.3mers $targetdir
cp sic1_frags.200.9mers $targetdir
cp sic1_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in sic1.fasta.txt -abinitiovo -abnstruct 2 -diso sic1.diso -t_frag sic1_dcor_frags.200.3mers -n_frag sic1_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in sic1.fasta.txt -abnstruct 2 -diso sic1.diso -t_frag sic1_frags.200.3mers -n_frag sic1_frags.200.9mers -relnstruct 2 > /dev/null
