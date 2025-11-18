#!/bin/bash
#
#SBATCH --job-name=faidx
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=faidx.out # File to which STDOUT will be written
#SBATCH --error=faidx.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

module load samtools

samtools faidx -c -r mnlgenes.txt ../Genome/farr1.protein_updated_2025-07-31.fa -o mnl.protein.fa
samtools faidx -c -r cnlgenes.txt ../Genome/farr1.protein_updated_2025-07-31.fa -o cnl.protein.fa
samtools faidx -c -r tnlgenes.txt ../Genome/farr1.protein_updated_2025-07-31.fa -o tnl.protein.fa
samtools faidx -c -r othergenes.txt ../Genome/farr1.protein_updated_2025-07-31.fa -o other.protein.fa
