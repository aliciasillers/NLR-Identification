#load packages

library(tidyverse)
library(reshape)

#read in data

rnldf <- read.delim("rnl_domains_wide.txt", header = FALSE, sep = '\t')

#filter nlrs by motifs

tir <- rnldf[grepl("TIR",do.call(paste,rnldf)),]
cc <- rnldf[grepl("Coil",do.call(paste,rnldf)),]
rpw8 <- rnldf[grepl("RPW8",do.call(paste,rnldf)),]
nbarc <- rnldf[grepl("NB-ARC",do.call(paste,rnldf)),]
lrr <- rnldf[grepl("Leucine",do.call(paste,rnldf)),]
rx <- rnldf[grepl("Rx",do.call(paste,rnldf)),]
cc <- unique(rbind(cc, rx))

#find nlrs present in different combinations of the dataframes

#rnls
notrpw8 <- rbind(tir, nbarc, lrr)
r <- anti_join(rpw8, notrpw8) #da7
rn_all <- semi_join(rpw8, nbarc)
notrn <- rbind(tir, lrr)
rn <- anti_join(rn_all, notrn) #da8

#save data frames

write.table(r, "DAfiles/rnl_r.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(rn, "DAfiles/rnl_rn.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
