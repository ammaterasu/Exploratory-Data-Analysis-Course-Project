
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

# PLOT 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

motorBALT <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
aggmotorBALT <- aggregate(Emissions ~ year, motorBALT, sum)

ggplot(aggmotorBALT, aes(year, Emissions)) +
  geom_line(col = "pink3") + geom_point(col = "pink3", lwd = 2) +
  ggtitle("Baltimore " ~ PM[2.5] ~ "Motor Vehicle Emissions by Year") +
  ylab(~PM[2.5]~ "Motor Vehicle Emissions") + xlab("Year")

dev.copy(png,"plot5.png", width=480, height=480)
dev.off()
