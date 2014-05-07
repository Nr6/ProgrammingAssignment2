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

## ... then add time to it (using strptime does not work),
## creating a new combination Moments
data$Moments <- as.POSIXct(paste(data$Date, data$Time))

png("plot2.png", width=480, height= 480)	## open png device

plot(data$Moments,								# Date-and-Time-Kombinatiomn
	 data$Global_active_power,					# Data to plot
	 type= "l",									# plotting lines
	 ylab= "Global Active Power (kilowatts)",	# y-axis text
	 xlab="")									# no x-axis text

dev.off()	## close device
