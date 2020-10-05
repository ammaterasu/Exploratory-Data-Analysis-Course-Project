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

# PLOT 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#Which have seen increases in emissions from 1999-2008?
#Use the ggplot2 plotting system to make a plot answer this question. library(ggplot2)

baltimore <- subset(NEI, NEI$fips == "24510")
typeBALT <- aggregate(Emissions ~ year + type, baltimore, sum)

ggplot(typeBALT, aes(year, Emissions, col = type)) + geom_line() + geom_point() +
  ggtitle("Total Baltimore " ~ PM[2.5] ~ "Emissions by Type and Year") +
  ylab("Total Baltimore " ~ PM[2.5] ~ "Emissions") +
  xlab("Year") +
  scale_colour_discrete(name = "Type") +
  theme(legend.title = element_text(face = "bold"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
