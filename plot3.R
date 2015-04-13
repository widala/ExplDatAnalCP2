##Read in data set and Source Classification Code
	NEI <- readRDS("./summarySCC_PM25.rds")
	SCC <- readRDS("./Source_Classification_Code.rds")

##Open necessary packages
	library(ggplot2)
	library(dplyr)
	
##Question 3 - Which of the source types have seen increased or decreases in emissions from 1999-2008
	##Summarize total emissions by type and year
		NEItype <- NEI %>%
			group_by(type,year) %>%
			summarise(total=sum(Emissions,na.rm=T)) %>%
			arrange(type,year)
	##Plot total emissions in U.S. by source and year
		png(file="plot3.png",width=480,height=480,units="px")
		ggplot(NEItype,aes(x=year,y=total),.~type)+geom_point(aes(color=type))+labs(title="Total PM(2.5) Emissions in the U.S. by Source and Year")+labs(x="Year",y="Total PM(2.5) Emissions")+geom_smooth(aes(group=type),se=F,method="lm")
		dev.off()