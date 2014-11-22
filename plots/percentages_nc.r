library(ggplot2)
library(scales)

fileout = "ncRNA/percentage_nc.png"
all_all <- length(read.csv('../genes/ncRNA_data/all_genes_ncRNA.txt', header=T,
                   sep='\t')$Ensembl.Gene.ID)
all_nc <- length(read.csv('../genes/ncRNA_data/all_genes_ncRNA_only.txt',
                  header=T, sep='\t')$Ensembl.Gene.ID)
hk_all <- length(read.csv('../genes/ncRNA_data/house_keeping_ncRNA.txt',
                   header=T, sep='\t')$Ensembl.Gene.ID)
hk_nc <- length(read.csv('../genes/ncRNA_data/house_keeping_ncRNA_only.txt',
                   header=T, sep='\t')$Ensembl.Gene.ID)
ts_all <- length(read.csv('../genes/ncRNA_data/tissue_specific_ncRNA.txt',
                   header=T, sep='\t')$Ensembl.Gene.ID)
ts_nc <- length(read.csv('../genes/ncRNA_data/tissue_specific_ncRNA_only.txt',
                   header=T, sep='\t')$Ensembl.Gene.ID)

all_perc = all_nc / all_all
hk_perc = hk_nc / hk_all
ts_perc = ts_nc / ts_all

dataset = c('all genes', 'housekeeping', 'tissue specific')
percentage = c(all_perc, hk_perc, ts_perc)
df <- data.frame(dataset, percentage)

png(fileout, width=8, height=6, units='in', res=300)
# p = ggplot(data=df, aes(x=dataset, y=percentage, fill=dataset)) +
#     geom_bar(colour="black", stat="identity", alpha=0.3) +
#     theme(legend.position="top", axis.title.x=element_text(vjust=-0.5),
#                                  axis.title.y=element_text(vjust=+1)) +
#     ylab('Percentage of noncoding transcripts (%)') +
#     xlab('Dataset') +
#     scale_y_continuous(labels=percent)

perc_labels = c(NA, NA, NA)
for (i in 1:3) { perc_labels[i] = sprintf("%.2f %%", 100*percentage[i]) }
p = ggplot(data=df, aes(x = dataset, y=percentage, fill = dataset)) +
    geom_bar(stat="identity", ymin=0, aes(y=percentage, ymax=percentage),
             alpha=0.4, position="dodge") +
    geom_text(aes(x=dataset, y=percentage, ymax=percentage, label=perc_labels, 
              hjust=ifelse(sign(percentage)>0, 1, 0)), 
              position = position_dodge(width=1)) +
    scale_y_continuous(labels = percent_format()) +
    xlab('Dataset') +
    ylab('Percentage of noncoding transcripts (%)') +
    coord_flip() +
    theme(legend.position="top", axis.title.x=element_text(vjust=-0.5),
                                 axis.title.y=element_text(vjust=+1))

print(p)
dev.off()
