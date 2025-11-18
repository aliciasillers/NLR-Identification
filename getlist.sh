#!/bin/bash
#
#SBATCH --job-name=list
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getlist.out # File to which STDOUT will be written
#SBATCH --error=getlist.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

sed 's/\r//g' cnlgenes.bed | awk '{print $4".1"}' > cnlgenes.txt
sed 's/\r//g' tnlgenes.bed | awk '{print $4".1"}' > tnlgenes.txt
sed 's/\r//g' mnlgenes.bed | awk '{print $4".1"}' > mnlgenes.txt
sed 's/\r//g' othergenes.bed | awk '{print $4".1"}' > othergenes.txt
