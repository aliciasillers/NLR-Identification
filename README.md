# NLR-Identification-and-Visualization

This pipeline identifies predicted NLR loci using NLR-Annotator, sorts these loci into predicted NLR classes, identifies genes overlapping these loci, and visualizes this information across the genome using the ChromoMap R package. In these scripts, the pipeline is being carried out separately for each haplotype of the strawberry genome.

## Conda Environment

1. env.sh

Creates a conda environment with tidyverse, reshape, and chromomap R packages. The environment is activated by the shell scripts that run R scripts.

## Get NLR Loci

2. nlr.sh

Runs NLR-Annotator and returns results in text and gff format. The text file lists the coordinates and motifs of each locus, and the gff file is useful for inspecting loci in a genome viewer such as IGV.

## Sort NLRs into Classes based on Motifs

2. nlrclass.sh

Runs an R script that looks for class-specific motifs and sorts NLR loci into CNLs, TNLs, Novel Architecture NLRs (NANLs), and other NLRs (XNLs). XNLs are likely either RNLs, which do not have unique motifs picked up by NLR-Annotator, or non-funcitonal/psuedogenes. Results are reported in separate bed files.

3. intersect.sh

Intersects each bed file with the genome annotation and returns a bed file of genes and their coordinates

## Visualize Loci & Genes Across the Genome

4. chrsize.sh

Creates chromosome coordinate file needed for ChromoMap

5. chromomap.sh

Runs an R script to create figures showing loci and genes across the genome using the R package ChromoMap. These figures save in an html format that can be opened in any internet browser for an interactive display and can subsequently be saved as static images if desired. 
