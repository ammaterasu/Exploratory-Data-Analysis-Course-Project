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

# PLOT 4 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

SCC_coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC,]
totalCOAL <- aggregate(Emissions ~ year + type, NEI_coal, sum)

ggplot(totalCOAL, aes(year, Emissions, col = type)) + geom_line() + geom_point() +
  ggtitle("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  xlab("Year") +
  scale_colour_discrete(name = "Type") +
  theme(legend.title = element_text(face = "bold"))

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
