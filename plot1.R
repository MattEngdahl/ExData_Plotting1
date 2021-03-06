## A. Read in the data and create a smaller, easier to use data frame
#####################################################################

## 1. Read in the text file
lines <- readLines("household_power_consumption.txt")

## 2. Get the index of the lines with header, and data for appropriate dates
index_of_lines <- which(grepl("^Date", lines) | grepl("^1/2/2007", lines) | grepl("^2/2/2007", lines))

## 3. Create a short version of the data file
lines_short <- lines[index_of_lines]

## 5. Get the smaller data file into a data frame by using read.csv
data <- read.csv(textConnection(lines_short), sep=";")

## 4. Remove obsolete values from the environment to clear memory
remove("lines")
remove("index_of_lines")
remove("lines_short")

## 5. Convert date and time to date and time classes from factors
data$dt <- paste(data$Date, data$Time, sep=" ")
data$dt <- strptime(data$dt, format="%d/%m/%Y %H:%M:%S")

## 6. Recode all ?-marks to proper NA values (there are none anyway)
data[data == "?"] <- NA

## B. Plot 1
############

png("plot1.png")
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()

