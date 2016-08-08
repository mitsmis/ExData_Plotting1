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