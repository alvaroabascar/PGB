all <- read.table('../genes/dnds/allgenes_dndsratio.txt')
hk <- read.table('../genes/dnds/housekeeping_dndsratio.txt')
ts <- read.table('../genes/dnds/tissue_specific_dndsratio.txt')

all <- all$V3
hk <- hk$V3
ts <- ts$V3

col1 <- rgb(0.6, 0.6, 1)
col2 <- rgb(0.6, 1, 0.6)
col3 <- rgb(1, 0.6, 0.6)

png('dnds/dNdS_hists.png', height=6, width=6, units='in', res=100)
par(mfrow=c(3,1))
xlab <- "dN/dS ratio"

hist(all, nclass=50, col=col1, xlab=xlab, xlim=c(0, 0.6), main="All genes")
hist(hk, nclass=50, col=col2, xlab=xlab, xlim=c(0, 0.6), main="Housekeeping genes")
hist(ts, nclass=50, col=col3, xlab=xlab, xlim=c(0, 0.6), main="Tissue-specific genes")

dev.off()

png('dNdS_boxplot.png', height=6, width=6, units='in', res=100)

ylab <- "dN/dS ratio"
xlabels <- c("All", "Housekeeping", "Tissue specific")
boxplot(all, hk, ts, ylim=c(0, 1),
        names=xlabels, ylab=ylab, col=c(col1, col2,col3),
        outcol="#333333", pch=18, main="dN/dS ratios across the three datasets")


dev.off()
