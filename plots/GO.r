path <- "../genes/gene_ontology/"
all <- read.csv(paste(path, "percent_all_r.txt", sep=''), sep='#')
hk <- read.csv(paste(path, "percent_hk_r.txt", sep=''), sep='#')
ts <- read.csv(paste(path, "percent_ts_r.txt", sep=''), sep='#')

num_classes <- 8

png('quesito_all.png', height=6, width=6, units='in', res=80)
par(mar=c(4,4,5,4))
pie(all$perc[1:num_classes], labels=all$class[1:num_classes])
dev.off()

png('quesito_hk.png', height=6, width=6, units='in', res=80)
par(mar=c(2,2,2,10))
pie(hk$perc[1:num_classes], labels=hk$class[1:num_classes])
dev.off()

png('quesito_ts.png', height=6, width=6, units='in', res=80)
par(mar=c(4,4,5,4))
pie(ts$perc[1:num_classes], labels=ts$class[1:num_classes])
dev.off()
