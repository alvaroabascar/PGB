#!/usr/bin/env Rscript

library(sqldf)

database = "../sql/data.sqlite"

# all data

query = "
SELECT
  t.name as tissue,
  e.expression as expression
FROM
  housekeeping_genes g,
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

boxplot(expression~tissue, log=TRUE)
