##con<-file("C:/curs R/household_power_consumption.txt",open="rt")
con<-file("household_power_consumption.txt",open="rt")
x<-TRUE
while (x)
{
  x<-!grepl("1/2/2007",readLines(con,n=1), fixed=TRUE)
}

ret<-read.table(con,sep=";",nrows=2879) #insert additional parameters to read.table
close(con)

##nume<-read.table("C:/curs R/household_power_consumption.txt",sep=";",nrows=1,header=TRUE)
nume<-read.table("household_power_consumption.txt",sep=";",nrows=1,header=TRUE)
names(ret)<-names(nume)

png(filename = "plot1.png", width = 480, height = 480)
hist(ret$Global_active_power, col="red", main="Global Active Power", xlab="Global active power (kilowatts)",ylim=c(0,1400))
dev.off()
