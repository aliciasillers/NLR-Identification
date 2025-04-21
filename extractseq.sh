#!/bin/bash
#
#SBATCH --job-name=extractseq
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=extractseq.out # File to which STDOUT will be written
#SBATCH --error=extractseq.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

module load bedtools2

bedtools getfasta -fi cnl.protein.fa -bed cnlNB.bed -fo cnlNB_Sequences.fasta
bedtools getfasta -fi tnl.protein.fa -bed tnlNB.bed -fo tnlNB_Sequences.fasta
bedtools getfasta -fi rnl.protein.fa -bed rnlNB.bed -fo rnlNB_Sequences.fasta
bedtools getfasta -fi nanl.protein.fa -bed nnlNB.bed -fo nnlNB_Sequences.fasta
bedtools getfasta -fi xnl.protein.fa -bed xnlNB.bed -fo xnlNB_Sequences.fasta
