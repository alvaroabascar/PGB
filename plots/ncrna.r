path <- "../genes/ncRNA_data/"

all <- read.csv(paste(path, "all_genes_ncRNA.txt", sep=''),
                header=TRUE, sep='\t')
hk <- read.csv(paste(path, "house_keeping_ncRNA.txt", sep=''),
               header=TRUE, sep='\t')
ts <- read.csv(paste(path, "tissue_specific_ncRNA.txt", sep=''),
               header=TRUE, sep='\t')
all_genes_nc <- read.csv(paste(path, "all_genes_ncRNA_only.txt", sep=''),
                         header=TRUE, sep='\t')
hk_nc <- read.csv(paste(path, "house_keeping_ncRNA_only.txt", sep=''),
                  header=TRUE, sep='\t')
ts_nc <- read.csv(paste(path, "tissue_specific_ncRNA_only.txt", sep=''),
                  header=TRUE, sep='\t')

len_all <- mean(all[5] - all[4])
len_hk <- mean(hk[5] - hk[4])
len_ts <- mean(ts[5] - ts[4])

len_all_genes_nc <- mean(all_genes_nc[5] - all_genes_nc[4])
len_hk_nc <- mean(hk_nc[5] - hk_nc[4])
len_ts_nc <- mean(ts_nc[5] - ts_nc[4])

matriz <- matrix(c(len_all, len_hk, len_ts,
                   len_all_genes_nc, len_hk_nc, len_ts_nc), col=3, byrow=T)
barplot(matriz, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts))
