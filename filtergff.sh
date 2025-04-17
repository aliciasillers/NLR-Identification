#!/bin/bash
#
#SBATCH --job-name=filtergff
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=filtergff.out # File to which STDOUT will be written
#SBATCH --error=filtergff.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=8:00:00

#USAGE: filtergff.sh LISTFILE OUTPUTFILE

module load bedops

grep -f $1 ../Genome/farr1.gene_models_updated_2025-04-15.gff | grep 'mRNA' | gff2bed | awk -F'\t|=|;' '{OFS="\t"}{print $1,$2,$3,$11}' > $2

