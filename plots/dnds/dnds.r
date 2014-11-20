#!/usr/bin/env Rscript

library(sqldf)

database = "../../sql/data.sqlite"

# all data

create_query <- function(tissue_name)  {
  query = sprintf("
  SELECT
    ts.ensembl_id as gene,
    t.name as tissue,
    e.expression as expression,
    o.dnds as dns
  FROM
    (
      SELECT
        g.id as id
      FROM
        ortholog_genes o,
        expressions e,
        tissue_specific_genes g
      WHERE
        g.specific_tissue_name = '%s' AND
        e.gene_id = g.id AND
        g.specific_tissue_id = e.tissue_id
      ORDER BY o.dnds DESC
    ) as g,
    tissue_specific_genes ts,
    ortholog_genes o,
    expressions e,
    tissues t
  WHERE
    ts.id = g.id AND
    o.gene_id = g.id AND
    e.gene_id = g.id AND
    e.tissue_id = t.id
  ", tissue_name)
  return(query)
}

query <- create_query('Brain - Cortex')
data = sqldf(query, dbname=database)

# all quantitative variables, transformed to decimal logarithm
expression = log10(data$expression + 0.0000001)
tissue = data$tissue

if(Sys.info()['sysname'] == "Darwin") {
  quartz()
} else {
  x11()
}

boxplot(expression~tissue)
