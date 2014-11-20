#!/usr/bin/env Rscript

library(sqldf)

database = "../../sql/data.sqlite"

# all data

query = "
SELECT
  g1.go_name as go_name,
  g1.percent as percent,
  g2.percent as total_percent
FROM
  (
    SELECT
      (count(got.id) * 100.0 / total.total) AS percent,
      got.name AS go_name
    FROM
      gene_ontology_terms got,
      gene_ontology_terms_genes gotg,
      tissue_specific_genes g,
      (
        SELECT
          count(*) AS total
        FROM
          gene_ontology_terms got,
          gene_ontology_terms_genes gotg,
          tissue_specific_genes g
        WHERE
          g.specific_tissue_name = 'Brain - Cortex' AND
          got.id = gotg.gene_ontology_term_id AND
          g.id = gotg.gene_id AND
          got.domain = 'biological_process'
      ) AS total
    WHERE
      g.specific_tissue_name = 'Brain - Cortex' AND
      got.id = gotg.gene_ontology_term_id AND
      g.id = gotg.gene_id AND
      got.domain = 'biological_process'
    GROUP BY got.id
  ) as g1,
  (
    SELECT
      (count(got.id) * 100.0 / total.total) AS percent,
      got.name as go_name
    FROM
      gene_ontology_terms got,
      gene_ontology_terms_genes gotg,
      all_genes g,
      (
        SELECT
          count(*) AS total
        FROM
          gene_ontology_terms got,
          gene_ontology_terms_genes gotg,
          all_genes g
        WHERE
          got.id = gotg.gene_ontology_term_id AND
          g.id = gotg.gene_id AND
          got.domain = 'biological_process'
      ) AS total
    WHERE
      got.id = gotg.gene_ontology_term_id AND
      g.id = gotg.gene_id AND
      got.domain = 'biological_process'
    GROUP BY got.id
  ) as g2
WHERE
  g1.go_name = g2.go_name
ORDER BY percent DESC
"

data = sqldf(query, dbname=database)

# all quantitative variables, transformed to decimal logarithm

# if(Sys.info()['sysname'] == "Darwin") {
#   quartz()
# } else {
#   x11()
# }

# plot(percents)
