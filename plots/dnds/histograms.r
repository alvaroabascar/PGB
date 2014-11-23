#!/usr/bin/env Rscript

script_dir = dirname(sys.frame(1)$ofile)

source(file.path(script_dir, "../lib/helpers.r"))

query = "
  SELECT
    t.name as tissue,
    og.dnds as dnds
  FROM
    tissues t,
    tissue_specific_genes g,
    ortholog_genes og
  WHERE
    t.id = g.specific_tissue_id AND
    g.id = og.gene_id
"

# get data
data = execute_sql(query)

tissues = unique(data$tissue)
tissue_means = data.frame(tissues, sapply(tissues, function(tissue) mean(data$dnds[data$tissue == tissue]), USE.NAMES = FALSE))
ordered_tissues = tissue_means[ order(tissue_means[,2]), ][,1]

transformed_data = transform(data, tissue=factor(tissue, ordered_tissues))

# histograms
hist = ggplot(transformed_data, aes(x=dnds))
hist = hist + geom_density(fill="#CCCCCC")
hist = hist + facet_wrap(~ tissue)
hist = hist + labs("Tissue-Specific gene dN/dS in all tissues") + xlab("dN/dS") + ylab("Density")

start_renderer()

print(hist)
