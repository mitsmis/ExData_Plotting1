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