#due to network problem, I mannually downloaded the files...and unziped it...and set the wd...
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#5. How have emissions from motor vehicle sources changed from 1999¨C2008 in Baltimore City?

#select data I need
OR <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
Data <- aggregate(OR[, 'Emissions'], by=list(OR$year), sum)
colnames(Data) <- c('year', 'Emissions')

#make the plot
png(filename = 'plot5.png')
ggplot(data = Data, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
dev.off()
