#!/bin/bash
#
#SBATCH --job-name=minimap
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=30G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=minimap.out # File to which STDOUT will be written
#SBATCH --error=minimap.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

module load minimap2

minimap2 -ax splice:hq -uf ../Genome/farr1.fa flnc.fa > flnc_aln.sam
