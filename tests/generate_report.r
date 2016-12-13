#!/usr/bin/Rscript

source("./shared_utils.r")

extractDataFromLogTable <- function (logFileNamePrefix, n, c) {
  fn <- generateLogFileName(n, c, logFileNamePrefix)
  #print(fn)
  tryCatch({
  t <- read.table(fn, sep=":", skip=6, comment.char='', fill=T, stringsAsFactors=FALSE, strip.white = TRUE)
  
#1.   webServer <- t$V2[1]
#2.   docLength <- t$V2[5]
#3.   concurrencyLevel <- t$V2[6]
#4.   totTime <- t$V2[7]
#5.   reqCompleted <- t$V2[8]
#6.   reqFailed <- t$V2[9]
#7.   writeErrors <- t$V2[10]
#8.   reqPerSec <- t$V2[13]
#9.   timePerReq <- t$V2[14]
#10.  timePerReq2 <- t$V2[15]
#11.  transRate <- t$V2[16]
#12.  total <-t$V2[22]
  t$V2[c(1,5:10,13:16,22)]
  }, error = function(err) {
     r <-rep(0,12)
     r[c(1,4)] <- ''
  })
}

compareTimeResults <- function (n, c) {
  tn <- extractDataFromLogTable(webServers[1], n, c)
  th <- extractDataFromLogTable(webServers[2], n, c)

  timeCmp <- c(c(as.numeric(strsplit(tn[4], ' ', T)[[1]][1])), as.numeric(strsplit(th[4], ' ', T)[[1]][1]))
}

plotTimesCmp <- function() {
  timesCmp <- apply(tests, 1, function(x) {
    compareTimeResults(x[1], x[2])
  })
  
  cols <- c('red', 'blue')
  mainTitle <- "Total Time (s)"
  ymax <- max(timesCmp, na.rm = T)
  g_range <- range(0, ymax)
  print (g_range)
  plot(timesCmp[1,], type='o', main=mainTitle, col=cols[1], lty=1, pch=1, ylim = g_range, axes = F, ann = F)
  dt <- dim(tests)
  axis(1, at=1:dt[1], lab=paste(paste('n',tests$n, sep=''), paste('c',tests$c, sep=''), sep='-'), las=2)
  axis(2, las=1)
  box()
  lines(timesCmp[2,], type='o', col=cols[2], lty=2, pch=2)
  legend(1,ymax, webServerNames, col=c("red","blue"), cex=0.8, lty=1:2, pch=1:2)
  print(timesCmp)
}

compareRequestFailed <- function(n, c) {
  tn <- extractDataFromLogTable(webServers[1], n, c)
  th <- extractDataFromLogTable(webServers[2], n, c)
  
  reqFailed <- c(as.numeric(tn[6]), as.numeric(th[6]))
}

barplotReqestFailedCmp <- function() {
  reqFailedCmp <- apply(tests, 1, function(x) {
    compareRequestFailed(x[1], x[2])
  })
  
  cols <- c("red", "blue")
  mainTitle <- "Request Failed"
  ymax <- max(reqFailedCmp, na.rm = T)
  g_range <- range(0, ymax)
  print (g_range)
  barplot(reqFailedCmp, main=mainTitle, col=cols, beside = T, names.arg=paste(paste('n',tests$n, sep=''), paste('c',tests$c, sep=''), sep='-'), las=2) #axes = F, ann = F)
  dt <- dim(tests)
  box()
  legend("topleft", webServerNames, cex=0.6,  bty="n", fill=cols);
  print(reqFailedCmp)
}

webServers <- c("nginx", "httpd")
webServerNames <- c(
    extractDataFromLogTable(webServers[1],tests$n[1], tests$c[1])[1],
    extractDataFromLogTable(webServers[2],tests$n[1], tests$c[1])[1]
)

nginx <- apply(tests, 1, FUN=function(x) { extractDataFromLogTable(webServers[1], x[1], x[2]) })
httpd <- apply(tests, 1, FUN=function(x) { extractDataFromLogTable(webServers[2], x[1], x[2]) })
plotTimesCmp()
barplotReqestFailedCmp()
