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
png(filename="Plot1.png", width = 480, height = 480)
hist(dataset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowats)")
dev.off()
