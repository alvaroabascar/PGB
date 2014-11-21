path <- "../genes/ncRNA_data/"

library(ggplot2)
library(scales)

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

len_all <- all[5] - all[4]
len_hk <- hk[5] - hk[4]
len_ts <- ts[5] - ts[4]

len_all_nc <- all_nc[5] - all_nc[4]
len_hk_nc <- hk_nc[5] - hk_nc[4]
len_ts_nc <- ts_nc[5] - ts_nc[4]

colnames(len_all) = c('length')
colnames(len_hk) = c('length')
colnames(len_ts) = c('length')
colnames(len_all_nc) = c('length')
colnames(len_hk_nc) = c('length')
colnames(len_ts_nc) = c('length')

len_all$label = 'all genes'
len_hk$label = 'housekeeping'
len_ts$label = 'brain cortex specific'

len_all_nc$label = 'all genes - noncoding'
len_hk_nc$label = 'housekeeping - noncoding'
len_ts_nc$label = 'brain cortex specific - noncoding'

makehist = function(filename, histogram) {
  png(filename, width=6, height=6, units='in', res=300)
  p = ggplot(histogram, aes(x = length, fill = label)) +
      geom_density(alpha=0.2, position='identity') +
      theme(legend.position="top") + 
      xlim(0, 1e5) +
      scale_fill_manual(values = c("black", "blue", "green"))
  print(p)
  dev.off()
}

histogram_all_ts_hk = rbind(len_ts, len_hk, len_all)
histogram_ts_vs_tsnc = rbind(len_ts, len_ts_nc)
histogram_hk_vs_hknc = rbind(len_hk, len_hk_nc)
histogram_all_vs_allnc = rbind(len_all, len_all_nc)

makehist('ncRNA/all_hk_ts.png', histogram_all_ts_hk)
makehist('ncRNA/ts_vs_tsnc.png', histogram_ts_vs_tsnc)
makehist('ncRNA/hk_vs_hknc.png', histogram_hk_vs_hknc)
makehist('ncRNA/all_vs_allnc.png', histogram_all_vs_allnc)
