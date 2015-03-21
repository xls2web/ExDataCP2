#### This code is available at https://github.com/xls2web/ExDataCP2

## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 2
## Have total emissions decreased in the US from 1999 to 2008 in the Baltimore City, Maryland (fips == 24510)?
library(plyr)

png("plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
aggr<-ddply(NEI[which(NEI$fips == 24510),],.(year), summarize, totalEmissions = sum(Emissions, na.rm=T))
par(cex.main=1.2)
plot(aggr, 
     type = "b",
     main = expression("Total "~PM[2.5]~" Emissions (tonnes) by year"),
     col = "green",
     xlab = "Year",
     ylab = expression("Total "~PM[2.5]~" Emissions (tonnes)"),
     xaxt = "n"
)
mtext("Baltimore City, Maryland", line=0.5)
axis(1, at=aggr$year, labels=aggr$year)
dev.off()

## Answer: yes, total emissions have decreased in the Baltimore City, Maryland

