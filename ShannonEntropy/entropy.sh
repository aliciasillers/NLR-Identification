#!/bin/bash
#
#SBATCH --job-name=entropy
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=entropy.out # File to which STDOUT will be written
#SBATCH --error=entropy.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00
#SBATCH --array=1-31

module load conda/latest
conda activate nlrenv

file=$(ls Groups/*.aln.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)

Rscript --vanilla --verbose entropy.R $file
