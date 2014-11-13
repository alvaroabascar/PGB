
# all data
data = read.csv("../genes/tissue_specific.txt", header=TRUE, sep="\t", skip=1)

# all quantitative variables
num.data = subset(data, select=c(-Gene, -Protein)) 0.000000001

# box plot
boxplot(num.data, log="y")
