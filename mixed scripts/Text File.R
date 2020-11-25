# loading the dataset
df <- read.table("CarSales.txt",header = TRUE)

#  log transformation
logautosale <- log(df$AUTOSALE)
par(mfrow=c(2,1))
# timeseries plots (original sales)
plot(df$AUTOSALE, xlab="year", ylab="sale", type="l", 
     col=1, lwd=1.5,xaxt="n")
axis(1, at=(0:27)*12, labels=1970:1997)

# timeseries plots (log-transformed sales)
plot(logautosale, xlab="time", ylab="log of sale", type="l", 
     col=1, lwd=1.5,xaxt="n")
axis(1, at=(0:27)*12, labels=1970:1997)
par(mfrow=c(1,1))
t <- 13:nrow(df)
YX <- data.frame(logY=logautosale[13:336],
                 logYpast=logautosale[12:335], t=t,
                 sin12=sin(2*pi*t/12),cos12=cos(2*pi*t/12))
YX$apr <-df$MONTH[t]==4
YX$mar <-df$MONTH[t]==3
YX$aug <-df$MONTH[t]==8
YX$oct <-df$MONTH[t]==10

 
