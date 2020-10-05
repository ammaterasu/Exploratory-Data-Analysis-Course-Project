
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

# PLOT 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

motorBALT_LA <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
aggmotorBALT_LA <- aggregate(Emissions ~ year + fips, motorBALT_LA, sum)

ggplot(aggmotorBALT_LA, aes(year, Emissions, col = fips)) +
  geom_line() + geom_point() +
  ggtitle("Baltimore and Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year") +
  labs(y = ~PM[2.5]~ "Motor Vehicle Emissions", x = "Year") +
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
  theme(legend.title = element_text(face = "bold"))

dev.copy(png,"plot6.png", width=480, height=480)
dev.off()
