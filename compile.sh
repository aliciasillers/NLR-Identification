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

cat DAfiles/cnl_c.txt DAfiles/mnl_c.txt DAfiles/tnl_c.txt DAfiles/other_c.txt | sort -u -k1,1 > DAfiles/all_c.txt
cat DAfiles/cnl_cn.txt DAfiles/mnl_cn.txt DAfiles/tnl_cn.txt DAfiles/other_cn.txt | sort -u -k1,1 > DAfiles/all_cn.txt
cat DAfiles/cnl_cnl.txt DAfiles/mnl_cnl.txt DAfiles/tnl_cnl.txt DAfiles/other_cnl.txt | sort -u -k1,1 > DAfiles/all_cnl.txt
cat DAfiles/cnl_t.txt DAfiles/mnl_t.txt DAfiles/tnl_t.txt DAfiles/other_t.txt | sort -u -k1,1 > DAfiles/all_t.txt
cat DAfiles/cnl_tn.txt DAfiles/mnl_tn.txt DAfiles/tnl_tn.txt DAfiles/other_tn.txt | sort -u -k1,1 > DAfiles/all_tn.txt
cat DAfiles/cnl_tnl.txt DAfiles/mnl_tnl.txt DAfiles/tnl_tnl.txt DAfiles/other_tnl.txt | sort -u -k1,1 > DAfiles/all_tnl.txt
cat DAfiles/cnl_ct.txt DAfiles/mnl_ct.txt DAfiles/tnl_ct.txt DAfiles/other_ct.txt | sort -u -k1,1 > DAfiles/all_ct.txt
cat DAfiles/cnl_ctn.txt DAfiles/mnl_ctn.txt DAfiles/tnl_ctn.txt DAfiles/other_ctn.txt | sort -u -k1,1 > DAfiles/all_ctn.txt
cat DAfiles/cnl_ctnl.txt DAfiles/mnl_ctnl.txt DAfiles/tnl_ctnl.txt DAfiles/other_ctnl.txt | sort -u -k1,1 > DAfiles/all_ctnl.txt
cat DAfiles/cnl_n.txt DAfiles/mnl_n.txt DAfiles/tnl_n.txt DAfiles/other_n.txt | sort -u -k1,1 > DAfiles/all_n.txt
cat DAfiles/cnl_l.txt DAfiles/mnl_l.txt DAfiles/tnl_l.txt DAfiles/other_l.txt | sort -u -k1,1 > DAfiles/all_l.txt
cat DAfiles/cnl_nl.txt DAfiles/mnl_nl.txt DAfiles/tnl_nl.txt DAfiles/other_nl.txt | sort -u -k1,1 > DAfiles/all_nl.txt
