##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)
	
##Question 2 - Have total emissions from PM2.5 decreased in Baltimore City, Maryland from 1999-2008
	##Subset data to only include Baltimore City (fips == "24510")
		BCM <- subset(NEI,fips=="24510")
	##Calculate total emissions by year
		BCMtotals <- with(BCM,tapply(Emissions,year,sum,na.rm=T))
	##Create data frame with year and total emissions paired
		BCMtotalemissions <- data.frame(year=names(BCMtotals),total=BCMtotals)
	##Plot total emissions in Baltimore City by year
		png(file="plot2.png",width=480,height=480,units="px")
		plot(BCMtotalemissions,ylab="Total PM(2.5) Emissions",xlab="Year",main="Total PM(2.5) Emissions in Baltimore City, Maryland by Year")
		dev.off()