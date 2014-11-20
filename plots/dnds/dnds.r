#!/usr/bin/env Rscript

library(sqldf)

database = "../../sql/data.sqlite"

# all data

create_query <- function(tissue_name)  {
  query = sprintf("
  SELECT
    g.ensembl_id as gene_id,
    og.ensembl_id as mouse_gene_id,
    og.dn as dn,
    og.ds as ds,
    og.dnds as dnds
  FROM
    tissue_specific_genes g,
    ortholog_genes og
  WHERE
    g.id = og.gene_id AND
    g.specific_tissue_name = '%s'
    ", tissue_name)
  return(query)
}

query <- create_query('Brain - Cortex')
data = sqldf(query, dbname=database)
