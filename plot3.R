## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City

library(plyr)
aggr<-ddply(NEI[which(NEI$fips == 24510),],.(year, type), summarize, totalEmissions = sum(Emissions, na.rm=T))

png("plot3.png", width = 960, height = 480, units = "px", pointsize = 12, bg = "white")
library(ggplot2)
p <- qplot(x=year, y=totalEmissions, data=aggr, col=type, facets=.~type)
p <- p + ggtitle(expression(atop("Total "~PM[2.5]~" Emissions (tonnes) by year",
                                 italic("Baltimore City, Maryland"))))
p <- p + xlab("Year")
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
p <- p + scale_x_continuous(breaks=aggr$year)
p + geom_line()
dev.off()

## The answer is all except for "POINT"
