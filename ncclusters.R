library(tidyverse)

clusters <- read.delim("clusters.bed", header = FALSE, sep = '\t')
nc <- read.delim("nc.txt", header = FALSE, sep = '\t')

ncclusters <- clusters %>% filter(V6 %in% nc$V1)

write.table(ncclusters, "ncclusters.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
