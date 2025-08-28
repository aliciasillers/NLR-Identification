# Phylogenetic Analysis

1. extractpos.sh

Creates a bed file of NB-ARC domain positions *requires interpro to have been run*

2. extractseq.sh

Gets amino acid sequences for NB-ARC domains

```
cat rnlNB_Sequences.fasta cnlNB_Sequences.fasta tnlNB_Sequences.fasta nnlNB_Sequences.fasta otherNB_Sequences.fasta > nlrNB_Sequences.fa
```

3. align.sh

Aligns sequences of an input fasta file specified on command line

```
align.sh nlrNB_Sequences.fa nlrNB_aln.fa
```

4. annotatetree.sh

Generates annotation info for ITOL
