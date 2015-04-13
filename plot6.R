##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)
	
##Question 6 - Compare emissions from motor vehicle sources in Baltimore to those in Los Angeles County
	MVs <- grep("Highway Vehicles",SCC$SCC.Level.Two)
	SCCMVs <- SCC[MVs,]
	##Separate out SCCs
		SCCMVs <- SCCMVs$SCC
	##Subset NEI data set to include only those SCCs of interest
		NEIMVs <- subset(NEI,SCC %in% SCCMVs)
	##Subset NEIMVs data set to include only Baltimore City and LA County
		BLNEIMVs <- subset(NEIMVs,fips=="24510" | fips=="06037")
	##Summarize motor vehicle emissions by year and fips
		NEIMV <- BLNEIMVs %>%
			group_by(fips,year) %>%
			summarise(total=sum(Emissions,na.rm=T)) %>%
			arrange(fips,year)
	##Labels
		NEIMV$Location[NEIMV$fips=="24510"] <- "Baltimore"
		NEIMV$Location[NEIMV$fips=="06037"] <- "Los Angeles"
	##Plot total motor vehicle emissions in Baltimore City, Maryland and Los Angeles county, California by year
		png(file="plot6.png",width=480,height=480,units="px")
		ggplot(NEIMV,aes(x=year,y=total),.~Location)+geom_point(aes(color=Location))+labs(title="Total PM(2.5) Motor Vehicle Emissions \nin Baltimore and Los Angeles by Year")+labs(x="Year",y="Total PM(2.5) Emissions")+geom_smooth(aes(group=Location),se=F,method="lm")
		dev.off()