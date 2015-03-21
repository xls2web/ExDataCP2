## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 6
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California?
## Which city has seen greater changes over time in motor vehicle emissions?
aggr<-ddply(NEI[which(NEI$fips %in% c("24510","06037") & NEI$type=="ON-ROAD"),],
            .(year, fips), summarize, totalEmissions = sum(Emissions, na.rm=T))
county<-data.frame(fips=c("24510","06037"), county=c("Baltimore City","Los Angeles County")) 
aggr<-merge(aggr,county, by="fips")

png("plot6.png", width = 960, height = 480, units = "px", pointsize = 12, bg = "white")
library(ggplot2)
p <- qplot(x=year, y=totalEmissions, data=aggr, facets=.~county, geom="line")
p <- p + xlab("Year")
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
p <- p + ggtitle(expression(atop("Total "~PM[2.5]~" Emissions (tonnes) by year",
                                 italic("Motor vehicle sources"))))
p <- p + scale_x_continuous(breaks=aggr$year)
p 
dev.off()

## The answer is:
## While stable decrease has been seen in Baltimore, increase was noted in LA
## Though the latest trend for LA is about decreasing as well


