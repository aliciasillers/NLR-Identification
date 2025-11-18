#!/bin/bash
#
#SBATCH --job-name=allnlrgenes
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=allnlrgenes.out # File to which STDOUT will be written
#SBATCH --error=allnlrgenes.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

awk -F'\t' '{print $1"\t"$2"\t"$3"\t"$4"\tCNL"}' ../cnlgenes_resorted.bed > allnlrgenes.bed
awk -F'\t' '{print $1"\t"$2"\t"$3"\t"$4"\tTNL"}' ../tnlgenes_resorted.bed >> allnlrgenes.bed
awk -F'\t' '{print $1"\t"$2"\t"$3"\t"$4"\tRNL"}' ../rnlgenes.bed >> allnlrgenes.bed
awk -F'\t' '{print $1"\t"$2"\t"$3"\t"$4"\tMNL"}' ../mnlgenes_resorted.bed >> allnlrgenes.bed
awk -F'\t' '{print $1"\t"$2"\t"$3"\t"$4"\tOther"}' ../othergenes_resorted.bed >> allnlrgenes.bed
