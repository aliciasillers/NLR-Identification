#load packages
library(tidyverse)
library(reshape)

#read in data
nlr <- read.delim("nlr.out.txt", header = FALSE, sep = '\t')

#filter nlrs by motifs
cnl <- nlr %>% filter(grepl('motif_2,|motif_2$|motif_6|motif_16|motif_17', V7))
tnl <- nlr %>% filter(grepl('motif_13|motif_15|motif_18', V7))
general <- nlr %>% filter(grepl('motif_1,|motif_1$|motif_3|motif_4|motif_5|motif_7|motif_8|motif_9|motif_10|motif_11|motif_12|motif_19', V7))

#find nlrs present in neither and both data frames
ct <- rbind(cnl, tnl)
xnl <- anti_join(nlr, ct)
nanl <- semi_join(cnl, tnl)
xnlbed <- cbind(xnl$V1, xnl$V4, xnl$V5, xnl$V2, xnl$V6, xnl$V3, xnl$V7)
nanlbed <- cbind(nanl$V1, nanl$V4, nanl$V5, nanl$V2, nanl$V6, nanl$V3, nanl$V7)

#filter nlrs with novel architecture from other data frames
cnlbed <- anti_join(cnl, nanl)
cnlbed <- cbind(cnlbed$V1, cnlbed$V4, cnlbed$V5, cnlbed$V2, cnlbed$V6, cnlbed$V3, cnlbed$V7)
tnlbed <- anti_join(tnl, nanl)
tnlbed <- cbind(tnlbed$V1, tnlbed$V4, tnlbed$V5, tnlbed$V2, tnlbed$V6, tnlbed$V3, tnlbed$V7)

#save data frames
write.table(nanlbed, "nanl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(xnlbed, "xnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnlbed, "cnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnlbed, "tnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
