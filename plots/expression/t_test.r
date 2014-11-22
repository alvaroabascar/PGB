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
expression = data$expression
tissue = data$tissue

test <- pairwise.wilcox.test(expression, tissue, p.adjust.method="bonferroni")
