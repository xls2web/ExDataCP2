#### This code is available at https://github.com/xls2web/ExDataCP2

## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 1
## Have total emissions decreased in the US from 1999 to 2008?
library(plyr)

png("plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
aggr<-ddply(NEI,.(year), summarize, totalEmissions = sum(Emissions, na.rm=T))
par(cex.main=1.2, mar=c(5, 5, 5, 2))
plot(aggr, 
     type = "b",
     main = expression("Total "~PM[2.5]~" Emissions (tonnes) by year"),
     col = "green",
     xlab = "Year",
     ylab = expression("Total "~PM[2.5]~" Emissions (tonnes)"),
     xaxt = "n"
     )
axis(1, at=aggr$year, labels=aggr$year)

dev.off()

## Answer: yes, total emissions have decreased


