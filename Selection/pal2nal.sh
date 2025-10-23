#!/bin/bash
#
#SBATCH --job-name=pal2nal
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=12G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=pal2nal.out # File to which STDOUT will be written
#SBATCH --error=pal2nal.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00
#SBATCH --array=1-73

module load samtools

file1=$(ls cluster*.aln.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
file2=$(ls cluster*.fna | sed -n ${SLURM_ARRAY_TASK_ID}p)
prefix=$(ls cluster*.txt | sed -n ${SLURM_ARRAY_TASK_ID}p | awk -F'[.]' '{print $1}')

./pal2nal.pl $file1 $file2 -output paml -nogap > $prefix.pal2nal
