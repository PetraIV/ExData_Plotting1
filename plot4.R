##con<-file("C:/curs R/household_power_consumption.txt",open="rt")
con<-file("household_power_consumption.txt",open="rt")
x<-TRUE
while (x)
{
  x<-!grepl("1/2/2007",readLines(con,n=1), fixed=TRUE)
}

ret<-read.table(con,sep=";",nrows=2880) #insert additional parameters to read.table
close(con)

##nume<-read.table("C:/curs R/household_power_consumption.txt",sep=";",nrows=1,header=TRUE)
nume<-read.table("household_power_consumption.txt",sep=";",nrows=1,header=TRUE)
names(ret)<-names(nume)
ret<-transform(ret,All_date=strptime(paste(ret$Date,ret$Time),format="%d/%m/%Y %H:%M:%S"))

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

plot(Global_active_power ~ All_date, ret, xaxt = "n", type = "l", axes=FALSE,xlab=NA)
axis(2)
at <- format(ret$All_date, '%d') %in% c('01', '02','03') & format(ret$All_date, '%H:%M:%S') %in% c("00:01:00","00:00:00") 
axis(side=1, at=ret$All_date[ at ], labels=weekdays(ret$All_date[at],abbreviate = TRUE))
box()

plot(Sub_metering_1 ~ All_date, ret, xaxt = "n", type = "l", axes=FALSE,xlab=NA,ylab=NA)
points(Sub_metering_2 ~ All_date,ret,col="red",type="l")
points(Sub_metering_3 ~ All_date,ret,col="blue",type="l")
axis(2,ylab="Energy sub metering") 
axis(side=1, at=ret$All_date[ at ], labels=weekdays(ret$All_date[at],abbreviate = TRUE))

legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))
box()

plot(Voltage ~ All_date, ret, xaxt = "n", type = "l", axes=FALSE,xlab="datetime")
axis(2)
axis(side=1, at=ret$All_date[ at ], labels=weekdays(ret$All_date[at],abbreviate = TRUE))
box()

plot(Global_reactive_power ~ All_date, ret, xaxt = "n", type = "l", axes=FALSE,xlab="datetime")
axis(2)
axis(side=1, at=ret$All_date[ at ], labels=weekdays(ret$All_date[at],abbreviate = TRUE))
box()
dev.off()
