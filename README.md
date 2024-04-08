# NLR-Identification-and-Visualization

## Conda Environment

1. env.sh

Creates a conda environment with tidyverse, reshape, and chromomap R packages.

## Get NLR Loci

2. nlr.sh

Runs NLR-Annotator and returns results in text and gff format. The text file lists the coordinates and motifs of each locus, and the gff file is useful for inspecting loci in a genome viewer such as IGV.

## Sort NLRs into Classes based on Motifs

2. 

Looks for class-specific motifs and sorts NLR loci into CNLs, TNLs, Novel Architecture NLRs (NANLs), and other NLRs (XNLs). Results are reported in four separate bed files.

3. 

Intersects each bed file with the genome annotation and returns a list of genes

## Visualize Loci & Genes Across the Genome


Create chromosome coordinate file

Visualize with ChromoMap
