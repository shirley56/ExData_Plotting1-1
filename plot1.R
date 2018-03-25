# Read data
setwd("/Users/Shirley/Downloads")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
file <- unzip(temp)
unlink(temp)

data <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), sep = ";", na.strings = '?', 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                            "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 1
hist(data$Global_active_power, col = "Red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Save plot
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

