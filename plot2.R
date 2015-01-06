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

# Create the graph
png(file="plot2.png", width=480, height=480, units="px")

plot(req_data$DateTime, req_data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()
