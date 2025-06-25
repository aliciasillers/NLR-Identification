library(bio3d)
library(tidyverse)

aln <- read.fasta("nlr.aln.p.fa")

ent <- entropy(aln)
con <- consensus(aln)


