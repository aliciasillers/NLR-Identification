#!/bin/bash
#
#SBATCH --job-name=countoverlap
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=countoverlap.out # File to which STDOUT will be written
#SBATCH --error=countoverlap.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

module load bedtools2

bedtools intersect -c -a windows.bed -b allnlrgenes.bed > counts.bed

