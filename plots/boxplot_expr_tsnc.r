#!/usr/bin/env Rscript

library(reshape2)
library(ggplot2)
library(scales)
source('lib/helpers.r')

title = 'Brain cortex specific ncRNA expression across all tissues'
genes_path = "../genes/ncRNA_data/ts_nc_expressions.txt"
out_file = "expressions/boxplot_expr_ts_nc.png"

# all data
data = read.csv(genes_path, header=TRUE, sep="\t", skip=1)

# all quantitative variables, transformed to decimal logarithm

min_expr = 1e-5
num.data = subset(data, select=c(-Gene, -Protein)) + min_expr

# if(Sys.info()['sysname'] == "Darwin") {
#   quartz()
# } else {
#   x11()
# }

png(filename=out_file, height=6, width=6, units='in', res=300)
# down, left, up, right margins
par(mar=c(12, 5.1, 4.1, 2.1))

# colors of each kind of box
ylabel <- expression('Expression (rpkm)')

data <- melt(num.data, value.name="expr")
colnames(data) = c('Tissue', 'Expression')

test_data = pairwise.wilcox.test(data$Expression, data$Tissue, p.adjust.method = 'bonferroni', paired=TRUE)
p_values = test_data$p.value

plot = ggplot(data, aes(x=Tissue, y=Expression)) +
       geom_boxplot(aes(fill = Tissue), alpha=0.5) +
       labs(title = title) +
       theme(axis.text.x = element_text(angle=45, hjust=1)) +
       xlab("Tissues") +
       ylab("Expressions") +
       # ylim(c(0,3))
       scale_y_log10(labels=trans_format("log10", math_format(10^.x)))

pvalue_color = function(tissue) {
  if (get_pvalue(p_values, "Brain - Cortex", tissue) < 0.05) {
    color = "red"
  }
  else {
    color = "green"
  }
  return(color)
}

tissues = unique(data$Tissue)
# values = sapply(tissues, pvalue_color, simplify=FALSE, USE.NAMES=TRUE)
values = c('red', 'green', rep('red', 14), 'green', 'red', 'red')
plot = plot + scale_fill_manual(values=values, guide=FALSE)
print(plot)

dev.off()
# message("Press Return To Continue")
# invisible(readLines("stdin", n=1))
