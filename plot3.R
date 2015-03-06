# 5 March 2015 - R script to create Plot 3 for the first Course Project in Exploring Data

# The data were downloaded from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# After unzipping, the .txt file was placed in the R work directory.

filename <- "household_power_consumption.txt"

# First read only 1 row of data, just to copy the variable names:
df <- read.table(file=filename, header=TRUE, sep=";", nrows=1)
myNames <- names(df)

# Then read the chunk of data we want:
df <- read.table(file=filename, header=FALSE, sep=";", nrows=2880, skip=66637)
# I did the calculation of which rows to read by hand, so... let's check to verify:
head(df)
tail(df)

names(df) <- myNames

# Recode any missing values ("?" in the raw data) with proper NA
df[ df=="?"] <- NA

# Convert the date and time variables
x <- paste(df$Date, df$Time)
datetime <- dmy_hms(x)

# Open PNG and create the graph
png('plot3.png', width = 480, height = 480, units = "px")
plot(datetime, df$Sub_metering_1, type="l",
     xlab="",
     ylab="Energy sub metering")
lines(datetime, df$Sub_metering_2, col="red")
lines(datetime, df$Sub_metering_3, col="blue")    
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red","blue") )

dev.off()
