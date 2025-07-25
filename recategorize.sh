#!/bin/bash
#
#SBATCH --job-name=recategorize
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=recategorize.out # File to which STDOUT will be written
#SBATCH --error=recategorize.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=8:00:00

cat DAfiles/all_c.txt DAfiles/all_cn.txt DAfiles/all_cnl.txt | awk '{print $1}' > cnlgenelist.txt
cat DAfiles/tnl_t.txt DAfiles/tnl_tn.txt DAfiles/tnl_tnl.txt DAfiles/xnl_t.txt DAfiles/xnl_tn.txt DAfiles/xnl_tnl.txt | awk '{print $1}' > tnlgenelist.txt
cat DAfiles/all_ct.txt DAfiles/all_ctn.txt DAfiles/all_ctnl.txt DAfiles/nnl_t.txt DAfiles/nnl_tn.txt DAfiles/nnl_tnl.txt | awk '{print $1}' > nnlgenelist.txt
cat DAfiles/all_n.txt DAfiles/all_nl.txt | awk '{print $1}' > xnlgenelist.txt
cat DAfiles/rnl_r.txt DAfiles/rnl_rn.txt | awk '{print $1}' > rnlgenelist.txt
