## (there are only two days, so date alone wouldn't produce sufficient data')
## we use a combination of date and time

## first convert character to date ...
data$Date <- strptime(data$Date, "%d/%m/%Y")

## ... then add time to it (using strptime does not work),
## creating a new combination Moments
data$Moments <- as.POSIXct(paste(data$Date, data$Time))

png("plot2.png", width=480, height= 480)	# open png device

par(mfrow = c(2,2))							# 2x2 plots, row-wise

# row 1, col 1
plot(data$Moments,
	 data$Global_active_power,
	 type= "l",
	 ylab= "Global Active Power (kilowatts)",
	 xlab="")

# row 1, col 2
plot(data$Moments,
	 data$Voltage,
	 type= "l",
	 ylab= "Voltage",
	 xlab="datetime")

# row 2, col 1
plot(data$Moments,
	 data$Sub_metering_1,
	 type= "n",
	 ylab= "Energy sub metering",
	 xlab="")
points(data$Moments,
	data$Sub_metering_1,
	type= "l",
	col="black")
points(data$Moments,
	   data$Sub_metering_2,
	   type= "l",
	   col="red")
points(data$Moments,
	   data$Sub_metering_3,
	   type= "l",
	   col="blue")
legend("topright",
	   c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
	   lty=c(1,1,1),
	   lwd=c(2.5,2.5,2.5),
	   col=c("black","red","blue"))

# row 2, col 2
plot(data$Moments,
	 data$Global_reactive_power,
	 type= "l",
	 ylab= "Global reactive power",
	 xlab="datetime")

dev.off()	## close device
