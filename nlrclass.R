#load packages
library(tidyverse)
library(reshape)

#read in data
nlra <- read.delim("nlr.hapa.out.txt", header = FALSE, sep = '\t')
nlrb <- read.delim("nlr.hapb.out.txt", header = FALSE, sep = '\t')

#filter nlrs by motifs
cnla <- nlra %>% filter(grepl('motif_2|motif_6', V7))
tnla <- nlra %>% filter(grepl('motif_13|motif_15|motif_18', V7))
cnlb <- nlrb %>% filter(grepl('motif_2|motif_6', V7))
tnlb <- nlrb %>% filter(grepl('motif_13|motif_15|motif_18', V7))

#find nlrs present in neither and both data frames
cta <- rbind(cnla, tnla)
ctb <- rbind(cnlb, tnlb)
xnla <- anti_join(nlra, cta)
xnlb <- anti_join(nlrb, ctb)
nanla <- semi_join(cnla, tnla)
nanlb <- semi_join(cnlb, tnlb)
xnlbeda <- cbind(xnla$V1, xnla$V4, xnla$V5, xnla$V2, xnla$V6, xnla$V3, xnla$V7)
xnlbedb <- cbind(xnlb$V1, xnlb$V4, xnlb$V5, xnlb$V2, xnlb$V6, xnlb$V3, xnlb$V7)
nanlbeda <- cbind(nanla$V1, nanla$V4, nanla$V5, nanla$V2, nanla$V6, nanla$V3, nanla$V7)
nanlbedb <- cbind(nanlb$V1, nanlb$V4, nanlb$V5, nanlb$V2, nanlb$V6, nanlb$V3, nanlb$V7)

#filter nlrs with novel architecture from other data frames
cnlbeda <- anti_join(cnla, nanla)
cnlbeda <- cbind(cnlbeda$V1, cnlbeda$V4, cnlbeda$V5, cnlbeda$V2, cnlbeda$V6, cnlbeda$V3, cnlbeda$V7)
cnlbedb <- anti_join(cnlb, nanlb)
cnlbedb <- cbind(cnlbedb$V1, cnlbedb$V4, cnlbedb$V5, cnlbedb$V2, cnlbedb$V6, cnlbedb$V3, cnlbedb$V7)
tnlbeda <- anti_join(tnla, nanla)
tnlbeda <- cbind(tnlbeda$V1, tnlbeda$V4, tnlbeda$V5, tnlbeda$V2, tnlbeda$V6, tnlbeda$V3, tnlbeda$V7)
tnlbedb <- anti_join(tnlb, nanlb)
tnlbedb <- cbind(tnlbedb$V1, tnlbedb$V4, tnlbedb$V5, tnlbedb$V2, tnlbedb$V6, tnlbedb$V3, tnlbedb$V7)

#save data frames
write.table(nanlbeda, "nanla.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(nanlbedb, "nanlb.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(xnlbeda, "xnla.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(xnlbedb, "xnlb.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnlbeda, "cnla.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnlbedb, "cnlb.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnlbeda, "tnla.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnlbedb, "tnlb.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
