all <- read.table('../dndsratio_results/allgenes_dndsratio.txt')
hk <- read.table('../dndsratio_results/housekeeping_dndsratio.txt')
ts <- read.table('../dndsratio_results/tissue_specific_dndsratio.txt')

all <- all$V3
hk <- hk$V3
ts <- ts$V3

png('dNdS_mouse.png')#, height=6, width=6, units='in', res=100)

par(mfrow=c(3,1))

xlab <- "dN/dS ratio"

hist(all, nclass=50, col=rgb(0,1,0), xlab=xlab, main="All genes")
hist(hk, nclass=50, col=rgb(0,0,1), xlab=xlab, main="Housekeeping genes")
hist(ts, nclass=50, col=rgb(1,0,0), xlab=xlab, main="Tissue-specific genes")

dev.off()
