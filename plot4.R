# Read in the data file, treat "?" and blanks as NA
full_data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("?",""),
                      colClasses=c("character", "character", "numeric", "numeric",
                                   "numeric",   "numeric",   "numeric", "numeric", "numeric"))

# Filtering by date when they are still strings is unsafe. Convert.
full_data$Date <- as.Date(full_data$Date, "%d/%m/%Y")

# Filter data only for the two required days
req_data <- subset(full_data, Date == as.Date("2007/02/01") | Date == as.Date("2007/02/02"))

# Concatenate date and time and convert to POSIX datetime
req_data$DateTime <- strptime(paste(req_data$Date, req_data$Time), format="%Y-%m-%d %H:%M:%S")

# Create the graphs
png(file="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

plot(req_data$DateTime, req_data$Global_active_power, type="l", ylab="Global Active Power", xlab="")

plot(req_data$DateTime, req_data$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(req_data$DateTime, req_data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(req_data$DateTime, req_data$Sub_metering_2, col="red")
lines(req_data$DateTime, req_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

plot(req_data$DateTime, req_data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
