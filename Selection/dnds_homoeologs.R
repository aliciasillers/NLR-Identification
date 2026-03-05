library(dplyr)
library(stringr)
library(ggplot2)
library(PLS205)
library(car)
library(FSA)
library(data.table)

#read in nlr files
AB <- na.omit(read.delim("AB.tsv", header = FALSE, sep = '\t'))
AC <- na.omit(read.delim("AC.tsv", header = FALSE, sep = '\t'))
AD <- na.omit(read.delim("AD.tsv", header = FALSE, sep = '\t'))
BC <- na.omit(read.delim("BC.tsv", header = FALSE, sep = '\t'))
BD <- na.omit(read.delim("BD.tsv", header = FALSE, sep = '\t'))
CD <- na.omit(read.delim("CD.tsv", header = FALSE, sep = '\t'))

allsynt <- rbind(AB, AC, AD, BC, BD, CD)
alldnds <- as.data.frame(cbind(allsynt[,1], allsynt[,2], allsynt[,4], allsynt[,3])) %>% mutate(V5 = as.numeric(V3)/as.numeric(V4))
alldnds$V3 <- as.numeric(alldnds$V3)
alldnds$V4 <- as.numeric(alldnds$V4)

nlrs <- read.delim("allnlrgenes.bed", header = FALSE, sep = '\t')

dndsfilt <- alldnds %>% filter(V4 <= 3) %>% filter(V5 <= 6)

#read in control files

ABc <- na.omit(read.delim("ABc.tsv", header = FALSE, sep = '\t'))
ACc <- na.omit(read.delim("ACc.tsv", header = FALSE, sep = '\t'))
ADc <- na.omit(read.delim("ADc.tsv", header = FALSE, sep = '\t'))
BCc <- na.omit(read.delim("BCc.tsv", header = FALSE, sep = '\t'))
BDc <- na.omit(read.delim("BDc.tsv", header = FALSE, sep = '\t'))
CDc <- na.omit(read.delim("CDc.tsv", header = FALSE, sep = '\t'))

allcont <- rbind(ABc, ACc, ADc, BCc, BDc, CDc)
allcontdnds <- as.data.frame(cbind(allcont[,1], allcont[,2], allcont[,4], allcont[,3])) %>% mutate(V5 = as.numeric(V3)/as.numeric(V4))
allcontdnds$V3 <- as.numeric(allcontdnds$V3)
allcontdnds$V4 <- as.numeric(allcontdnds$V4)

contgenes <- read.delim("allcontrolgenes.bed", header = FALSE, sep = '\t')

control <- allcontdnds %>% filter(V4 <= 3) %>% filter(V5 <= 6)

#attach metadata
dndsjoin1 <- left_join(dndsfilt, nlrs, by = join_by(V1 == V4))
dndsjoin2 <- left_join(dndsjoin1, nlrs, by = join_by(V2.x == V4))
dndsjoined <- dndsjoin2[,c(1,2,3,4,5,9,13)]
colnames(dndsjoined) <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7")
dndsclean <- dndsjoined %>% filter(V6 == V7)
dndsclean <- dndsclean[,1:6]

write.table(dndsclean, "NLR_homoeologs.tsv", sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)

contjoin1 <- left_join(control, contgenes, by = join_by(V1 == V4))
contjoin2 <- left_join(contjoin1, contgenes, by = join_by(V2.x == V4))
contjoined <- contjoin2[,c(1,2,3,4,5,9,13)]
colnames(contjoined) <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7")
contclean <- contjoined %>% filter(V6 == V7)
contclean <- contclean[,1:6]

write.table(contclean, "Control_homoeologs.tsv", sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)

#mean dn/ds calculations
mean(dndsclean$V5)
aggregate(V5~V6, data = dndsclean, mean)
aggregate(V5~V6, data = contclean, mean)

#add control data
dnds <- rbind(dndsclean, contclean)
dnds$V6 <- factor(dnds$V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH"))

#plot
Y <- aggregate(V5~V6, data = dnds, max)[,2] + 0.15
label <- c("a", "a", "a", "a", "a", "b", "c", "bc")
png("syntelog_dnds1.png", width = 6.5, height = 4, units = "in", res = 900)
plot1 <- ggplot(dnds, aes(x = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")), y = V5, fill = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")))) + geom_violin() + geom_jitter(width = 0.1, alpha = 0.3, size = 0.8) + scale_fill_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue")) + labs(x = "", y = "dN/dS") + theme_minimal() + theme(legend.position="none") + stat_summary(fun = "mean", geom =  "point", color = "green4") + annotate("text", x = 1:8, y = Y, label = label)
print(plot1)
dev.off()

#model, stats
model1 <- lm(V5~V6, data = dnds)
pls205_diagnostics(model1)
kruskal.test(V5~V6, data = dnds)
dunnTest(V5~V6, data = dnds, method = "bh")

#bins, etc
png("ds_dist.png", width = 6.5, height = 5, units = "in", res = 900)
plot2 <- ggplot(dnds, aes(x = V4, y = V5, color = V6)) + geom_point(alpha = 0.6) + geom_smooth(method = "gam", se = FALSE) + scale_color_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue", CYP = "gray80", OGDH = "gray20", ACO = "gray50")) + labs(x = "dS", y = "dN/dS", color = "") + theme_minimal() 
print(plot2)
dev.off()
dndsdt <- data.table(dnds)
dndsdt <- dndsdt %>% mutate(dS = cut(V4, breaks=c(0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0)))
png("ds_bins.png", width = 6.5, height = 5, units = "in", res = 900)
plot3 <- ggplot(dndsdt, aes(x = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")), y = V5, color = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")))) + geom_violin() + geom_jitter(width = 0.1, alpha = 0.9, size = 0.8) + scale_color_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue")) + labs(x = "", y = "dN/dS", fill = "") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + theme(legend.position="none") + facet_wrap(vars(dS), ncol = 3, labeller = "label_both") + stat_summary(fun = "mean", geom =  "point", color = "green4", size = 0.9)
print(plot3)
dev.off()