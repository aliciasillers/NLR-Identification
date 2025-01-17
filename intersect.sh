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

bedtools intersect -wa -a ../Genome/Nomenclature_Update/farr1_updated.gene_models.gff -b nanl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > nanlgenes.bed
bedtools intersect -wa -a ../Genome/Nomenclature_Update/farr1_updated.gene_models.gff -b cnl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > cnlgenes.bed
bedtools intersect -wa -a ../Genome/Nomenclature_Update/farr1_updated.gene_models.gff -b tnl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > tnlgenes.bed
bedtools intersect -wa -a ../Genome/Nomenclature_Update/farr1_updated.gene_models.gff -b xnl.bed | grep 'gene' | awk -F'\t|=|;' '{OFS="\t"} {print $1, $4, $5, $10}' > xnlgenes.bed

