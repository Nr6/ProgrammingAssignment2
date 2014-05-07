Date1 <- strptime("01/02/2007","%d/%m/%Y")	# first date in data to analyse
Date2 <- strptime("02/02/2007","%d/%m/%Y")	# second date in data to analyse

## Read whole data
data <- read.csv2("household_power_consumption.txt",
				stringsAsFactors = FALSE,
				na.strings = "?")

## use only data for specified dates
data <- data[strptime(data$Date, "%d/%m/%Y") == Date1 | 
			 strptime(data$Date, "%d/%m/%Y") == Date2,]


## In order to use a combination of date and time
## (there are only two days, so date alone wouldn't produce sufficient data')
## we use a combination of date and time

## first convert character to date ...
data$Date <- strptime(data$Date, "%d/%m/%Y")

## ... then add time to it (using strptime does not work), creating a new combination Moments
data$Moments <- as.POSIXct(paste(data$Date, data$Time))

png("plot3.png", width=480, height= 480)	## open png device

plot(data$Moments,								# Date-and-Time-Kombinatiomn
	 data$Sub_metering_1,						# Data to plot
	 type= "n",									# draw frame only, no data
	 ylab= "Energy sub metering",				# y-axis text
	 xlab="")									# no x-axis text
points(data$Moments,
	   data$Sub_metering_1,						# actual data
	   type= "l",								# plottinng lines
	   col="black")								# black color
points(data$Moments,
	   data$Sub_metering_2,						# actual data
	   type= "l",								# plotting lines
	   col="red")								# red color
points(data$Moments,
	   data$Sub_metering_3,						# actual data
	   type= "l",								# plotting lines
	   col="blue")								# blue color
legend("topright",								
	   c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # legend texts
	   lty=c(1,1,1),										  # lines
	   lwd=c(2.5,2.5,2.5),									  # line length
	   col=c("black","red","blue"))							  # line colors

dev.off()	## close device
