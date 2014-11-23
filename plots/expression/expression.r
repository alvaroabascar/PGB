#!/usr/bin/env Rscript

script_dir = dirname(sys.frame(1)$ofile)

source(file.path(script_dir, "../lib/helpers.r"))

#
# Creates a tissue expression boxplot
#

create_tissue_expression_boxplot = function(query, title) {

  data = execute_sql(query)
  tissues = unique(data$tissue)

  # obtain p-values
  test_data = pairwise.wilcox.test(data$expression, data$tissue, p.adjust.method="bonferroni", paired=TRUE)
  p_values = test_data$p.value

  # plot boxplot

  plot = ggplot(data, aes(x=factor(tissue), y=expression)) +
         labs(title = title) +
         geom_boxplot(aes(fill = tissue)) +
         theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
         xlab("Tissues") +
         ylab("Expression (rpkm)") +
         scale_y_log10(labels = trans_format("log10", math_format(10^.x)))

  pvalue_color = function(tissue) {
    if(get_pvalue(p_values, "Brain - Cortex", tissue) <= 0.05) {
      color = "red"
    }
    else {
      color = "green"
    }
    return(color)
  }
  values = sapply(tissues, pvalue_color, simplify = FALSE, USE.NAMES = TRUE)

  plot = plot + scale_fill_manual(values = values, guide=FALSE)

  start_renderer()
  print(plot)
}

most_important_20_query = "
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
all_query = "
SELECT
  t.name as tissue,
  e.expression as expression
FROM
  all_genes g,
  expressions e,
  tissues t
WHERE
  e.gene_id = g.id AND
  e.tissue_id = t.id
"

housekeeping_query = "
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

tissue_specific_query = "
SELECT
  t.name as tissue,
  e.expression as expression
FROM
  tissue_specific_genes g,
  expressions e,
  tissues t
WHERE
  e.gene_id = g.id AND
  e.tissue_id = t.id AND
  g.specific_tissue_name = 'Brain - Cortex'
"

create_tissue_expression_boxplot(most_important_20_query, "20 highest expressed genes in BC")
create_tissue_expression_boxplot(tissue_specific_query, "BC expressed genes")
create_tissue_expression_boxplot(housekeeping_query, "Housekeeping genes")
create_tissue_expression_boxplot(all_query, "All genes")
