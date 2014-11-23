#!/usr/bin/env Rscript

script_dir = dirname(sys.frame(1)$ofile)

source(file.path(script_dir, "../lib/helpers.r"))

query = "
SELECT
  e.expression as expression,
  og.ds as dnds
FROM
  tissue_specific_genes g,
  expressions e,
  tissues t,
  ortholog_genes og
WHERE
  g.id = e.gene_id AND
  g.id = og.gene_id AND
  e.tissue_id = t.id AND
  t.name = 'Brain - Cortex'
GROUP BY g.id
"

# get data
data = execute_sql(query)

plot = ggplot(data, aes(x=expression, y=dnds))
plot = plot + geom_point(shape=1)
plot = plot + geom_smooth(method=lm)

start_renderer()
print(plot)
