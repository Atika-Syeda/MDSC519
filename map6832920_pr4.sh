#! /usr/bin/env bash

#BSUB -J map6832920_pr4
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=80000]"
#BSUB -M 100000
#BSUB -We 01:00
#BSUB -W 12:00
#BSUB -o map6832920_pr4.out
#BSUB -e map6832920_pr4.err

STAR --runThreadN 16 --runMode alignReads --genomeDir /gpfs/home/satika/MDSC519/genDir2 --readFilesIn /gpfs/home/satika/MDSC519/SRR6832920_pr4_1.fastq --outSAMtype BAM Unsorted SortedByCoordinate
