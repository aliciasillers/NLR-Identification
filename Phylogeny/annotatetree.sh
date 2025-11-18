#!/bin/bash
#
#SBATCH --job-name=annotatetree
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=annotatetree.out # File to which STDOUT will be written
#SBATCH --error=annotatetree.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

grep ">" cnlNB_Sequences.fa | awk -F'>' '{print $2 "\tCNL"}' | cat > NBSannotationinfo.txt
grep ">" tnlNB_Sequences.fa | awk -F'>' '{print $2 "\tTNL"}' | cat >> NBSannotationinfo.txt
grep ">" rnlNB_Sequences.fa | awk -F'>' '{print $2 "\tRNL"}' | cat >> NBSannotationinfo.txt
grep ">" mnlNB_Sequences.fa | awk -F'>' '{print $2 "\tMNL"}' | cat >> NBSannotationinfo.txt
grep ">" otherNB_Sequences.fa | awk -F'>' '{print $2 "\tOther"}' | cat >> NBSannotationinfo.txt
