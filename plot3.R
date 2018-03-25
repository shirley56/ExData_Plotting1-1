# Read data
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

# Plot 3
with(data, plot(dateTime, Sub_metering_1, type = "l",  ylab = "Global Active Power (kilowatts)", xlab = ""))
with(data, lines(dateTime, Sub_metering_2, col = "red"))
with(data, lines(dateTime, Sub_metering_3, col = "blue"))
legend("topright", lwd = c(1, 1, 1), cex = 0.8, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save plot
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()