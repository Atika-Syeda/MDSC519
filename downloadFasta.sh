#! /usr/bin/env bash
#BSUB -J fastaDowload
#BSUB -n 12
#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=80000]"
#BSUB -M 100000
#BSUB -We 01:00
#BSUB -W 12:00
#BSUB -o test_%J.out
#BSUB -e test_%J.err

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/036/025/GCA_900036025.1_v1.0/GCA_900036025.1_v1.0_genomic.fna.gz
