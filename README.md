# NLR-Identification-and-Visualization

## Conda Environment

1. env.sh

Creates a conda environment with tidyverse, reshape, and chromomap R packages.

## Get NLR Loci

2. nlr.sh

Runs NLR-Annotator and returns results in text and gff format. The text file lists the coordinates and motifs of each locus, and the gff file is useful for inspecting loci in a genome viewer such as IGV.

## Sort NLRs into Classes based on Motifs

2. 

Looks for class-specific motifs and sorts nlr loci into CNLs, TNLs, and Novel Architecture NLRs (NANLs). Results are reported in three separate bed files.

3. 

Intersects each bed file with the genome annotation and returns a list of genes

## Visualize Loci & Genes Across the Genome


Create chromosome coordinate file

Visualize with ChromoMap
