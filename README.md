# NLR-Identification-and-Visualization

This pipeline identifies predicted NLR loci using NLR-Annotator, sorts these loci into predicted NLR classes, identifies genes overlapping these loci, and visualizes this information across the genome using the ChromoMap R package. In these scripts, the analyses are being carried out using the Farr1 octoploid strawberry reference genome. 

## Conda Environment

1. env.sh

Creates a conda environment with tidyverse, reshape, and chromomap R packages. The environment is activated by the shell scripts that run R scripts.

## Get NLR Loci

2. nlr.sh

Runs NLR-Annotator and returns results in text and gff format. The text file lists the coordinates and motifs of each locus, and the gff file is useful for inspecting loci in a genome viewer such as IGV.

## Sort NLRs into Classes based on Motifs

3. nlrclass.sh

Runs an R script that looks for class-specific motifs and sorts NLR loci into CNLs, TNLs, Novel Architecture NLRs (NNLs), and other NLRs (XNLs). Results are reported in separate bed files.

4. motifquantification.sh

Runs an R script that makes a venn diagram representing the number of loci with motifs in different class-based categories

5. intersect.sh

Intersects each bed file with the genome annotation and returns a bed file of genes and their coordinates

## Visualize Genes Across the Genome

6. chrsize.sh

Creates chromosome coordinate file needed for ChromoMap

7. chromomap.sh

Runs an R script to create figures showing loci and genes across the genome using the R package ChromoMap. These figures save in an html format that can be opened in any internet browser for an interactive display and can subsequently be saved as static images if desired. 

## Further Analysis Options

### Domain Architecture Analysis

1. getlist.sh

Creates text documents with lists of protein IDs for each NLR class

2. faidx.sh

Uses protein IDs and a protein fasta file to return the amino acid sequence of each protein. These sequences can then be used for further analyses, such as functional domain prediction

### Phylogenetic Analysis

1. align.sh

Aligns sequences of an input fasta file specified on command line; can be the nlr.fa file returned by nlr.sh or a fasta file of NBS/NB-ARC domain sequences

### Gene Cluster Analysis

1. windows.sh

Creates a bed file with 200Kb sliding windows across the genome

2. countoverlap.sh

Returns a bed file with the number of NLR genes intersecting each sliding window

3. filteroverlap.sh

Removes windows with 0 genes or 1 gene

3. getclusters.sh

Returns a bed file with the genes overlapping each window. Duplicates resulting from the sliding windows may need to be removed. 
