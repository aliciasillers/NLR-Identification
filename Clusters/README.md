# Gene Cluster Analysis

1. windows.sh

Creates a bed file with 200Kb sliding windows across the genome

2. countoverlap.sh

Returns a bed file with the number of NLR genes intersecting each sliding window

3. filteroverlap.sh

Removes windows with 0 genes or 1 gene

4. allnlrgenes.sh

Returns a bed file with locations and subgroups of all NLRs

5. getclusters.sh

Returns a file with the genes overlapping each window. Duplicates resulting from the sliding windows may need to be removed.

6. getclusterinfo.sh

Returns a list of clusters with the number of genes in each cluster and which NLR subgroups are represented
