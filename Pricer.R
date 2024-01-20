

#### the company
ticker <- "MSFT"
#### year mindows
lookback <- 1

### only thing we need
if (!require(quantmod)) install.packages("quantmod")

### set window
start <- last(seq(Sys.Date(), by = paste0("-",lookback,' years'), length = 2),1)
### create 
D <- setNames(getSymbols(ticker,auto.assign=FALSE,from=start),c("Open","High","Low","Close","Vol","Adj"))
D$Prev_Close <- lag(D$Close)
D$ID_Ret <- log(D$High/D$Prev_Close)
D$Diff <- NA
D$Diff[-1] <- as.numeric(index(D)[-1] - index(D)[-length(index(D))])
D$Diff <- as.factor(D$Diff)

#D$Long_Gap <- ifelse(D$Diff > 1,1,0)


res <- aov(data=D,ID_Ret ~ Diff)

summary(res)

