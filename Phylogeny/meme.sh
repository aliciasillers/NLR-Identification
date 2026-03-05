#!/bin/bash
#
#SBATCH --job-name=meme
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=30G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=meme.out # File to which STDOUT will be written
#SBATCH --error=meme.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=2:00:00

module load meme

meme nlrNB_Sequences.fa -o meme_out -protein -mod zoops -nmotifs 19 -objfun classic -markov_order 0
