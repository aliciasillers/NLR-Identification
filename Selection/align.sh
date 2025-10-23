#!/bin/bash
#
#SBATCH --job-name=msa
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=30G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=align.out # File to which STDOUT will be written
#SBATCH --error=align.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00
#SBATCH --array=1-73

module load muscle

file=$(ls cluster*.fa | sed -n ${SLURM_ARRAY_TASK_ID}p)
prefix=$(ls cluster*.fa | sed -n ${SLURM_ARRAY_TASK_ID}p | awk -F'[.]' '{print $1}')

muscle -verbose -in $file -out $prefix.aln.fasta
