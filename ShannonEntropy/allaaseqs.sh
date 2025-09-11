#!/bin/bash
#
#SBATCH --job-name=allseq
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=18G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=allaaseqs.out # File to which STDOUT will be written
#SBATCH --error=allaaseqs.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=2:00:00

cat OtherSpecies/fv.protein.fa OtherSpecies/fi.protein.fa ../rnl.protein.fa ../cnl.protein.fa ../tnl.protein.fa ../nnl.protein.fa ../other.protein.fa OrthoFiles/brilliance1.protein.fa OrthoFiles/brilliance2.protein.fa OrthoFiles/moxie.protein.fa > allaaseqs.fa
