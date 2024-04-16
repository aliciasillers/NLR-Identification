# load packages

library("chromoMap")
library("dplyr")
library("htmlwidgets")

# read in data

# chromosome files
chromfilea <- read.delim("farr1.hapa.txt", sep = "\t", header = FALSE)
chromfilea <- chromfilea %>% mutate(V1.5 = rep(1, length(chromfilea[,1])), .after = V1) %>% filter(!grepl("^contig", V1))
colnames(chromfilea) <- c("V1", "V2", "V3")

chromfileb <- read.delim("farr1.hapb.txt", sep = "\t", header = FALSE) 
chromfileb <- chromfileb %>% mutate(V1.5 = rep(1, length(chromfileb[,1])), .after = V1) %>% filter(!grepl("^contig", V1))
colnames(chromfileb) <- c("V1", "V2", "V3")

# loci files
cnla <- read.delim("cnla.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
cnla <- as.data.frame(cbind(cnla[,4], cnla[,1], cnla[,2], cnla[,3]))
tnla <- read.delim("tnla.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
tnla <- as.data.frame(cbind(tnla[,4], tnla[,1], tnla[,2], tnla[,3]))
nanla <- read.delim("nanla.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
nanla <- as.data.frame(cbind(nanla[,4], nanla[,1], nanla[,2], nanla[,3]))
xnla <- read.delim("xnla.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
xnla <- as.data.frame(cbind(xnla[,4], xnla[,1], xnla[,2], xnla[,3]))
nlrlocia <- rbind((cnla %>% mutate(V5 = rep("cnl", length(cnla[,1])))), (tnla %>% mutate(V5 = rep("tnl", length(tnla[,1])))), (nanla %>% mutate(V5 = rep("nanl", length(nanla[,1])))), (xnla %>% mutate(V5 = rep("xnl", length(xnla[,1])))))

cnlb <- read.delim("cnlb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
cnlb <- as.data.frame(cbind(cnlb[,4], cnlb[,1], cnlb[,2], cnlb[,3]))
tnlb <- read.delim("tnlb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
tnlb <- as.data.frame(cbind(tnlb[,4], tnlb[,1], tnlb[,2], tnlb[,3]))
nanlb <- read.delim("nanlb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
nanlb <- as.data.frame(cbind(nanlb[,4], nanlb[,1], nanlb[,2], nanlb[,3]))
xnlb <- read.delim("xnlb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
xnlb <- as.data.frame(cbind(xnlb[,4], xnlb[,1], xnlb[,2], xnlb[,3]))
nlrlocib <- rbind((cnlb %>% mutate(V5 = rep("cnl", length(cnlb[,1])))), (tnlb %>% mutate(V5 = rep("tnl", length(tnlb[,1])))), (nanlb %>% mutate(V5 = rep("nanl", length(nanlb[,1])))), (xnlb %>% mutate(V5 = rep("xnl", length(xnlb[,1])))))

# gene files
cnla <- read.delim("cnlgenesa.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
cnla <- as.data.frame(cbind(cnla[,4], cnla[,1], cnla[,2], cnla[,3]))
tnla <- read.delim("tnlgenesa.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
tnla <- as.data.frame(cbind(tnla[,4], tnla[,1], tnla[,2], tnla[,3]))
nanla <- read.delim("nanlgenesa.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
nanla <- as.data.frame(cbind(nanla[,4], nanla[,1], nanla[,2], nanla[,3]))
xnla <- read.delim("xnlgenesa.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
xnla <- as.data.frame(cbind(xnla[,4], xnla[,1], xnla[,2], xnla[,3]))
nlrgenesa <- rbind((cnla %>% mutate(V5 = rep("cnl", length(cnla[,1])))), (tnla %>% mutate(V5 = rep("tnl", length(tnla[,1])))), (nanla %>% mutate(V5 = rep("nanl", length(nanla[,1])))), (xnla %>% mutate(V5 = rep("xnl", length(xnla[,1])))))

cnlb <- read.delim("cnlgenesb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
cnlb <- as.data.frame(cbind(cnlb[,4], cnlb[,1], cnlb[,2], cnlb[,3]))
tnlb <- read.delim("tnlgenesb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
tnlb <- as.data.frame(cbind(tnlb[,4], tnlb[,1], tnlb[,2], tnlb[,3]))
nanlb <- read.delim("nanlgenesb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
nanlb <- as.data.frame(cbind(nanlb[,4], nanlb[,1], nanlb[,2], nanlb[,3]))
xnlb <- read.delim("xnlgenesb.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
xnlb <- as.data.frame(cbind(xnlb[,4], xnlb[,1], xnlb[,2], xnlb[,3]))
nlrgenesb <- rbind((cnlb %>% mutate(V5 = rep("cnl", length(cnlb[,1])))), (tnlb %>% mutate(V5 = rep("tnl", length(tnlb[,1])))), (nanlb %>% mutate(V5 = rep("nanl", length(nanlb[,1])))), (xnlb %>% mutate(V5 = rep("xnl", length(xnlb[,1])))))

# run ChromoMap (hapagenes complete, need to update the rest)

hapagenes <- chromoMap(ch.files = list(chromfilea), data.files = list(nlrgenesa), title = "NLR Genes In Royal Royce Haplotype A", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = TRUE, lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)
hapbgenes <- chromoMap(ch.files = list(chromfileb), data.files = list(nlrgenesb), title = "NLR Genes In Royal Royce Haplotype B", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = TRUE, lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)
bothhapgenes <- chromoMap(list(chromfilea, chromfileb), list(nlrgenesa, nlrgenesb), ploidy = 2, title = "NLR Gene Distribution Across The Royal Royce Genome", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato"), c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = c(FALSE, TRUE), lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)

hapaloci <- chromoMap(ch.files = list(chromfilea), data.files = list(nlrlocia), title = "NLR Genes In Royal Royce Haplotype A", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = TRUE, lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)
hapbloci <- chromoMap(ch.files = list(chromfileb), data.files = list(nlrlocib), title = "NLR Genes In Royal Royce Haplotype B", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = TRUE, lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)
bothhaploci <- chromoMap(list(chromfilea, chromfileb), list(nlrlocia, nlrlocib), ploidy = 2, title = "NLR Locus Distribution Across The Royal Royce Genome", data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "lightgoldenrod1", "lightblue", "tomato"), c("thistle", "lightgoldenrod1", "lightblue", "tomato")), chr_color = "black", legend = c(FALSE, TRUE), lg_x = 20, lg_y = 150, n_win.factor = 2, export.options = TRUE)

# save figures as html files

saveWidget(hapagenes, "chromoMap_hapA_genes.html")
saveWidget(hapbgenes, "chromoMap_hapB_genes.html")
saveWidget(bothhapgenes, "chromoMap_farr1_genes.html")

saveWidget(hapaloci, "chromoMap_hapA_loci.html")
saveWidget(hapbloci, "chromoMap_hapB_loci.html")
saveWidget(bothhaploci, "chromoMap_farr1_loci.html")
