#!/usr/bin/env Rscript

source('colors.r')

# all data
data = read.csv("../genes/tissue_specific.txt", header=TRUE, sep="\t", skip=1)

# all quantitative variables, transformed to decimal logarithm
num.data = log10(subset(data, select=c(-Gene, -Protein)) + 1e-7)

# if(Sys.info()['sysname'] == "Darwin") {
#   quartz()
# } else {
#   x11()
# }

png(filename='boxplot_expr.png', height=6, width=6, units='in', res=300)
# down, left, up, right margins
par(mar=c(12, 5.1, 4.1, 2.1))

# colors of each kind of box
colors <- c(different, similar, similar, rep(different, 4), similar, similar,
         rep(different, 7), cortex, different, different)

ylabel <- expression('log'[10]*' (rpkm)')

# if you put log="y" the fucking labels don't work, so I use the log10 of the
# data, and I change (later) the labels of the y axis to be in logarithmic
# scale
boxplot(num.data, xaxt="n", xlab="", ylab=ylabel, axes=FALSE, col=colors,
        pch=18, outcol="#333333", main="Expression of cortex-specific genes across all tissues")

points(colMeans(num.data), pch=19)
# the names of the tissues
xlabels <- colnames(num.data)

# y axis in logarithmic scale, x axis empty (by now)
ylabels <- parse(text=paste(c("10^-6", "10^-4", "10^-2", "0", "10^2")))
axis(2, labels=ylabels, at=c(-6, -4, -2, 0, 2))
axis(1, labels=FALSE, at=c(1:19))

# add tissue names as x labels
text(x=seq_along(xlabels), y=par("usr")[3]- 1, srt=45, adj=1,
     labels=xlabels, xpd=TRUE)

# dev.off()
# message("Press Return To Continue")
# invisible(readLines("stdin", n=1))
