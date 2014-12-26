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
UNION
  SELECT
    'Housekeeping' AS tissue,
    og.dnds as dnds
  FROM
    housekeeping_genes g,
    ortholog_genes og
  WHERE
    g.id = og.gene_id
"

# get data
data = execute_sql(query)

# perform wilcox tests
test_data = pairwise.wilcox.test(data$dnds, data$tissue, p.adjust.method="bonferroni")
p_values = test_data$p.value

tissues = unique(data$tissue)
tissue_means = data.frame(tissues, sapply(tissues, function(tissue) mean(data$dnds[data$tissue == tissue]), USE.NAMES = FALSE))
ordered_tissues = tissue_means[ order(tissue_means[,2]), ][,1]

plot = ggplot(data, aes(x=factor(tissue, levels=ordered_tissues, ordered=TRUE), y=dnds)) + labs(title = "dN/dS in tissues")
plot = plot + stat_summary(mapping = aes(colour = tissue), fun.data = mean_cl_normal, geom = "errorbar", width = 0.5, size = 1) + stat_summary(fun.data = mean_cl_boot, geom="point")
plot = plot + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + xlab("Tissues") + ylab("dN/dS")


pvalue_color = function(tissue) {
  if(get_pvalue(p_values, "Brain - Cortex", tissue) <= 0.05) {
    color = "#CC0000"
  }
  else {
    color = "#00CC00"
  }
  return(color)
}
values = sapply(tissues, pvalue_color, simplify = TRUE, USE.NAMES = TRUE)

plot = plot + scale_colour_manual(values = values, guide=FALSE)

start_renderer()
print(plot)
