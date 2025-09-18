#!/bin/bash
#
#SBATCH --job-name=getclusterinfo
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=10G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getclusterinfo.out # File to which STDOUT will be written
#SBATCH --error=getclusterinfo.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=2:00:00

awk '{print $1"\t"$2"\t"$7}' clusters.bed | uniq > clusterinfo.txt
