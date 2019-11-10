### NOTE: 
# I assume that the data file has been downloaded and unzipped already. 

# READ THE DATA 

# Since the original dataset is very large, I have opened it in advance with VS Code to count the columns
# to import :P. Hence, only import the data we need. The data for our 2 days of interest contain 2880
# observations and 9 columns (1 - 1440 is 2007-02-01, 1441 - 2880 is 2007-02-02)

data <- read.table('household_power_consumption.txt', skip = 66637, nrows = 2880, sep = ';',
                   col.names = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power',
                                 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2',
                                 'Sub_metering_3'), na.strings = '?')

# CONVERT THE DATE AND TIME VARIABLES 
# Date 
data$Date <- as.Date(data$Date, format = '%d/%m/%Y') # format : dd/mm/yyyy

#Now the dramas with Time

data$Time <- strptime(data$Time, '%H:%M:%S')

# Change the date backs to 2007-02-01 and 2007-02-02
data$Time[1:1440] <- format(data$Time[1:1440], '2007-02-01 %H:%M:%S')
data$Time[1441:2880] <- format(data$Time[1441:2880], '2007-02-02 %H:%M:%S')

# PLOTTING TIME 

with(data, {
  plot(Time,Sub_metering_1, type = 'l', xlab ='', ylab = 'Energy sub metering')
  lines(Time, Sub_metering_2, type = 'l', col = 'red')
  lines(Time, Sub_metering_3, type = 'l', col = 'blue')
})

#Add the legends. I set cex = 0.75 so that the legend does not take up too much area
legend('topright', col = c('black', 'red','blue'), legend = c('Sub_metering_1', 'Sub_metering_2',
                                                              'Sub_metering_3'), lwd = 1, cex = 0.75)
# SAVE TO PNG
dev.copy(png, 'plot3.png', height = 480, width = 480)
dev.off()