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

cat OtherSpecies/fv.rnl.protein.fa OtherSpecies/fv.cnl.protein.fa OtherSpecies/fv.tnl.protein.fa OtherSpecies/fv.nnl.protein.fa OtherSpecies/fv.other.protein.fa OtherSpecies/fi.rnl.protein.fa OtherSpecies/fi.cnl.protein.fa OtherSpecies/fi.tnl.protein.fa OtherSpecies/fi.nnl.protein.fa OtherSpecies/fi.other.protein.fa rnl.protein.fa cnl.protein.fa tnl.protein.fa nnl.protein.fa other.protein.fa Brilliance/rnl1.protein.fa Brilliance/cnl1.protein.fa Brilliance/tnl1.protein.fa Brilliance/nnl1.protein.fa Brilliance/other1.protein.fa Brilliance/rnl2.protein.fa Brilliance/cnl2.protein.fa Brilliance/tnl2.protein.fa Brilliance/nnl2.protein.fa Brilliance/other2.protein.fa > allaaseqs.fa
