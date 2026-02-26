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

tree <- ladderize(tree, right = FALSE)

type_colors <- c(
 "RNL" = "#ffdfea",
 "Rx-like CNL" = "#8f638f",
 "non-Rx CNL" = "#D8BFD8",
 "TNL" = "#FF6347",
 "MNL"  = "#FFC125",
 "Other" = "#ADD8E6"
)

get_itol_range <- function(tree, node, label, color){
clade <- tryCatch(extract.clade(tree, node), error = function(e) NULL)
if(is.null(clade) || length(clade$tip.label) == 0){
 warning(paste("No descendants for node:", node))
 return(NULL)
}
clade_tips <- clade$tip.label
ordered_tips <- tree$tip.label
idx <- which(ordered_tips %in% clade_tips)
if(length(idx) == 0){
 warning(paste("Tips not found for node:", node))
 return(NULL)
}
start_tip <- ordered_tips[min(idx)]
end_tip <- ordered_tips[max(idx)]
data.frame(
 start = start_tip,
 end = end_tip,
 color = color,
 label = label,
 stringsAsFactors = FALSE,
 row.names = NULL)
}

itol_ranges <- results %>%
  rowwise() %>%
  do(
    get_itol_range(
      tree,
      node  = .$node,
      label = .$subgroup,
      color = type_colors[.$subgroup]
    )
  ) %>%
  ungroup() %>%
  filter(!is.na(start))

outfile <- "nlr_clade_annotation.txt"

writeLines(c(
 "DATASET_RANGE",
 "SEPARATOR TAB",
 "DATASET_LABEL\tEnriched_clades",
 "COLOR\t#000000",
 "RANGE_TYPE\tbox",
 "RANGE_COVER\tlabel",
 "DATA"
), outfile)

write.table(itol_ranges, outfile, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE, append = TRUE)
