##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)

##Question 1 - Have total emissions in U.S. decreased from 1999-2008
	##Calculate total emissions by year
		totals <- with(NEI,tapply(Emissions,year,sum,na.rm=T))
	##Create data frame with year and total emissions paired
		totalemissions <- data.frame(year=names(totals),total=totals)
	##Plot total emissions by year
		png(file="plot1.png",width=480,height=480,units="px")
		plot(totalemissions,ylab="Total PM(2.5) Emissions",xlab="Year",main="Total PM(2.5) Emissions in the U.S. by Year")
		dev.off()