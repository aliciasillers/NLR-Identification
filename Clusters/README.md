# Gene Cluster Analysis

1. windows.sh

Creates a bed file with 200Kb sliding windows across the genome

2. countoverlap.sh

Returns a bed file with the number of NLR genes intersecting each sliding window

3. filteroverlap.sh

Removes windows with 0 genes or 1 gene

3. getclusters.sh

Returns a bed file with the genes overlapping each window. Duplicates resulting from the sliding windows may need to be removed.
