## Source dataset upload
## Only execute only if no NEI and SCC objects present in the environment - to save time
NEI <- readRDS("SourceData/summarySCC_PM25.rds")
SCC <- readRDS("SourceData/Source_Classification_Code.rds")

## Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?
SCC.Coal.Combustion<-SCC[grepl("Coal",SCC$Short.Name) & 
                           grepl("Comb",SCC$Short.Name),]

aggr<-ddply(NEI[which(NEI$SCC %in% SCC.Coal.Combustion$SCC),],
            .(year), summarize, totalEmissions = sum(Emissions, na.rm=T))


png("plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
library(ggplot2)
p <- qplot(x=year, y=totalEmissions, data=aggr, geom="line")
p <- p + xlab("Year")
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
p <- p + ggtitle(expression(atop("Total "~PM[2.5]~" Emissions (tonnes) by year",
                                 italic("coal combustion-related sources"))))
p <- p + scale_x_continuous(breaks=aggr$year)
p
dev.off()

## The answer is - emissions from coal combustion-related sources have decreased 