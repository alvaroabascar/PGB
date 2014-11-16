all <- read.table('../dndsratio_results/allgenes_dndsratio.txt')
hk <- read.table('../dndsratio_results/housekeeping_dndsratio.txt')
ts <- read.table('../dndsratio_results/tissue_specific_dndsratio.txt')

all <- all$V3
hk <- hk$V3
ts <- ts$V3

png('dNdS_mouse.png')#, height=6, width=6, units='in', res=100)

par(mfrow=c(3,1))

xlab <- "dN/dS ratio"

col1 <- rgb(0.6, 0.6, 1)
col2 <- rgb(0.6, 1, 0.6)
col3 <- rgb(1, 0.6, 0.6)

hist(all, nclass=50, col=col1, xlab=xlab, main="All genes")
hist(hk, nclass=50, col=col2, xlab=xlab, main="Housekeeping genes")
hist(ts, nclass=50, col=col3, xlab=xlab, main="Tissue-specific genes")

dev.off()
