#!/usr/bin/Rscript

stopifnot(list.dirs()[2] == "./logs")

args = commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

log <- args[1]
url <- args[2]
name2 <- strsplit(url, '/')[[1]][2]
log <- paste(log,'-',name2, sep='')

source("./shared_utils.r")

generateCommand <- function(log, n, c=0) {
    opt <- paste("-n", n, "-r", "-k", "-H 'Accept-Encoding: gzip,deflate'")
    if (c > 0) {
        opt <- paste(opt,"-c", c)
    }

    res <- paste("ab -e", generateLogFileName(n,c, log, T), opt, url, " >", generateLogFileName(n,c, log))
    return(res)
}

dfWrapper <- function (x) {
    generateCommand(log, x[1], x[2])
}

cmds <- apply(tests, 1, dfWrapper)
for (cmd in cmds) {
    print (cmd)
    out <- system(command=cmd)
    print(out)
}
