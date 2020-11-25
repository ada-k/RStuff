#Simulating dataset for AR(1) with ϕ = -0.6
set.seed(123456)
ts1 <- arima.sim(n = 100, list(ar = -0.6), innov=rnorm(100))

#Simulating datset for MA(1) with θ = 0.8
set.seed(123456)
ts2 <- arima.sim(n = 100, list(ma=0.8), innov=rnorm(100))

#Part a
#Plotting the Observed time series
plot.ts(ts1, main='AR(1) Process')
plot.ts(ts2, main='MA(1) Process')

#Part b
#Sample ACF
acf(ts1, main='Sample ACF for AR(1)')
acf(ts2, main='Sample ACF for MA(1)')

#Sample PACF
pacf(ts1, main='Sample PACF for AR(1)')
pacf(ts2, main='Sample PACF for MA(1)')

#Sample EACF
eacf(ts1, main='Sample EACF for AR(1)')
eacf(ts2, main='Sample EACF for MA(1)')





