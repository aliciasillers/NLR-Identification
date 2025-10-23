library(dplyr)
library(stringr)
library(ggplot2)

#read in files
dndsraw <- read.delim("dNdS.tsv", header = FALSE, sep = '\t')
tandem <- read.delim("dnds_tandem.tsv", header = FALSE, sep = '\t')
control <- read.csv("dnds_control.csv", header = FALSE)
nlrs <- read.delim("allnlrgenes.bed", header = FALSE, sep = '\t')

#reformat tandem to match other files
tandem <- cbind(tandem[,1], tandem[,2], tandem[,5], tandem[,4], tandem[,3])

#dn/ds calculation and filtering
dndsraw <- dndsraw %>% mutate(V5 = V4/V3)
dndsraw <- rbind(dndsraw, tandem)
dndsraw$V5 <- as.numeric(dndsraw$V5)
dndsraw$V3 <- as.numeric(dndsraw$V3)
dndsfilt <- dndsraw %>% filter(V3 <= 3) %>% filter(V5 <= 6)
control <- control %>% filter(V3 <= 3) %>% filter(V5 <= 6)

#attach nlr subgroup info
dndsjoin1 <- left_join(dndsfilt, nlrs, by = join_by(V1 == V4))
dndsjoin2 <- left_join(dndsjoin1, nlrs, by = join_by(V2.x == V4))
dndsjoined <- dndsjoin2[,c(1,2,3,4,5,9,13)]
colnames(dndsjoined) <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7")
dndsclean <- dndsjoined %>% filter(V6 == V7)
dndsclean <- dndsclean[,1:6]

#mean dn/ds calculations
mean(dndsclean$V5)
aggregate(V5~V6, data = dndsclean, mean)
aggregate(V5~V6, data = dndsclean, median)
aggregate(V5~V6, data = dndsclean, max)
aggregate(V3~V6, data = dndsclean, max)

#add control data
dnds <- rbind(dndsclean, control)

#plot
png("dnds.png", width = 20, height = 10, units = "cm", res = 900)
plot1 <- ggplot(dnds, aes(x = factor(V6, level = c("RNL", "CNL", "TNL", "NNL", "Other", "CYP", "ACO", "OGDH")), y = V5, fill = factor(V6, level = c("RNL", "CNL", "TNL", "NNL", "Other", "CYP", "ACO", "OGDH")))) + geom_violin() + geom_jitter(width = 0.1, alpha = 0.3, size = 0.8) + scale_fill_manual(values = c(CNL = "thistle", TNL = "tomato", RNL = "lavenderblush", NNL ="goldenrod1", Other = "lightblue")) + labs(x = "", y = "dN/dS") + theme_minimal() + theme(legend.position="none")
print(plot1)
dev.off()
