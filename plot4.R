# Read data
setwd("/Users/Shirley/Downloads")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
file <- unzip(temp)
unlink(temp)

data <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), sep = ";", na.strings = '?', 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Format date and time
data$Date <- as.Date(data$Date, "%d/%m/%Y")

dt <- paste(data$Date, data$Time)
dt <- setNames(dt, "DateTime")

data <- data[complete.cases(data),]
data[, 1:2] <- NULL

data$dateTime <- as.POSIXct(dt)

# Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(data, plot(dateTime, Global_active_power, type = "l", xlab="", ylab = "Global Active Power"))
with(data, plot(dateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(data, plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(dateTime, Sub_metering_2, type = "l",col = "red"))
with(data, lines(dateTime, Sub_metering_3,type = "l", col = "blue"))
legend("topright", lty = c(1, 1, 1), lwd = c(1, 1, 1), bty = "n", cex = 0.75, col = c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
with(data, plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime"))

# Save plot
# Save plot
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()