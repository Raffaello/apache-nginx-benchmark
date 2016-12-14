#!/usr/bin/Rscript

stopifnot(list.dirs()[2] == "./logs")

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

log <- args[1]

source("./shared_utils.r")

generateCommand <- function(log, n, c=0) {
    opt <- paste("-n", n, "-k", "-H 'Accept-Encoding: gzip,deflate'")
    if (c > 0) {
        opt <- paste(opt,"-c", c)
    }

    res <- paste("ab -e", generateLogFileName(n,c, log, T), opt, "abtest.dev/index.php >", generateLogFileName(n,c, log))
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
