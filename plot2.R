# Recreate Plot 2
png(file="plots/plot2.png",
    width=480, height=480)

plot(x = power_subset$datetime, y = as.numeric(as.character(power_subset$Global_active_power)),
     type = 'l',ylab = "Global Active Power (Kilowatts)", xlab = "")

dev.off()