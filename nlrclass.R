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
partial <- rbind(c, t, g)
partialbed <- cbind(partial$V1, partial$V4, partial$V5, partial$V2, partial$V6, partial$V3, partial$V7)
cnl <- cg
cnlbed <- cbind(cnl$V1, cnl$V4, cnl$V5, cnl$V2, cnl$V6, cnl$V3, cnl$V7)
tnl <- tg
tnlbed <- cbind(tnl$V1, tnl$V4, tnl$V5, tnl$V2, tnl$V6, tnl$V3, tnl$V7)

#save data frames
write.table(nnlbed, "nanl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(partialbed, "xnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(cnlbed, "cnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnlbed, "tnl.bed", sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

#bar graph for gene types
nlrloci <- data.frame(Category = as.factor(c("CNL", "TNL", "NNL", "Partial")), Number = as.numeric(c(length(cnl$V1), length(tnl$V1), length(nnl$V1), length(partial$V1))))

png("nlrlociclass.png", width = 20, height = 20, units = "cm", res = 900)
plot1 <- ggplot(data = nlrloci, aes(x = factor(Category, level=c('CNL', 'TNL', 'NNL', 'Partial')), y = Number, fill = Category)) + geom_col() + scale_fill_manual(values = c(CNL = "thistle", TNL = "tomato", NNL = "lightgoldenrod1", Partial = "lightblue")) + theme_classic() + theme(axis.title.x=element_blank()) + theme(legend.position="none")
print(plot1)
dev.off()