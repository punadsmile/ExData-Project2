#due to network problem, I mannually downloaded the files...and unziped it...and set the wd...
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#I need to load new libraries
library(ggplot2)
library(plyr)

#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999¨C2008 for Baltimore City? Which have seen increases in emissions from 1999¨C2008? Use the ggplot2 plotting system to make a plot answer this question.

#select Baltimore City and the year
BC <- subset(NEI, fips == '24510')
Data <- ddply(BC, .(type, year), summarize, emissions=sum(Emissions))

#make the plot
png(filename = 'plot3.png')
ggplot(data = Data, aes(x = year, y = log(emissions), group = type)) +
  geom_line(aes(colour=type)) + geom_point(aes(colour=type)) + 
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha = 0.10)
dev.off()
