#!/usr/bin/env Rscript

library(reshape2)
library(ggplot2)
library(scales)

n = 20

figure_title = sprintf('Top %d expressed brain cortex genes, across all tissues',
                       n)
genes_path = "../genes/tissue_specific.txt"
out_file = sprintf("expressions/boxplot_expr_ts_top_%d.png", n)

# all data
data = read.csv(genes_path, header=TRUE, sep="\t", skip=1)

# all quantitative variables, transformed to decimal logarithm
num.data = subset(data, select=c(-Gene, -Protein)) + 1e-7
num.data = num.data[order(num.data$Brain...Cortex, decreasing=T),]
num.data = num.data[1:n, ]

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

d <- melt(num.data, value.name="expr")
colnames(d) = c('Tissue', 'Expression')
q <- qplot(Tissue, Expression, data=d, geom=c("boxplot"), ylab=ylabel,
           main = figure_title,
           axes=FALSE)

q = q + theme(axis.text.x=element_text(angle = 60, hjust = 1, colour='black'),
              axis.text.y=element_text(colour='black')) +
        scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                      labels = trans_format("log10", math_format(10^.x)))
print(q)


dev.off()
# message("Press Return To Continue")
# invisible(readLines("stdin", n=1))
