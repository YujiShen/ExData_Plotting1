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

# Plot 1
png("plot1.png", width = 480, height = 480)
hist(as.numeric(unlist(data$Global_active_power)), breaks=12, main = 'Global Active Power', col='red', xlab='Global Active Power (kilowatts)' )
dev.off()
