#due to network problem, I mannually downloaded the files...and unziped it...and set the wd...
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#Sampling
NEISamp <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

#select Baltimore City
BC <- subset(NEI, fips == '24510')

#make the plot
png(filename = 'plot2.png')
barplot(tapply(X = BC$Emissions, INDEX = BC$year, FUN = sum), main = 'Total Emission in Baltimore City, Maryland', xlab = 'Year', ylab = expression('PM'[2.5]))
dev.off()