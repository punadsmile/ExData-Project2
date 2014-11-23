#due to network problem, I mannually downloaded the files...and unziped it...and set the wd...
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#sampling
NEISamp <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

#aggregates
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM25 <- round(Emissions[, 2] / 1000, 2)

#make the plot
png(filename = "plot1.png")
barplot(Emissions$PM25, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))

#finish
dev.off()