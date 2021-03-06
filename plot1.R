##########################################################################################################
##############                        Reading the data file into R                          ##############
##########################################################################################################

## Required libraries:
library(dplyr)
library(lubridate)

## Setting the working directory:
setwd("D:/Data Science/Course 4/Week 1/ExData_Plotting1")

### Reading the data file into R:
dat <- read.table("D:/Data Science/Course 4/Week 1/household_power_consumption.txt",sep=";",header = TRUE)
head(dat) ## Looking at the first few lines of data

##########################################################################################################
##############               Cleaning and Organizing the data file                          ##############
##########################################################################################################

## By looking at the data structure I can see that I need to replace "?" with NA:
str(dat)
dat[dat == "?"] <- NA

## Creating date variable:
Sys.setlocale("LC_TIME", "English")
datetime <- paste(dat$Date,dat$Time)
datetime <- as.POSIXlt(strptime(datetime,format = "%d/%m/%Y %H:%M:%S"))

## Change the Date variable to a date format:
dat$Date <- as.Date(datetime)

## Change the Time variable to a time format:
dat$Time <- datetime

## Changing the class of the different variables to match with the variables description online:
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Global_intensity <- as.numeric(as.character(dat$Global_intensity))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

## Check data structure once again:
str(dat) ## looks good

##########################################################################################################
##############                         Subset the relevant dates                            ##############
##########################################################################################################

dat <- subset(dat,Date =="2007-02-01" | Date =="2007-02-02")

## Write the clean and tidy data file onto personal directory for future use:
write.table(dat,"tidy_household_power_consumption.csv",sep=",",row.names=F)


##########################################################################################################
##############                   Plotting a histogram as required                           ##############
##########################################################################################################

## Create a PNG graphic device:
png(filename = "plot1.png",width = 480,height=480,units = "px")

## Create a histogram of the Global Active Power:
hist(dat$Global_active_power,col="red",main="Global Active Power", ylab="Frequency",xlab="Global Active Power (kilowatts)",breaks=12)

## Close the graphic device:
dev.off()
