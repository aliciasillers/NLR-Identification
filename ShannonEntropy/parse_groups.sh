#!/bin/bash
#
#SBATCH --job-name=parse
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=parse.out # File to which STDOUT will be written
#SBATCH --error=parse.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=12:00:00
#SBATCH --array=1-10

module load conda
conda activate entropy

file=$(ls Groups/entgrp*.aln.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
prefix=$(ls Groups/entgrp*.aln.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | awk -F'[.]' '{print $1}')

raxml-ng --parse --msa $file --model LG+G4+F --prefix $prefix
