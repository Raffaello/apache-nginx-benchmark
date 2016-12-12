#!/usr/bin/Rscript

stopifnot(list.dirs()[2] == "./logs")

generateLogFileName <- function(n, c, log, csv=FALSE) {
    res <- paste("logs/", log, "-n", n, sep='')

    if (c > 0) {
        res <- paste(res, "-c", c, sep='')
    }

    res <- paste(res, ".log", sep='')
    if (csv) {
        res <- paste(res,".csv", sep='')
    }

    return(res)
}

generateCommand <- function(log, n, c=0) {
    opt <- paste("-n", n)
    if (c > 0) {
        opt <- paste(opt,"-c", c)
    }

    res <- paste("ab -e", generateLogFileName(n,c, log, T), opt, "abtest.dev/index.php >", generateLogFileName(n,c, log))
    return(res)
}

dfWrapper <- function (x) {
    res <- generateCommand(log, x[1], x[2])
    #print (res)

    return(res)
}

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

log <- args[1]

n <- c(4L, 4L, 10L, 20L, 50L, 100L, 1000L, 10000L, 10000L, 100000L)
c <- c(2L, 4L,  4L,  8L, 10L, 100L,  100L,   100L,  1000L,   1000L)
tests <- data.frame(n, c)

# first one with -n 1
cmd <- generateCommand(log, 1)
print(cmd)
out <- system(cmd)
print(out)
cmds <- apply(tests, 1, dfWrapper)
for (cmd in cmds) {
    print (cmd)
    out <- system(command=cmd)
    print(out)
}
