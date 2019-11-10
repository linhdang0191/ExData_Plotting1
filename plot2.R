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

with(data, plot(Time, Global_active_power,type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)'))

# SAVE THE PLOT TO PNG 
dev.copy(png, 'plot2.png', height = 480, width = 480)
dev.off()