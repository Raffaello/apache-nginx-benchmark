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

n <- c(1L, 4L, 4L, 10L, 20L, 50L, 100L, 1000L, 10000L, 10000L, 100000L)
c <- c(0L, 2L, 4L,  4L,  8L, 10L, 100L,  100L,   100L,  1000L,   1000L)
tests <- data.frame(n, c)
