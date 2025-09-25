library(dplyr)
library(lubridate)
datasheet <- read.delim(
  "household_power_consumption.txt",
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)
datasheet$Date <- dmy (datasheet$Date)
datasheet$Time <- hms (datasheet$Time)
datasheet$datetime <- as.POSIXct(datasheet$Date + datasheet$Time, tz = "UTC")
dataset <- subset(datasheet, Date >="2007-02-01" & Date <= "2007-02-02")

num_cols <- c("Global_active_power", "Global_reactive_power", "Voltage",
              "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
dataset <- dataset %>%
  mutate(across(all_of(num_cols), ~ as.numeric(.)))
png(filename="Plot3.png", width = 480, height = 480)
with(dataset, {plot(datetime,Sub_metering_1, type="l",xaxt="n", yaxt="n", ylab="Energy sub metering", xlab="") 
  lines(datetime,Sub_metering_2, type="l",col="red")
  lines(datetime,Sub_metering_3, type="l", col="blue")})
axis(1, at = pretty(dataset$datetime,n=2), labels = wday(pretty(dataset$datetime,n=2), label = TRUE))
axis(2, at=c(10,20,30))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),lty=1)
dev.off()
