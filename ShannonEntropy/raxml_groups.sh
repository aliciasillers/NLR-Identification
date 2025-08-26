#!/bin/bash
#
#SBATCH --job-name=raxml
#SBATCH --ntasks=60 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=100G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=raxml_groups.out # File to which STDOUT will be written
#SBATCH --error=raxml_groups.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4-00:00:00
#SBATCH --array=1-10

module load conda
conda activate entropy

prefix=$(ls Groups/entgrp*.aln.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | awk -F'[.]' '{print $1}')

raxml-ng --all --msa $prefix.raxml.rba --model LG+G4+F --prefix $prefix --threads 30 --seed 2 --bs-trees autoMRE
