file<-"household_power_consumption.txt"

#if dataframe does not exist,read table and store it in a dataframe
if(!exists("data",inherits = FALSE))
{
  #classes of the columns of the dataframe
  data_class<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  data_names<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  
  #reading the table,reading only selective rows since we only need data for 2 days
  data<-read.table(file,sep=";",colClasses = data_class,skip=66637,nrows=2880,col.names = data_names)
  
  #removing NAs if any present
  data<-data[complete.cases(data),]
}

#Open png file
png("plot3.png",width = 480,height=480)

#setting font size of the labels
par(cex=1)
par(cex.lab=0.9)

#concatinating date and time columns
date_x<-paste(data[,"Date"],data[,"Time"])

#converting date and time object to posixlt
datetime<-strptime(date_x,format = "%d/%m/%Y %H:%M:%S")

energy_sub1<-data[,"Sub_metering_1"]
energy_sub2<-data[,"Sub_metering_2"]
energy_sub3<-data[,"Sub_metering_3"]

plot(datetime,energy_sub1,type="n",xlab = "",ylab = "Energy sub metering")
lines(datetime,energy_sub1)
lines(datetime,energy_sub2,col="red")
lines(datetime,energy_sub3,col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.8)

#Closing png file
dev.off()