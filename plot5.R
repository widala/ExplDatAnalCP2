##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)
	
##Question 5 - How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City
	##Subset SCC data to include only those SCCs dealing with motor vehicle emissions
		MVs <- grep("Highway Vehicles",SCC$SCC.Level.Two)
		SCCMVs <- SCC[MVs,]
	##Separate out SCCs
		SCCMVs <- SCCMVs$SCC
	##Subset NEI data set to include only those SCCs of interest
		NEIMVs <- subset(NEI,SCC %in% SCCMVs)
	##Subset NEIMVs data set to include only Baltimore City
		BNEIMVs <- subset(NEIMVs,fips=="24510")
	##Total emissions from motor vehicles in Baltimore by year
		BMVtots <- with(BNEIMVs,tapply(Emissions,year,sum,na.rm=T))
		BMVtots <- data.frame(year=names(BMVtots),total=BMVtots)
	##Plot motor vehicle emissions in Baltimore City, Maryland by year
		png(file="plot5.png",width=480,height=480,units="px")
		plot(BMVtots,ylab="Total PM(2.5) Emissions",xlab="Year",main="Total PM(2.5) Emissions from Motor Vehicles \nin Baltimore City, MD by Year")
		dev.off()