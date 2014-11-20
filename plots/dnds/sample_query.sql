SELECT
  g.ensembl_id,
  og.ensembl_id,
  og.dn,
  og.ds,
  og.dnds
FROM
  tissue_specific_genes g,
  ortholog_genes og
WHERE
  g.id = og.gene_id AND
  g.specific_tissue_name = 'Brain - Cortex';
