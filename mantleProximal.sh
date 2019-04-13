# /usr/bin/env bash

#BSUB -J manProximal
#BSUB -n 12
#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=80000]"
#BSUB -M 100000
#BSUB -We 01:00
#BSUB -W 12:00
#BSUB -o test_%J.out
#BSUB -e test_%J.err

fastq-dump --split-files SRR6336932
