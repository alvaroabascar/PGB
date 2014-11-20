#!/usr/bin/env Rscript

library(sqldf)

database = "../../sql/data.sqlite"

# all data

query = "
SELECT
  t.name as tissue,
  e.expression as expression
FROM
  (
    SELECT
      g.id as id
    FROM
      expressions e,
      tissue_specific_genes g
    WHERE
      g.specific_tissue_name = 'Brain - Cortex' AND
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
"

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
