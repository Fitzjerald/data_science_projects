wheat = read.csv("PWHEAMTUSDM.csv",na.strings="null")
wheat = wheat[2:(nrow(wheat)),]
X <- as.numeric(wheat[,2]); T <- as.Date(wheat[,1])
flour = read.csv("WPU02120301.csv",na.strings="null")
flour = flour[2:(nrow(flour)), ]
Y <- flour[,2] # gleicher Zeitraum!
n <- length(T)

par(mfrow=c(2,1),mar=c(2,2,0.5,2),pch=20)
plot(T,X,col="blue", type = 'l'); lines(T,Y, col = 'red')
mtext(" (a)",side=4,las=1)  
y <- log(Y); x <- log(X)
plot(T,x,col="blue", type = 'l'); lines(T,y,col="red")
mtext(" (b)",side=4,las=1) 
par(mfcol=c(3,2),mar=c(2,2,0.5,2),pch=20)
plot(T,x,col="blue"); h <- 1:n; H <- lm(x~h) 
lines(T,H$fitted.values,lwd=2); mtext(" (a)",side=4,las=1)  
xres <- H$residuals; plot(T,xres); mtext(" (c)",side=4,las=1)  
acf(xres); mtext(" (e)",side=4,las=1) 
plot(T,y,col="red"); H <- lm(y~h) 
lines(T,H$fitted.values,lwd=2); mtext(" (b)",side=4,las=1)  
yres <- H$residuals; plot(T,yres); mtext(" (d)",side=4,las=1)  
acf(yres); mtext(" (f)",side=4,las=1) 
par(mfcol=c(3,2),mar=c(2,2,0.5,2),pch=20); h <- 2*pi
H <- spec.pgram(x,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (a)",4,las=1)
H <- spec.pgram(xres,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (c)",4,las=1)
plot(log(h*H$freq[1:20]),log(H$spec[1:20]/h),type="o",lwd=2)  
mtext(" (e)",4,las=1) 
for (c in (-15):(-4)) abline(a=c,b=-1,col="gray")
H <- spec.pgram(y,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (b)",4,las=1)
H <- spec.pgram(yres,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (d)",4,las=1)
plot(log(h*H$freq[1:20]),log(H$spec[1:20]/h),type="o",lwd=2)  
mtext(" (f)",4,las=1) 
for (c in (-15):(-4)) abline(a=c,b=-1,col="gray")
dx <- x[2:n]-x[1:(n-1)]; dy <- y[2:n]-y[1:(n-1)]
par(mfcol=c(3,2),mar=c(2,2,0.5,2),pch=20); h <- 2*pi
plot(T[2:n],dx,type="l"); mtext(" (a)",4,las=1)
H <- spec.pgram(dx,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (c)",4,las=1)
HH <- spec.pgram(dx,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE,spans=5)
lines(h*HH$freq,HH$spec/h,col="blue",lwd=2)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (e)",4,las=1)
HH <- spec.pgram(dx,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE,spans=10)
lines(h*HH$freq,HH$spec/h,col="blue",lwd=2)
plot(T[2:n],dy,type="l"); mtext(" (b)",4,las=1)
H <- spec.pgram(dy,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (d)",4,las=1)
HH <- spec.pgram(dy,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE,spans=10)
lines(h*HH$freq,HH$spec/h,col="red",lwd=2)
plot(h*H$freq,H$spec/h,type="l"); mtext(" (f)",4,las=1)
HH <- spec.pgram(dy,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE,spans=25)
lines(h*HH$freq,HH$spec/h,col="red",lwd=2)
par(mai = c(0.4, 0.4, 0.4, 0.4))
D <- cbind(dx,dy); D <- ts(D); acf(D, ylab = '', xlab = '', ylim = c(-0.2, 1), main = '')

par(mfcol=c(1,2),mar=c(2,2,0.5,2),pch=20); h <- 2*pi
H <- spec.pgram(dx,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,cumsum(H$spec)/sum(H$spec),type="l"); mtext(" (a)",4,las=1)
H <- arima(dx,order=c(2,0,0),include.mean=TRUE,transform.pars=TRUE)
dx.res <- H$residuals
H <- spec.pgram(dx.res,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
lines(h*H$freq,cumsum(H$spec)/sum(H$spec),col="red")
H <- spec.pgram(dy,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
plot(h*H$freq,cumsum(H$spec)/sum(H$spec),type="l"); mtext(" (b)",4,las=1)
H <- arima(dy,order=c(2,0,0),include.mean=TRUE,transform.pars=TRUE)
dy.res <- H$residuals
H <- spec.pgram(dy.res,taper=0,detrend=FALSE,fast=FALSE,plot=FALSE)
lines(h*H$freq,cumsum(H$spec)/sum(H$spec),col="red")

par(mai = c(0.4, 0.4, 0.4, 0.4))
D <- cbind(dx.res,dy.res); D <- ts(D); acf(D, ylab = '', xlab = '', ylim = c(-0.2, 1), main = '')

par(mfcol=c(2,1),mar=c(2,2,0.5,2),pch=20); h <- 2*pi
H1 <- spec.pgram(D,taper=0,detrend=F,fast=F,plot=F,spans=20)
plot(H1$freq*h,H1$coh,type="l",col="orange3")
H2 <- spec.pgram(D,taper=0,detrend=F,fast=F,plot=F,spans=30)
lines(H2$freq*h,H2$coh,col="darkgreen"); mtext(" (a)",4,las=1)
plot(H1$freq*h,H1$phase,type="l",col="orange3")
lines(H2$freq*h,H2$phase,col="darkgreen"); mtext(" (b)",4,las=1)   

# AR-Spektrum eines vektorautoregressiven Prozesses 
var.spec <- function(fr,AR.p) {
  # fr ... Frequenzen, AR.p ... AR(p) Modell geschÃ¤tzt mit R-Funktion ar
  nf <- length(fr); p <- AR.p$order 
  sigma <- AR.p$var.pred; k <- length(sigma[1,])
  Id <- diag(1,nrow=k,ncol=k) # identity matrix
  sp <- array(dim=c(nf,k,k))
  for (w in 1:nf) {
    A <- Id
    for (l in 1:p) A <- A-AR.p$ar[l,,]*exp(-1i*fr[w]*l)
    A <- solve(A) # inverse of A 
    sp[w,,] <- A%*%sigma%*%t(Conj(A)) }
  return(sp/(2*pi)) }
fr <- H1$freq*(2*pi); AR.3 <- ar(D,order.max=3,aic=FALSE,demean=TRUE)
AR.1 <- ar(D,order.max=3,aic=FALSE,demean=TRUE)
AR.2 <- ar(D,order.max=6,aic=FALSE,demean=TRUE)
sp.1 <- var.spec(fr,AR.1); sp.2 <- var.spec(fr,AR.2)

par(mfcol=c(2,2),mar=c(2,2,0.5,2),pch=20); 
plot(fr,Re(sp.1[,1,2]),type="l",col="darkgreen"); abline(h=0,lty=2)   
lines(fr,Re(sp.2[,1,2]),col="orange3"); mtext(" (a)",4,las=1) 
plot(fr,-Im(sp.1[,1,2]),type="l",col="darkgreen"); abline(h=0,lty=2)
lines(fr,-Im(sp.2[,1,2]),col="orange3"); mtext(" (b)",4,las=1)
plot(fr,Mod(sp.1[,1,2])^2/(sp.1[,1,1]*sp.1[,2,2]),type="l",col="darkgreen")
lines(fr,Mod(sp.2[,1,2])^2/(sp.2[,1,1]*sp.2[,2,2]),col="orange3")
mtext(" (c)",4,las=1)  
plot(fr,Arg(sp.1[,1,2]),type="l",col="darkgreen"); mtext(" (d)",4,las=1) 
lines(fr,Arg(sp.2[,1,2]),col="orange3") 

h <- read.csv("PWHEAMTUSDM.csv",na.strings="null"); h = h[2:(nrow(h)),]; X <- as.numeric(h[,2]); T <- as.Date(h[,1])
h <- read.csv("WPU02120301.csv",na.strings="null"); h = h[2:(nrow(h)), ]; Y <- h[,2]  
n <- length(T); n1 <- n-1; y <- log(Y); x <- log(X)
O1 <- 1:n; O2 <- O1^2; O3 <- O1^3
dx <- x[2:n]-x[1:n1]; dy <- y[2:n]-y[1:n1]; T1 <- T[-1]  

library(tseries)
adf.test(x, alternative = 'stationary', k = 0) 
adf.test(x, alternative = 'stationary', k = trunc((length(x)-1)^(1/3))) # 4, r recommend
adf.test(x, alternative = 'stationary', k = 8)

adf.test(y, alternative = 'stationary', k = 0) 
adf.test(y, alternative = 'stationary', k = trunc((length(y)-1)^(1/3))) # 4, r recommend
adf.test(y, alternative = 'stationary', k = 8)

library(urca)
h <- ca.jo(ts(cbind(x,y)),K=10,ecdet="const")
# with constant and lag order=10
summary(h)