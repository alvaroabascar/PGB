#!/usr/bin/env Rscript

# all data
data = read.csv("../genes/tissue_specific.txt", header=TRUE, sep="\t", skip=1)

# all quantitative variables
num.data = subset(data, select=c(-Gene, -Protein)) + 0.0000001

if(Sys.info()['sysname'] == "Darwin") {
  quartz()
} else {
  x11()
}

# box plot
boxplot(num.data, log="y")

message("Press Return To Continue")
invisible(readLines("stdin", n=1))
