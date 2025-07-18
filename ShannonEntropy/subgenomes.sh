#!/bin/bash
#
#SBATCH --job-name=subgenomes
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=10G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=subgenomes.out # File to which STDOUT will be written
#SBATCH --error=subgenomes.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=2:00:00

grep -E 'chr_.A' ../rnlgenes.bed | awk '{print $4}' > ../rrA.txt
grep -E 'chr_.A' ../cnlgenes_resorted.bed | awk '{print $4}' >> ../rrA.txt
grep -E 'chr_.A' ../tnlgenes_resorted.bed | awk '{print $4}' >> ../rrA.txt
grep -E 'chr_.A' ../nnlgenes_resorted.bed | awk '{print $4}' >> ../rrA.txt
grep -E 'chr_.A' ../othergenes_resorted.bed | awk '{print $4}' >> ../rrA.txt

grep -E 'chr_.B' ../rnlgenes.bed | awk '{print $4}' > ../rrB.txt
grep -E 'chr_.B' ../cnlgenes_resorted.bed | awk '{print $4}' >> ../rrB.txt
grep -E 'chr_.B' ../tnlgenes_resorted.bed | awk '{print $4}' >> ../rrB.txt
grep -E 'chr_.B' ../nnlgenes_resorted.bed | awk '{print $4}' >> ../rrB.txt
grep -E 'chr_.B' ../othergenes_resorted.bed | awk '{print $4}' >> ../rrB.txt

grep -E 'chr_.C' ../rnlgenes.bed | awk '{print $4}' > ../rrC.txt
grep -E 'chr_.C' ../cnlgenes_resorted.bed | awk '{print $4}' >> ../rrC.txt
grep -E 'chr_.C' ../tnlgenes_resorted.bed | awk '{print $4}' >> ../rrC.txt
grep -E 'chr_.C' ../nnlgenes_resorted.bed | awk '{print $4}' >> ../rrC.txt
grep -E 'chr_.C' ../othergenes_resorted.bed | awk '{print $4}' >> ../rrC.txt

grep -E 'chr_.D' ../rnlgenes.bed | awk '{print $4}' > ../rrD.txt
grep -E 'chr_.D' ../cnlgenes_resorted.bed | awk '{print $4}' >> ../rrD.txt
grep -E 'chr_.D' ../tnlgenes_resorted.bed | awk '{print $4}' >> ../rrD.txt
grep -E 'chr_.D' ../nnlgenes_resorted.bed | awk '{print $4}' >> ../rrD.txt
grep -E 'chr_.D' ../othergenes_resorted.bed | awk '{print $4}' >> ../rrD.txt
