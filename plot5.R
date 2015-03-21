## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 4
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
aggr<-ddply(NEI[which(NEI$fips=="24510" & NEI$type=="ON-ROAD"),],
            .(year), summarize, totalEmissions = sum(Emissions, na.rm=T))


png("plot5.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
library(ggplot2)
p <- qplot(x=year, y=totalEmissions, data=aggr, geom="line")
p <- p + xlab("Year")
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
p <- p + ggtitle(expression(atop("Total "~PM[2.5]~" Emissions (tonnes) by year",
                                 italic("Motor vehicle sources, Baltimore"))))
p <- p + scale_x_continuous(breaks=aggr$year)
p
dev.off()

## The answer is - emissions from motor vehicle sources in Baltimore have decreased 
