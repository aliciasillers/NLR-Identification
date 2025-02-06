# load packages
library("chromoMap")
library("dplyr")
library("htmlwidgets")

# read in data

# chromosome files
chromfile <- read.delim("farr1.txt", sep = "\t", header = FALSE)
chromfile <- chromfile %>% mutate(V1.5 = rep(1, length(chromfile[,1])), .after = V1) %>% filter(!grepl("^contig", V1))
colnames(chromfile) <- c("V1", "V2", "V3")
chromfile$V2 <- as.numeric(chromfile$V2)
chromfile$V3 <- as.numeric(chromfile$V3)

# gene files
cnl <- read.delim("cnlgenes.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
cnl <- as.data.frame(cbind(cnl[,4], cnl[,1], cnl[,2], cnl[,3]))
tnl <- read.delim("tnlgenes.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
tnl <- as.data.frame(cbind(tnl[,4], tnl[,1], tnl[,2], tnl[,3]))
nnl <- read.delim("nanlgenes.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
nnl <- as.data.frame(cbind(nnl[,4], nnl[,1], nnl[,2], nnl[,3]))
partial <- read.delim("xnlgenes.bed", sep="\t", header = FALSE) %>% filter(!grepl("^contig", V1))
partial <- as.data.frame(cbind(partial[,4], partial[,1], partial[,2], partial[,3]))
nlrgenes <- rbind((cnl %>% mutate(V5 = rep("cnl", length(cnl[,1])))), (tnl %>% mutate(V5 = rep("tnl", length(tnl[,1])))), (nnl %>% mutate(V5 = rep("nnl", length(nnl[,1])))), (partial %>% mutate(V5 = rep("partial", length(partial[,1])))))
nlrgenes <- as.data.frame(nlrgenes)
nlrgenes$V3 <- as.numeric(nlrgenes$V3)
nlrgenes$V4 <- as.numeric(nlrgenes$V4)

# run ChromoMap

genes <- chromoMap(ch.files = list(chromfile), data.files = list(nlrgenes), data_based_color_map = TRUE, data_type = "categorical", data_colors = list(c("thistle", "tomato", "lightgoldenrod1", "lightblue")), chr_color = "black", legend = TRUE, lg_x = 35, lg_y = 282, n_win.factor = 2, export.options = TRUE)

# save figures as html files

saveWidget(genes, "chromoMap_genes.html")
