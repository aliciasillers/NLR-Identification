#!/bin/bash
#
#SBATCH --job-name=nlrgeneclass
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=nlrgeneclass.out # File to which STDOUT will be written
#SBATCH --error=nlrgeneclass.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=12:00:00
#SBATCH --array=1-5

module load conda/latest
conda activate nlrenv

script=$(ls *geneclass.R | sed -n ${SLURM_ARRAY_TASK_ID}p)

Rscript --vanilla --verbose $script
