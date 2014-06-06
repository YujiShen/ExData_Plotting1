#load data.table package
library(data.table)

#get the colClasses and read table
tab5rows <- fread("household_power_consumption.txt", header = T, sep = ";", nrow = 5, na.string = '?')
classes <- sapply(tab5rows, class)
power <- fread("household_power_consumption.txt", header = T, sep = ";", na.string = '?', colClasses = classes)

#set key for binary search
setkey(power, Date)
#subset the data
data <- power[c("1/2/2007", "2/2/2007")]
#create a new date-time column by "Date" and "Time"
data[, DateTime := {temp <- paste(Date, Time); as.POSIXct(strptime(temp, "%d/%m/%Y %H:%M:%S"))}]

# Plot 3
png("plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()