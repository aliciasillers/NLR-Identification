library(tidyverse)

#read files
cnl <- read.delim("cnlgenes.bed", header = FALSE, sep = '\t')
tnl <- read.delim("tnlgenes.bed", header = FALSE, sep = '\t')
nnl <- read.delim("nanlgenes.bed", header = FALSE, sep = '\t')
partial <- read.delim("xnlgenes.bed", header = FALSE, sep = '\t')

#plot
nlrgenes <- data.frame(Category = as.factor(c("CNL", "TNL", "NNL", "Partial")), Number = as.numeric(c(length(cnl$V1), length(tnl$V1), length(nnl$V1), length(partial$V1))))

png("nlrgeneclass.png", width = 20, height = 20, units = "cm", res = 900)
plot1 <- ggplot(data = nlrgenes, aes(x = factor(Category, level=c('CNL', 'TNL', 'NNL', 'Partial')), y = Number, fill = Category)) + geom_col() + scale_fill_manual(values = c(CNL = "thistle", TNL = "tomato", NNL = "lightgoldenrod1", Partial = "lightblue")) + theme_classic() + theme(axis.title.x=element_blank()) + theme(legend.position="none")
print(plot1)
dev.off()
