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