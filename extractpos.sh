#!/bin/bash
#
#SBATCH --job-name=extractpos
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=extractpos.out # File to which STDOUT will be written
#SBATCH --error=extractpos.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

grep NB-ARC cnl.interpro.tsv | cut -f1,7,8 > cnlNB.bed
grep NB-ARC tnl.interpro.tsv | cut -f1,7,8 > tnlNB.bed
grep NB-ARC rnl.interpro.tsv | cut -f1,7,8 > rnlNB.bed
grep NB-ARC nanl.interpro.tsv | cut -f1,7,8 > nnlNB.bed
grep NB-ARC xnl.interpro.tsv | cut -f1,7,8 > xnlNB.bed
