# This tool is to create a species distribution
library("poilog")
# 
args<-commandArgs(trailingOnly=TRUE)

# x<-rls(100,N=100,alpha=5) log serie
# x<-rpoilog(100,1,0.1) poisson log
# test if there is at least one argument: if not, return an error

if (length(args)==2) {
  dist <- args[1]
  folder <- args[2]
  } else {
    cat("A small script to simulate species abundance distribution\n")
    cat("Please keep in mind that you need a folder with reference sequences (currently in fna format)\n")
    cat("Output will be a tab delimited text file called: 'list'\n")
    cat("You should specify 2 options:\n")
    cat("1. A species distribution model:\n")
    cat("\t e\t no abundance, every species will be equally distributed\n")
    cat("\t ln\t create a log-normal species abundace distribution\n")
    cat("\t pl\t create a poisson log-normal species abundance distribution\n")
    cat("2. Specify the directory where you keep your sequence files\n")
    cat("That's all!\n")
    stop()
  }

files=dir(path=folder, pattern="fna")
x <- vector(mode="numeric", length=length(files))

if (dist == "e") {
  for (i in 1:length(files)) {x[i]<-1/length(files)}
  species<-cbind(files,x/sum(x))
}

if (dist == "ln") {
  x <- rlnorm(n=length(files), meanlog=0, sdlog=1)
  species<-cbind(files,x/sum(x))
}

if (dist == "pl") {
  x<-rpoilog(S=length(files),mu=2,sig=1)
  species<-cbind(files,x/sum(x))
}

write.table(species,file="data/bact/list", sep = "\t", col.names = F,row.names = F,quote = F)
