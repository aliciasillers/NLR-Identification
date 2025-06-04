#load packages
library(tidyverse)
library(reshape)

#read in data
nlr <- read.delim("nlr.out.txt", header = FALSE, sep = '\t')

#filter nlrs by motifs
ctg <- nlr %>% filter(grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & grepl('motif_13|motif_15|motif_18', V7) & grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
c <- nlr %>% filter(grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & !grepl('motif_13|motif_15|motif_18', V7) & !grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
ct <- nlr %>% filter(grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & grepl('motif_13|motif_15|motif_18', V7) & !grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
cg <- nlr %>% filter(grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & !grepl('motif_13|motif_15|motif_18', V7) & grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
t <- nlr %>% filter(!grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & grepl('motif_13|motif_15|motif_18', V7) & !grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
tg <- nlr %>% filter(!grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & grepl('motif_13|motif_15|motif_18', V7) & grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))
g <- nlr %>% filter(!grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7) & !grepl('motif_13|motif_15|motif_18', V7) & grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))

#find nlrs present in neither and both data frames
nnl <- rbind(ctg, ct)
nnlbed <- cbind(nnl$V1, nnl$V4, nnl$V5, nnl$V2, nnl$V6, nnl$V3, nnl$V7)
other <- rbind(g)
otherbed <- cbind(other$V1, other$V4, other$V5, other$V2, other$V6, other$V3, other$V7)
cnl <- rbind(c, cg)
cnlbed <- cbind(cnl$V1, cnl$V4, cnl$V5, cnl$V2, cnl$V6, cnl$V3, cnl$V7)
tnl <- rbind(t, tg)
tnlbed <- cbind(tnl$V1, tnl$V4, tnl$V5, tnl$V2, tnl$V6, tnl$V3, tnl$V7)

#save data frames
write.table(nnlbed, "nnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(otherbed, "other.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnlbed, "cnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnlbed, "tnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
