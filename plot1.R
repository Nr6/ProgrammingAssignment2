Date1 <- strptime("01/02/2007","%d/%m/%Y") # first date in data to analyse
Date2 <- strptime("02/02/2007","%d/%m/%Y") # second date in data to analyse

## Read whole data
data <- read.csv2("household_power_consumption.txt",
				stringsAsFactors = FALSE,
				na.strings = "?")

## use only data for specified dates
data <- data[strptime(data$Date, "%d/%m/%Y") == Date1 |
			 strptime(data$Date, "%d/%m/%Y") == Date2,]

png(file="plot1.png")	## open png device

hist(as.double(data$Global_active_power), 		## convert text to double
	 main="Global Active Power", 				## main heading
	 xlab = "Global Active Power (kilowatts)", 	## x-axis text
	 ylab = "Frequency", 						## y-axis text
	 border = NULL, 							## no border lines
	 col="red")									## color of bars

dev.off()	## close device
