library(tidyverse)

cnldom <- read.delim("cnl.interpro.tsv", sep = "\t", header = FALSE)
cnldom <- cnldom[,c(1,6)]
tnldom <- read.delim("tnl.interpro.tsv", sep = "\t", header = FALSE)
tnldom <- tnldom[,c(1,6)]
rnldom <- read.delim("rnl.interpro.tsv", sep = "\t", header = FALSE)
rnldom <- rnldom[,c(1,6)]
nnldom <- read.delim("nnl.interpro.tsv", sep = "\t", header = FALSE)
nnldom <- nnldom[,c(1,6)]
xnldom <- read.delim("other.interpro.tsv", sep = "\t", header = FALSE)
xnldom <- xnldom[,c(1,6)]

cnl_dom_wide <- cnldom %>% 
  group_by(V1) %>%
  mutate(domain = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = domain, values_from = V6)

tnl_dom_wide <- tnldom %>%
  group_by(V1) %>%
  mutate(domain = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = domain, values_from = V6)

rnl_dom_wide <- rnldom %>%
  group_by(V1) %>%
  mutate(domain = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = domain, values_from = V6)

nnl_dom_wide <- nnldom %>%
  group_by(V1) %>%
  mutate(domain = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = domain, values_from = V6)

xnl_dom_wide <- xnldom %>%
  group_by(V1) %>%
  mutate(domain = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = domain, values_from = V6)

write.table(cnl_dom_wide, "cnl_domains_wide.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(tnl_dom_wide, "tnl_domains_wide.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(rnl_dom_wide, "rnl_domains_wide.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(nnl_dom_wide, "nnl_domains_wide.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(xnl_dom_wide, "other_domains_wide.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
