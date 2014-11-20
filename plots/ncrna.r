path <- "../genes/ncRNA_data/"

all <- read.csv(paste(path, "all_genes_ncRNA.txt", sep=''),
                header=TRUE, sep='\t')
hk <- read.csv(paste(path, "house_keeping_ncRNA.txt", sep=''),
               header=TRUE, sep='\t')
ts <- read.csv(paste(path, "tissue_specific_ncRNA.txt", sep=''),
               header=TRUE, sep='\t')
all_nc <- read.csv(paste(path, "all_genes_ncRNA_only.txt", sep=''),
                         header=TRUE, sep='\t')
hk_nc <- read.csv(paste(path, "house_keeping_ncRNA_only.txt", sep=''),
                  header=TRUE, sep='\t')
ts_nc <- read.csv(paste(path, "tissue_specific_ncRNA_only.txt", sep=''),
                  header=TRUE, sep='\t')

len_all <- all[[5]] - all[[4]]
len_hk <- hk[[5]] - hk[[4]]
len_ts <- ts[[5]] - ts[[4]]

len_all_nc <- all_nc[[5]] - all_nc[[4]]
len_hk_nc <- hk_nc[[5]] - hk_nc[[4]]
len_ts_nc <- ts_nc[[5]] - ts_nc[[4]]

# h = hist(len_all)
# h$density = h$counts/sum(h$counts)*100
# plot(h,freq=F, col='red')
pall <- hist(len_all, nclass=100)
phk <- hist(len_hk, nclass=100)
pts <- hist(len_ts, nclass=100)

pallnc <- hist(len_all_nc, nclass=100)
phknc <- hist(len_hk_nc, nclass=100)
ptsnc <- hist(len_ts_nc, nclass=100)


pall$density = pall$counts / sum(pall$counts) * 100
phk$density = phk$counts / sum(phk$counts) * 100
pts$density = pts$counts / sum(pts$counts) * 100

pallnc$density = pallnc$counts / sum(pallnc$counts) * 100
phknc$density = phknc$counts / sum(phknc$counts) * 100
ptsnc$density = ptsnc$counts / sum(ptsnc$counts) * 100

par(mfrow=c(3,3))
plot(pall, col='green', freq=F)
plot(pts, col='green', freq=F)
plot(phk, col='green', freq=F)

plot(pallnc, col='red', freq=F)
plot(phknc, col='red', freq=F)
plot(ptsnc, col='red', freq=F)
# plot(pall, col='green', freq=F)
# plot(pts, add=T, col='blue', freq=F)
# plot(phk, add=T, col='red', freq=F)


# matriz <- matrix(c(len_all, len_hk, len_ts,
#                   len_all_nc, len_hk_nc, len_ts_nc), ncol=3, byrow=T)
# barplot(matriz, main="Car Distribution by Gears and VS",
#         xlab="Number of Gears", col=c("darkblue","red"),
#         legend = rownames(counts))
