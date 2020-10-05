# require libraries 

library(ggplot2)
library(RColorBrewer)

# download file

fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
if(!file.exists("./air_pollution")){dir.create("./air_pollution")}
download.file(fileurl,destfile="./air_pollution.zip")

# unzip data

unzip(zipfile="./air_pollution.zip",exdir="./air_pollution")

# load data 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check NEI data

head(NEI)

# check SCC data 

head(SCC)

# PLOT 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


totalEY <- aggregate(Emissions ~ year, NEI, sum)

plot(totalEY$year, totalEY$Emissions, type = "o", 
     main = "Total US "~ PM[2.5]~ "Emissions by Year", 
     ylab = "Total US "~   PM[2.5] ~ "Emissions", xlab = "Year",
     col = "pink3", lwd = 2)

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()