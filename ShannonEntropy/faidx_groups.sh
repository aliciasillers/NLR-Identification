#!/bin/bash
#
#SBATCH --job-name=faidx
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=faidx.out # File to which STDOUT will be written
#SBATCH --error=faidx.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00
#SBATCH --array=1-10

module load samtools

file=$(ls Groups/entgrp.*.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
prefix=$(ls Groups/entgrp.*.txt | sed -n ${SLURM_ARRAY_TASK_ID}p | awk -F'[.]' '{print $1$2}')

samtools faidx -c -r $file allaaseqs.fa -o $prefix.fa
