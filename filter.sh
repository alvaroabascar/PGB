#!/usr/bin/env bash

all_genes=genes/GTEx_Analysis_RNA-seq_selected_tissues.txt

gzip -kd ${all_genes}.gz

python3 scripts/filter_all_genes.py $all_genes > genes/all_genes.txt
echo 'genes/all_genes.txt -> all genes with expression > 1 rpkm in at least one tissue'

python3 scripts/filter_housekeeping.py $all_genes > genes/housekeeping.txt
echo 'genes/housekeeping.txt -> all genes with expression > 1 rpkm in all the tissues'

python3 scripts/filter_tissue_specific.py $all_genes > genes/tissue_specific.txt
echo 'genes/tissue_specific.txt -> all genes with expression > 1 rpkm in our tissue (brain - cortex) and at most in other two'
