#!/usr/bin/env Rscript

library(sqldf)

database = "../../sql/data.sqlite"

# all data

create_query <- function(tissue_name)  {
  query = sprintf("
  SELECT
    t.name as tissue,
    t.expression as expression
  FROM
    (
      SELECT
        g.id as id
      FROM
        expressions e,
        tissue_specific_genes g
      WHERE
        g.specific_tissue_name = '%s' AND
        e.gene_id = g.id AND
        g.specific_tissue_id = e.tissue_id
      ORDER BY e.expression DESC
      LIMIT 50
    ) as g,
    expressions e,
    tissues t
  WHERE
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
