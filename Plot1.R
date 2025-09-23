library(dplyr)
library(lubridate)
datasheet<- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors = TRUE)
datasheet$Date <- dmy (datasheet$Date)
datasheet$Time <- hms (datasheet$Time)
datasheet$datetime <- datasheet$Date + datasheet$Time
datasheet$datetime <- 
dataset <- subset(datasheet, Date >="2007-02-01" & Date <= "2007-02-02")
dataset <- dataset %>%
  mutate(across(c(Global_active_power, 
                  Global_reactive_power, 
                  Voltage, 
                  Global_intensity, 
                  Sub_metering_1, 
                  Sub_metering_2),
                ~ as.numeric(na_if(., "?"))))
png(filename="Plot1.png", width = 480, height = 480)
hist(dataset$Global_active_power/1000, col="red", main="Global Active Power", xlab="Global Active Power (kilowats)")
dev.off()
