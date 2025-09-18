#!/bin/bash
#
#SBATCH --job-name=refine
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=24G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=refine.out # File to which STDOUT will be written
#SBATCH --error=refine.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

module load conda/latest
conda activate entropy

Rscript --vanilla --verbose CL_AutoRefine.R -d Groups/ -p eco.tsv -e 5 -t 2
