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
png("plot2.png",width = 480,height=480)

#setting font size of the labels
par(cex=1)
par(cex.lab=0.9)

#concatinating date and time columns
date_x<-paste(data[,"Date"],data[,"Time"])

#converting date and time object to posixlt
datetime<-strptime(date_x,format = "%d/%m/%Y %H:%M:%S")

global_active_power<-data[,"Global_active_power"]

plot(datetime,global_active_power,type="n",xlab = "",ylab="Global Active Power (kilowatts)")
lines(datetime,global_active_power)

#Closing png file
dev.off()