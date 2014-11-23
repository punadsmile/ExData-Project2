#due to network problem, I mannually downloaded the files...and unziped it...and set the wd...
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

#Select data I need
BCor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LAor <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
BCdata <- aggregate(BCor[, 'Emissions'], by=list(BCor$year), sum)
colnames(BCdata) <- c('year', 'Emissions')
BCdata$City <- paste(rep('Baltimore City', 4))

LAdata <- aggregate(LAor[, 'Emissions'], by=list(LAor$year), sum)
colnames(LAdata) <- c('year', 'Emissions')
LAdata$City <- paste(rep('Los Angeles County', 4))

Data <- as.data.frame(rbind(BCdata, LAdata))

#make the plot
png('plot6.png')

ggplot(data = Data, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

dev.off()