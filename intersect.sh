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

bedtools intersect -wa -a ../Genome/farr1_phase1.gene_models.gff -b nanla.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > nanlgenesa.bed
bedtools intersect -wa -a ../Genome/farr1_phase2.gene_models.gff -b nanlb.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > nanlgenesb.bed
bedtools intersect -wa -a ../Genome/farr1_phase1.gene_models.gff -b cnla.bed | grep 'gene'  | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > cnlgenesa.bed
bedtools intersect -wa -a ../Genome/farr1_phase2.gene_models.gff -b cnlb.bed | grep 'gene'  | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > cnlgenesb.bed
bedtools intersect -wa -a ../Genome/farr1_phase1.gene_models.gff -b tnla.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > tnlgenesa.bed
bedtools intersect -wa -a ../Genome/farr1_phase2.gene_models.gff -b tnlb.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > tnlgenesb.bed
bedtools intersect -wa -a ../Genome/farr1_phase1.gene_models.gff -b xnla.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > xnlgenesa.bed
bedtools intersect -wa -a ../Genome/farr1_phase2.gene_models.gff -b xnlb.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > xnlgenesb.bed
