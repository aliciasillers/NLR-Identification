library("tidyverse")
library("DBI")

orthogroups <- read.delim("OrthoFiles/OrthoFinder/Results_Jun27/Orthogroups/Orthogroups.txt", header = FALSE, sep = "")

orthogroups <- sqlColumnToRownames(orthogroups, row.names = "V1")

groups <- setNames(split(orthogroups, seq(nrow(orthogroups))), rownames(orthogroups))

groups <- lapply(groups, as.vector)

rm.empty <- function(x){
  substring <- '.'
  filtered <- x[grepl(substring, x)]
  return(filtered)
}

groups2 <- lapply(groups, rm.empty)

groups3 <- Filter(function(x) length(x) > 19, groups2)

for (i in 1:length(groups3)){
	df <- data.frame(V1 = unlist(groups3[i]))
	name <- i
	write.table(df, paste0("Groups/entgrp.",name,".txt"), sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
}

