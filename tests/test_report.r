#!/bin/r

stopifnot(list.dirs()[2] == "./logs")

generateLogFileName <- function(n, c, csv=FALSE) {
    res <- paste("logs/httpd-n", n, sep='')

    if (c > 0) {
        res <- paste(res, "-c", c, sep='')
    }

    res <- paste(res, ".log", sep='')
    if (csv) {
        res <- paste(res,".csv", sep='')
    }

    return(res)
}

generateCommand <- function(n, c=0) {
    opt <- paste("-n", n)
    if (c > 0) {
        opt <- paste(opt,"-c", c)
    }

    res <- paste("ab -e", generateLogFileName(n,c, T), opt, "abtest.dev/index.php >", generateLogFileName(n,c))
    return(res)
}

n <- c(4L, 4L, 10L, 20L, 50L, 100L, 1000L, 10000L, 10000L, 100000L)
c <- c(2L, 4L,  4L,  8L, 10L, 100L,  100L,   100L,  1000L,   1000L)
tests <- data.frame(n, c)

# first one with -n 1
cmd <- generateCommand(1)
print(cmd)
ret <- system(cmd)
rets <- apply(apply(tests, 1, generateCommand), 2, system)

