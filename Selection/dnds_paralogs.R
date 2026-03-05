library(dplyr)
library(stringr)
library(ggplot2)
library(PLS205)
library(car)
library(FSA)
library(data.table)

#read and filter nlr files
nlrdnds <- read.delim("NLR_paralogs.tsv", header = FALSE, sep = '\t')
#alldnds$V3 <- as.numeric(alldnds$V3)
dndsclean <- nlrdnds %>% filter(V4 <= 3) %>% filter(V5 <= 6)

#read and filter control files

contdnds <- read.delim("Control_paralogs.tsv", header = FALSE, sep = '\t')
contclean <- allcontdnds %>% filter(V4 <= 3) %>% filter(V5 <= 6)

#mean dn/ds calculations
mean(dndsclean$V5)
aggregate(V5~V6, data = dndsclean, mean)
aggregate(V5~V6, data = contclean, mean)

#add control data
dnds <- rbind(dndsclean, contclean)
dnds$V6 <- factor(dnds$V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH"))

#plot
Y <- aggregate(V5~V6, data = dnds, max)[,2] + 0.15
label <- c("a", "a", "a", "a", "a", "b", "c", "bc")#update with paralog stats results
png("paralog_dnds1.png", width = 6.5, height = 4, units = "in", res = 900)
plot1 <- ggplot(dnds, aes(x = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")), y = V5, fill = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")))) + geom_violin() + geom_jitter(width = 0.1, alpha = 0.3, size = 0.8) + scale_fill_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue")) + labs(x = "", y = "dN/dS") + theme_minimal() + theme(legend.position="none") + stat_summary(fun = "mean", geom =  "point", color = "green4") + annotate("text", x = 1:8, y = Y, label = label)
print(plot1)
dev.off()

#model, stats
model1 <- lm(V5~V6, data = dnds)
pls205_diagnostics(model1)
kruskal.test(V5~V6, data = dnds)
dunnTest(V5~V6, data = dnds, method = "bh")

#bins, etc
png("paralog_ds_dist.png", width = 6.5, height = 5, units = "in", res = 900)
plot2 <- ggplot(dnds, aes(x = V4, y = V5, color = V6)) + geom_point(alpha = 0.6) + geom_smooth(method = "gam", se = FALSE) + scale_color_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue", CYP = "gray80", OGDH = "gray20", ACO = "gray50")) + labs(x = "dS", y = "dN/dS", color = "") + theme_minimal() 
print(plot2)
dev.off()
dndsdt <- data.table(dnds)
dndsdt <- dndsdt %>% mutate(dS = cut(V4, breaks=c(0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0)))
png("paralog_ds_bins.png", width = 6.5, height = 5, units = "in", res = 900)
plot3 <- ggplot(dndsdt, aes(x = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")), y = V5, color = factor(V6, level = c("RNL", "CNL", "TNL", "MNL", "Other", "CYP", "ACO", "OGDH")))) + geom_violin() + geom_jitter(width = 0.1, alpha = 0.9, size = 0.8) + scale_color_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", MNL ="goldenrod1", Other = "lightblue")) + labs(x = "", y = "dN/dS", fill = "") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + theme(legend.position="none") + facet_wrap(vars(dS), ncol = 3, labeller = "label_both") + stat_summary(fun = "mean", geom =  "point", color = "green4", size = 0.9)
print(plot3)
dev.off()