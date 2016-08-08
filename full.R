# Set Working Directory
setwd("~/JohnHopkins/EDA")

# Data is available for Download on Coursera, but in the event that you
# prefer to tap the data from the source, here is the code to do that.
if(!file.exists('power_consumption.zip')){
  url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url, destfile = "power_consumption.zip")
}

# Unzip the file
unzip("power_consumption.zip")


# I chose to download the file the old fashioned way through Coursera, but
# chose to include the methods above, which would have required a longer
# argument to the "power_consumption.zip" folder, which I did not feel 
# like typing out.
power <- read.table("household_power_consumption.txt",header = TRUE, sep= ";")

# Examine the variables in the data set.
names(power)
# Results:
  # [1] "Date"                  "Time"                  "Global_active_power"  
  # [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
  # [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

# Examine the class of the variables
lapply(power, class)
# Results:
  # $Date
  # [1] "factor"
  # $Time
  # [1] "factor"
  # $Global_active_power
  # [1] "factor"
  # $Global_reactive_power
  # [1] "factor"
  # $Voltage
  # [1] "factor"
  # $Global_intensity
  # [1] "factor"
  # $Sub_metering_1
  # [1] "factor"
  # $Sub_metering_2
  # [1] "factor"
  # $Sub_metering_3
  # [1] "numeric"

# Examine the first five observations of the data set
head(power, 5)

# Examine the last five observations of the data set
tail(power, 5)

# Begin to create a variable that house date and time together
# Utilize the 'paste' function to accomplish this
power$datetime <- paste(power$Date, power$Time)

# Leverage strptime to reformat our data, so that our new variable
# of date time is formatted the right way. We need to reformat, because
# the data was loaded as a factor.
power$datetime <- strptime(power$datetime, "%d/%m/%Y %H:%M:%S")

# Now we would like to work with a specific range of dates, this can
# be accomplish before loading all of the data.
# Examine the Data
head(power$datetime,5)
tail(power$datetime,5)

#Does not appear to have any "seconds" recorded, which comes in handy on my
# next line of code to mark the "begin" and "end" points for the data set.

# Begin Date stored as object 'begin':
begin <- which(power$datetime == 
                 strptime("2007-02-01", "%Y-%m-%d"))
# End Date stored as object 'end':
end <- which(power$datetime == 
               strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

# Leverage the 'begin' and 'end' objects to pull all of the data
# "equal to" 2007-02-01 and "between 2007-02-01 and 2007-02-02 23:59:00"
# Store this data set in the 'power_subset' data set.

power_subset <- power[begin:end,]

# Now that we have a somewhat tidy data set, we can now begin to examine
# the data contained within by creating some exploratory data plots
# using some base data visuals.

# First Examine Summary of the Variables:
summary(power_subset$datetime)
# Date Range Checks Out, yields 2880 obs, over 10 variables
summary(power_subset$Global_active_power)
summary(power_subset$Global_reactive_power)
summary(power_subset$Global_Voltage)

# This plot caused me a major headache, I used 'as.numeric' to start off the bat
# and couldn't figure out why my graph was not working out for me.
# Converting from a 'Factor' variable to as.numeric yielded the wrong value for me.
# This was because R was calculating the "internal level representation of your factor
# and not the original values. Source of info:
# http://www.dummies.com/how-to/content/how-to-convert-a-factor-in-r.html
# as.numeric(as.character(power_subset$Global)) is the course of action.

# Recreate Plot 1
png(file="plots/plot1.png",
    width=480, height=480)

hist(as.numeric(as.character(power_subset$Global_active_power)),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
# LOL, I was getting real hot at why my graph wouldn't show and why I kept
# getting an error that I didn't have access rights to them. USE dev.off,
# again, took me about 15 minutes to use it.
# Source of Info:
# http://statistics.berkeley.edu/computing/saving-plots-r
dev.off()

# Recreate Plot 2
png(file="plots/plot2.png",
    width=480, height=480)

plot(x = power_subset$datetime, y = as.numeric(as.character(power_subset$Global_active_power)),
     type = 'l',ylab = "Global Active Power (Kilowatts)", xlab = "")

dev.off()

# Recreate Plot 3
png(file="plots/plot3.png",
    width=480, height=480)

plot(power_subset$datetime, as.numeric(as.character(power_subset$Sub_metering_1)),type='l', 
     ylab ="Energy sub metering", xlab="")
lines(power_subset$datetime, as.numeric(as.character(power_subset$Sub_metering_2)),type='l', col='red')
lines(power_subset$datetime, power_subset$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1)
       ,col=c("black","red","blue"))

dev.off()

# Recreate Plot 4
png(file="plots/plot4.png",
    width=480, height=480)

par(mfcol=c(2,2))

plot(power_subset$datetime, as.numeric(as.character(power_subset$Global_active_power)),
     type='l',ylab="Global Active Power", xlab="")

plot(power_subset$datetime, as.numeric(as.character(power_subset$Sub_metering_1)),
     type='l', xlab="",ylab ="Energy sub metering")
lines(power_subset$datetime, as.numeric(as.character(power_subset$Sub_metering_2)),
      type='l', col='red')
lines(power_subset$datetime, power_subset$Sub_metering_3,
      type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))

plot(power_subset$datetime, as.numeric(as.character(power_subset$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )

plot(power_subset$datetime, as.numeric(as.character(power_subset$Global_reactive_power)),type='l', 
     ylab="Global_reactive_power",xlab="datetime" )

dev.off()

#THE END