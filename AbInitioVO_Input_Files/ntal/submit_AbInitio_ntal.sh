#!/bin/bash
#$ -q all.q
#$ -cwd
#$ -N Abntal
#$ -S /bin/bash
#$ -o Abntal.log
#$ -e Abntal.error
#$ -l h_rt=900:00:00
#$ -t 1-25:1

# Enable Additional Software
. /etc/profile.d/modules.sh
module unload cmsub
module load shared python/anaconda/2.4.1
source activate lion

# Setup Output dir
cd AbInitioVO
targetdir="Abntal/${JOB_NAME}_${SGE_TASK_ID}"
mkdir -p $targetdir
cp AbInitioVO.py $targetdir
chmod +x $targetdir/*
cp ntal.fasta.txt $targetdir
cp ntal.diso $targetdir
cp ntal_dcor_frags.200.9mers $targetdir
cp ntal_dcor_frags.200.3mers $targetdir
cp ntal_frags.200.9mers $targetdir
cp ntal_frags.200.3mers $targetdir
cd $targetdir
    
# Execute Script
python AbInitioVO.py -in ntal.fasta.txt -abinitiovo -abnstruct 2 -diso ntal.diso -t_frag ntal_dcor_frags.200.3mers -n_frag ntal_dcor_frags.200.9mers -relnstruct 2 > /dev/null
python AbInitioVO.py -in ntal.fasta.txt -abnstruct 2 -diso ntal.diso -t_frag ntal_frags.200.3mers -n_frag ntal_frags.200.9mers -relnstruct 2 > /dev/null
