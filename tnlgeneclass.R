#load packages

library(tidyverse)
library(reshape)

#read in data

tnldf <- read.delim("tnl_domains_wide.txt", header = FALSE, sep = '\t')

#filter nlrs by motifs

tir <- tnldf[grepl("TIR",do.call(paste,tnldf)),]
cc <- tnldf[grepl("Coil",do.call(paste,tnldf)),]
rpw8 <- tnldf[grepl("RPW8",do.call(paste,tnldf)),]
nbarc <- tnldf[grepl("NB-ARC",do.call(paste,tnldf)),]
lrr <- tnldf[grepl("Leucine",do.call(paste,tnldf)),]
rx <- tnldf[grepl("Rx",do.call(paste,tnldf)),]
cc <- unique(rbind(cc, rx))

#find nlrs present in different combinations of the dataframes

#tnls
nottir <- rbind(cc, rpw8, nbarc, lrr)
t <- anti_join(tir, nottir) #da1
tn_all <- semi_join(tir, nbarc)
nottnl <- rbind(cc, rpw8)
tn_all <- anti_join(tn_all, nottnl)
tn <- anti_join(tn_all, lrr) #da2
tnl <- semi_join(tn_all, lrr) #da3

#cnls
notcc <- rbind(tir, rpw8, nbarc, lrr)
c <- anti_join(cc, notcc) #da4
cn_all <- semi_join(cc, nbarc)
notcnl <- rbind(tir, rpw8)
cn_all <- anti_join(cn_all, notcnl)
cn <- anti_join(cn_all, lrr) #da5
cnl <- semi_join(cn_all, lrr) #da6

#mnls
ct_all <- semi_join(cc, tir)
ct_notl <- anti_join(ct_all, lrr)
ct <- anti_join(ct_notl, nbarc) #da9
ctn_all <- semi_join(ct_all, nbarc)
ctn <- anti_join(ctn_all, lrr) #da10
ctnl <- semi_join(ctn_all, lrr) #da11

#other
notnb <- rbind(tir, cc, rpw8, lrr)
notlrr <- rbind(tir, cc, rpw8, nbarc)
notnl <- rbind(tir, cc, rpw8)
n <- anti_join(nbarc, notnb) #da12
l <- anti_join(lrr, notlrr) #da13
nl_all <- semi_join(nbarc, lrr)
nl <- anti_join(nl_all, notnl) #da14

#save data frames

write.table(t, "DAfiles/tnl_t.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tn, "DAfiles/tnl_tn.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnl, "DAfiles/tnl_tnl.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(c, "DAfiles/tnl_c.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cn, "DAfiles/tnl_cn.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnl, "DAfiles/tnl_cnl.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(ct, "DAfiles/tnl_ct.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(ctn, "DAfiles/tnl_ctn.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(ctnl, "DAfiles/tnl_ctnl.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(n, "DAfiles/tnl_n.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(l, "DAfiles/tnl_l.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(nl, "DAfiles/tnl_nl.txt", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
