#!/bin/bash
#
#SBATCH --job-name=compile
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=10G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=compile.out # File to which STDOUT will be written
#SBATCH --error=compile.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1:00:00

cat DAfiles/cnl_c.txt DAfiles/nnl_c.txt DAfiles/tnl_c.txt DAfiles/xnl_c.txt | sort -u -k1,1 > DAfiles/all_c.txt
cat DAfiles/cnl_cn.txt DAfiles/nnl_cn.txt DAfiles/tnl_cn.txt DAfiles/xnl_cn.txt | sort -u -k1,1 > DAfiles/all_cn.txt
cat DAfiles/cnl_cnl.txt DAfiles/nnl_cnl.txt DAfiles/tnl_cnl.txt DAfiles/xnl_cnl.txt | sort -u -k1,1 > DAfiles/all_cnl.txt
cat DAfiles/cnl_t.txt DAfiles/nnl_t.txt DAfiles/tnl_t.txt DAfiles/xnl_t.txt | sort -u -k1,1 > DAfiles/all_t.txt
cat DAfiles/cnl_tn.txt DAfiles/nnl_tn.txt DAfiles/tnl_tn.txt DAfiles/xnl_tn.txt | sort -u -k1,1 > DAfiles/all_tn.txt
cat DAfiles/cnl_tnl.txt DAfiles/nnl_tnl.txt DAfiles/tnl_tnl.txt DAfiles/xnl_tnl.txt | sort -u -k1,1 > DAfiles/all_tnl.txt
cat DAfiles/cnl_ct.txt DAfiles/nnl_ct.txt DAfiles/tnl_ct.txt DAfiles/xnl_ct.txt | sort -u -k1,1 > DAfiles/all_ct.txt
cat DAfiles/cnl_ctn.txt DAfiles/nnl_ctn.txt DAfiles/tnl_ctn.txt DAfiles/xnl_ctn.txt | sort -u -k1,1 > DAfiles/all_ctn.txt
cat DAfiles/cnl_ctnl.txt DAfiles/nnl_ctnl.txt DAfiles/tnl_ctnl.txt DAfiles/xnl_ctnl.txt | sort -u -k1,1 > DAfiles/all_ctnl.txt
cat DAfiles/cnl_n.txt DAfiles/nnl_n.txt DAfiles/tnl_n.txt DAfiles/xnl_n.txt | sort -u -k1,1 > DAfiles/all_n.txt
cat DAfiles/cnl_l.txt DAfiles/nnl_l.txt DAfiles/tnl_l.txt DAfiles/xnl_l.txt | sort -u -k1,1 > DAfiles/all_l.txt
cat DAfiles/cnl_nl.txt DAfiles/nnl_nl.txt DAfiles/tnl_nl.txt DAfiles/xnl_nl.txt | sort -u -k1,1 > DAfiles/all_nl.txt
