# NLR-Identification

This repository contains the scripts used for analyses in the publication "Genome-wide analysis of the NLR gene family in strawberry reveals novel immune receptor architecture in Rosaceae." The following workflow outlines the process of identifying putative NLR genes and sorting these genes into groups based on association with the anciently diverged RNL, CNL, and TNL classes. Scripts for further analyses are in labeled subdirectories. In these scripts, the analyses are being carried out using the 'FaRR1' octoploid strawberry reference genome. 

## Conda Environment

1. env.sh

Creates a conda environment with tidyverse, reshape, and chromomap R packages. The environment is activated by the shell scripts that run R scripts.

## Get NLR Loci

1. nlr.sh

Runs NLR-Annotator and returns results in text and gff format. The text file lists the coordinates and motifs of each locus, and the gff file is useful for inspecting loci in a genome viewer such as IGV.

## Sort NLRs based on Motifs

1. nlrclass.sh

Runs an R script that looks for class-specific motifs and sorts NLR loci into CNLs, TNLs, Mixed Architecture NLRs (MNLs), and other NLRs (those lacking N-terminal signaling domains). Results are reported in separate bed files.

3. intersect.sh

Intersects each bed file with the genome annotation and returns a bed file of genes and their coordinates

## Domain Architecture Analysis

1. getlist.sh

Creates text documents with lists of protein IDs for each NLR class

2. faidx.sh

Uses protein IDs and a protein fasta file to return the amino acid sequence of each protein. These sequences can then be used for functional domain prediction with interpro

```bash
my_interproscan/interproscan-5.69-101.0/interproscan.sh -f TSV -appl COILS,Pfam -i cnl.protein.fa -b cnl.interpro
```

3. domainformat.sh

After running interpro, this script will run an R script to put the data into a wide format, in which all the domains for one gene are in one row

## Gene Classification

1. nlrgeneclass.sh

Runs five R scripts, each taking a different one of the wide-formatted domain architecture files and sorting the genes based on domain architecture. This returns lists of genes labeled with their classification based on motif analysis and their domain architecure based on interpro output

2. compile.sh

Creates lists of all genes with each domain architecture

3. recategorize.sh

Creates lists of genes in each class/subgroup based on motif and domain architecture information

4. filtergff.sh

Uses final gene lists to create final bed files

5. faidx2.sh

Uses final gene lists to create final protein fasta files
