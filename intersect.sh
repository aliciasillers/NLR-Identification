#!/bin/bash
#
#SBATCH --job-name=intersect
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=intersect.out # File to which STDOUT will be written
#SBATCH --error=intersect.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

module load bedtools2

bedtools intersect -wa -a farr1.gene_models_updated.gff -b nanl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > nanl_genes.bed

bedtools intersect -wa -a farr1.gene_models_updated.gff -b cnl.bed | grep 'gene'  | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > cnl_genes.bed

bedtools intersect -wa -a farr1.gene_models_updated.gff -b tnl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > tnl_genes.bed

bedtools intersect -wa -a farr1.gene_models_updated.gff -b xnl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > xnl_genes.bed
