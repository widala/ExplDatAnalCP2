##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)
	
##Question 4 - Across U.S., how have emissions from coal combustion-related sources changed from 1999-2008
	##Subset SCC data to include only those SCCs with Coal
		Coal <- grep("Coal",SCC$Short.Name)
		SCCsub <- SCC[Coal,]
	##Subset SCCsub data to include only those SCCs with both Coal and Combustion
		Comb <- grep("Comb",SCCsub$Short.Name)
		SCCsub <- SCCsub[Comb,]
	##Separate out SCCs
		SCCs <- SCCsub$SCC
	##Subset NEI data set to include only those SCCs of interest
		NEISCC <- subset(NEI, SCC %in% SCCs)
	##Total Emissions from Coal Combustion by Year
		CoalCombtots <- with(NEISCC,tapply(Emissions,year,sum,na.rm=T))
		CoalCombtots <- data.frame(year=names(CoalCombtots),total=CoalCombtots)
	##Plot total emissions from coal combustion in U.S. by year
		png(file="plot4.png",width=480,height=480,units="px")
		plot(CoalCombtots,ylab="Total PM(2.5) Emissions",xlab="Year",main="Total PM(2.5) Emissions from Coal Combustion in U.S. by Year")
		dev.off()