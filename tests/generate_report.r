#!/usr/bin/Rscript

source("./shared_utils.r")

extractDataFromLogTable <- function (logFileNamePrefix, n, c) {
  fn <- generateLogFileName(n, c, logFileNamePrefix)
  print(fn)
  t <- read.table(fn, sep=":", skip=6, comment.char='', fill=T, stringsAsFactors=FALSE, strip.white = TRUE)

#  webServer <- t$V2[1]
#  docLength <- t$V2[5]
#  concurrencyLevel <- t$V2[6]
#  totTime <- t$V2[7]
#  reqCompleted <- t$V2[8]
#  reqFailed <- t$V2[9]
#  writeErrors <- t$V2[10]
#  reqPerSec <- t$V2[13]
#  timePerReq <- t$V2[14]
#  timePerReq2 <- t$V2[15]
#  transRate <- t$V2[16]
#  total <-t$V2[22]
  t$V2[c(1,5:10,13:16,22)]
}


compareTimeResults <- function (n, c) {

  tn <- extractDataFromLogTable(webServers[1], n, c)
  th <- extractDataFromLogTable(webServers[2], n, c)
  
  timeCmp <- c(c(as.numeric(strsplit(tn[4], ' ', T)[[1]][1])), as.numeric(strsplit(th[4], ' ', T)[[1]][1]))
  #yd <- yinch(abs(diff(timeCmp)))
  #plot(timeCmp, main="Tot Time (s)", col=c("darkblue","red"), legend = c(tn[1],th[1]), ylim = c(min(timeCmp)-yd, max(timeCmp)+yd))
  
}

plotTimesCmp <- function() {
  timesCmp <- apply(tests, 1, function(x) {
    compareTimeResults(x[1], x[2])
  })
  
  cols = c('red', 'blue')
  mainTitle = "Total Time (s)"
  plot(timesCmp[1,], type='o', main=mainTitle, col=cols[1], lty=1, pch=1)
  lines(timesCmp[2,], type='o', col=cols[2], lty=2, pch=2)
  legend(1,max(timesCmp), webServers, col=c("red","blue"), cex=0.8, lty=1:2, pch=1:2)
}


webServers <- c("nginx", "httpd")

timesCmp <- apply(tests, 1, function(x) {
    compareTimeResults(x[1], x[2])
})

cols = c('red', 'blue')
plot(timesCmp[1,], type='o', main="Tot Time (s)", col=cols[1])
lines(timesCmp[2,], type='o', col=cols[2])

print(timesCmp)
