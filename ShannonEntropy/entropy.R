library(bio3d)
library(tidyverse)
library(stringr)

samplename <- as.character(commandArgs(trailingOnly=TRUE))
aln <- read.fasta(file = paste0(samplename))

name <- str_split_i(samplename, coll("."), i = 1)
name <- str_split_i(name, coll("/"), i = 2)

ent <- entropy(aln)
con <- consensus(aln)

names(ent$H)=con$seq
head(ent$freq)

png(paste0("RefinedTrees/", name, ".png"), width = 15, height = 8, units = "cm", res = 900)
plot1 <- barplot(ent$H, ylab = "Entropy")
print(plot1)
dev.off()

ent$H[ apply(ent$freq[21:22,],2,sum)>=0.6 ] = 0

n <- sum(ent$H >= 1.5)

if (n >= 10){
	write(name, "hvNLRs.txt", append = TRUE)
} else {
	write(name, "nonhvNLRs.txt", append = TRUE)
}
