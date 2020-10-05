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

# PLOT 2

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

baltimore <- subset(NEI, NEI$fips == "24510")

totalBALT <- aggregate(Emissions ~ year, baltimore, sum)

plot(totalBALT$year, totalBALT$Emissions, type = "o", main = "Total Baltimore" ~ PM[2.5] ~ "Emissions by Year",
     ylab = "Total Baltimore "~ PM[2.5] ~ "Emissions", xlab = "Year", col = "pink3", lwd = 2)

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()