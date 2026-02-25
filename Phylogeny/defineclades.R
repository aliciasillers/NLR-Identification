#this code was written with help from chatgpt

library(ape)
library(phytools)
library(data.table)
library(dplyr)
library(future.apply)

tree <- read.tree("nlrNB.raxml.support.rooted")
tree$node.label <- as.numeric(tree$node.label)
stopifnot(is.rooted(tree))
tree <- reorder.phylo(tree, "postorder")

anno <- fread("subgroups.tsv")
anno <- anno[match(tree$tip.label, gene_id)]
stopifnot(all(tree$tip.label == anno$gene_id))

nodes <- (Ntip(tree)+1):(Ntip(tree)+tree$Nnode)
get_desc <- function(tree, node){
children <- tree$edge[tree$edge[,1]==node,2]
desc <- children
for(child in children){
if(child > Ntip(tree)){
desc <- c(desc, Recall(tree, child))
}
}
desc[desc <= Ntip(tree)]
}
desc_list <- lapply(nodes, get_desc, tree = tree)
names(desc_list) <- nodes

labels <- anno$subgroup
freq <- prop.table(table(labels))
types <- names(freq)

alpha <- 0.05
minsize <- 10
dominance <- 0.7

scorenode <- function(node, lab){
desc <- desc_list[[as.character(node)]]
n <- length(desc)
if(n < minsize) return(NA)
counts <- table(lab[desc])
freqs <- counts / n
freqs_full <- setNames(rep(0, length(types)), types)
freqs_full[names(freqs)] <- freqs
z <- max((freqs_full - freq) / sqrt(freq * (1-freq) / n), na.rm = TRUE)
return(z)
}

obs_scores <- sapply(nodes, scorenode, lab = labels)

plan(multisession)
set.seed(1)

nperm <- 10000
perm_max <- future_sapply(1:nperm, function(i){
perm_labels <- sample(labels)
perm_scores <- sapply(nodes, scorenode, lab = perm_labels)
max(perm_scores, na.rm = TRUE)
},
future.seed = TRUE)

saveRDS(perm_max, "perm_null.rds")

pval <- sapply(obs_scores, function(s){
if(is.na(s)) return(NA)
(sum(perm_max >= s) +1) / (nperm + 1)
})

dominantfrac <- sapply(nodes, function(node){
desc <- desc_list[[as.character(node)]]
max(prop.table(table(labels[desc])))
})

sig_nodes <- nodes[pval < alpha & dominantfrac > dominance]

subtreesize <- sapply(sig_nodes, function(n){
length(desc_list[[as.character(n)]])
})

sig_nodes_ordered <- sig_nodes[order(subtreesize, decreasing = TRUE)]

selected <- c()

is_descendant_of <- function(node, selectednodes){
if(length(selectednodes) == 0) return(FALSE)
nodetips <- desc_list[[as.character(node)]]
for(sel in selectednodes){
seltips <- desc_list[[as.character(sel)]]
if(all(nodetips %in% seltips)){
return(TRUE)
}
}
FALSE
}

for(n in sig_nodes_ordered){
if(!any(is_descendant_of(n, selected))){
selected <- c(selected, n)
}
}

clade_label <- function(node){
desc <- desc_list[[as.character(node)]]
names(which.max(table(labels[desc])))
}

clade_types <- sapply(selected, clade_label)

results <- data.frame(node = selected, subgroup = clade_types, pvalue = pval[match(selected, nodes)], size = sapply(selected, function(n){
length(desc_list[[as.character(n)]])
}))

write.csv(results, "NLR_enriched_clades.csv", row.names = FALSE)

write.tree(tree, file="nlrNB.raxml.support.rooted.labeled.nwk")
