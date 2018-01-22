
setwd(getwd())
files=dir(path="data/bact/", pattern="fna")
x <- vector(mode="numeric", length=length(files))

for (i in 1:length(files)) {x[i]<-1/length(files)}
species<-cbind(files,x/sum(x))

write.table(species,file="data/bact/list", sep = "\t", col.names = F,row.names = F,quote = F)
