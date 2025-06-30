#!/bin/bash
#
#SBATCH --job-name=getclusters
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getclusters.out # File to which STDOUT will be written
#SBATCH --error=getclusters.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=8:00:00

module load bedtools2

bedtools intersect -wo -a clusterlocations.bed -b allnlrgenes.bed > clusters.bed
