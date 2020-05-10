# Use the parameter strip.white=TRUE for trim the strings
# the file was created union other files that were collected.
# This previous work is in the sales_data_procesing.R
salesDataFrame <- read.csv("source/total_sales.csv", 
                           sep= "|", 
                           header = TRUE, 
                           strip.white=TRUE, 
                           encoding = "UTF-8",
                           quote=""
)

# only game from 7th (start 2005) and 8th (start 2012) generation. 
# Sales data from the vgchartz after 2018 are not complete
# becasue they dont include online/stream platform sales, 
str(salesDataFrame)
salesDataFrame <- salesDataFrame[salesDataFrame$Year >= 2005
                                 & salesDataFrame$Year <= 2018, ]

#
# load PEGI descriptor dataset
#
pegiDataFrame <- read.csv("source/pegi_all_to2019.csv", 
                           sep= "|", 
                           header = TRUE, 
                           strip.white=TRUE, 
                           encoding = "UTF-8",
                           quote=""
)


#
# Prepare and clean the datasets
#

# create a new field TITLE for use in the join of dataset
# columns with uppercase mean are auxiliar columns and
# dont add more info to analysis
salesDataFrame$TITTLE <- toupper(salesDataFrame$Pos)
pegiDataFrame$TITTLE <- toupper(pegiDataFrame$Title)


salesDataFrame$TITTLE_URL <- gsub('https://www.vgchartz.com/game',
                                  '',salesDataFrame$Game, 
                                  fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE_URL <- gsub('^/[0-9]+/',
                                  '',salesDataFrame$TITTLE_URL, 
                                  fixed = FALSE, useBytes = FALSE)
salesDataFrame$TITTLE_URL <- gsub('-',' ',salesDataFrame$TITTLE_URL, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE_URL <- gsub('/','',salesDataFrame$TITTLE_URL, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE_URL <- toupper(salesDataFrame$TITTLE_URL)

#reassign string that looks like a mistake in the datasource
pegiDataFrame$TITTLE <- gsub('WWE2K','WWE 2K',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('NBA2K','NBA 2K',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('FIFA SOCCER','FIFA',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
#remove characters that create matching problems
#pegiDataFrame$TITTLE <- gsub(' COLLECTION','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(' REMASTERED','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(' EDITION','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(' ULTIMATE','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(' REMIX','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('IV','4',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('VI','6',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('VII','7',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('VIII','8',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('XII','12',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('III','3',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('II','2',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('+','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(';','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(',','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('™','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('®','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub("'",'',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub("’",'',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('.','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
#pegiDataFrame$TITTLE <- gsub(':.*$','',pegiDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(':','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('PS4','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('-','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('_','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('\\(.*\\)','',pegiDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('(','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub(')','',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('^\\s+|\\s+$','',pegiDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
pegiDataFrame$TITTLE <- gsub('  ',' ',pegiDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)

#reassign string that looks like a mistake in the datasource
salesDataFrame$TITTLE <- gsub('WWE2K','WWE 2K',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('NBA2K','NBA 2K',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('FIFA SOCCER','FIFA',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
#remove characters that create matching problems
#salesDataFrame$TITTLE <- gsub(' COLLECTION','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(' REMASTERED','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(' EDITION','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(' ULTIMATE','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(' REMIX','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('IV','4',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('VI','6',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('VII','7',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('VIII','8',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('XII','12',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('III','3',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('II','2',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('+','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(';','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(',','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('™','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('®','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub("'",'',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub("’",'',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('.','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
#salesDataFrame$TITTLE <- gsub(':.*$','',salesDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(':','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('PS4','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('-','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('_','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('\\(.*\\)','',salesDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('(','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub(')','',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('^\\s+|\\s+$','',salesDataFrame$TITTLE, fixed = FALSE, useBytes = FALSE)
salesDataFrame$TITTLE <- gsub('  ',' ',salesDataFrame$TITTLE, fixed = TRUE, useBytes = FALSE)


# some levels dont match but there are the same,
# in somes case in pEGi dataset, there are a online market inside the console
# and have different sale platform
# Example: "Playstation 3 HOME","Nintendo DSi - DSiWare" are "Nintendo DS"
# then have to reset the value for matching
levels(salesDataFrame$Console.system)
levels(pegiDataFrame$Console)
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Playstation 3"] <- "PlayStation 3"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Playstation 3 HOME"] <- "PlayStation 3"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Game Boy Advance"] <- "Nintendo DS"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Nintendo 3DS"] <- "Nintendo DS"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="New Nintendo 3DS"] <- "Nintendo DS"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Nintendo DSi - DSiWare"] <- "Nintendo DS"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Nintendo Wii - Virtual Console"] <- "Nintendo Wii"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Nintendo Wii \\u2013 WiiWare"] <- "Nintendo Wii U"

levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="XBox 360"] <- "Xbox 360"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="XBox One"] <- "Xbox One"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="XBox"] <- "Xbox"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="XBOX 360 Live Arcade"] <- "Xbox 360"
#case without console, but match with videogame like LEGO Harry Potter Collection
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)==""] <- "Others"
levels(pegiDataFrame$Console)[levels(is.na(pegiDataFrame$Console))] <- "Others"
#group console whit few videogames in "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Arcade"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="GameCube"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="DVD Game"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Digiblast"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Macintosh"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Nokia mobile phone"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="PlayStation Network"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Vista"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Plug and Play"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Tapwave Zodiac"] <- "Others"
levels(pegiDataFrame$Console)[levels(pegiDataFrame$Console)=="Gizmondo"] <- "Others"
summary(pegiDataFrame$Console)

levels(salesDataFrame$Console.system)[levels(salesDataFrame$Console.system)=="XBox 360"] <- "Xbox 360"
levels(salesDataFrame$Console.system)[levels(salesDataFrame$Console.system)=="XBox One"] <- "Xbox One"
levels(salesDataFrame$Console.system)[levels(salesDataFrame$Console.system)=="XBox"] <- "Xbox"

#
# Remove and rename columns
#
# remove fields that are not important and produce duplicate

# pegi datset: Remove and rename columns
str(pegiDataFrame)
colnames(pegiDataFrame)[5] <- "Release"
pegiDataFrame$Platform <- NULL
pegiDataFrame$Publisher <- NULL
pegiDataFrame$Descriptor <- NULL
#pegiDataFrame$Release.Date <- NULL
pegiDataFrame$Consumer.Advice <- NULL
#there are clone records, need to eliminate
pegiDataFrame <- unique(pegiDataFrame)

# vgchartz datset: Remove and rename columns
str(salesDataFrame)
colnames(salesDataFrame)
colnames(salesDataFrame)[1] <- "Title"
colnames(salesDataFrame)[6] <- "North_America"
colnames(salesDataFrame)[9] <- "Rest_of_World"
colnames(salesDataFrame)[10] <- "Global_sales"
colnames(salesDataFrame)[11] <- "Console"
salesDataFrame$Game <- NULL





#
# Analysis of datasets
#
console_analysis_list <- c("Nintendo Switch","Nintendo DS","Nintendo Wii","Nintendo Wii U",
                           "PlayStation 3","PlayStation 4",
                           "Xbox 360","Xbox One")

#1) perform an ANALYSIS of only pegi data set
#modify the release field for contain only the year
pegiDataFrame$Release <- as.character(pegiDataFrame$Release)

#substr("2019-01-11 00:00:00",0,4)
pegiDataFrame$Release <- substr(pegiDataFrame$Release, 0, 4)
pegiDataFrame$Release <- as.factor(pegiDataFrame$Release)

# show the distribution of the values
summary(pegiDataFrame$Release)

#Note: looks like the value 1971 is wrong, 
# maybe is the default value for unknow
pegiDataFrame$Release <- as.numeric(as.character(pegiDataFrame$Release))

#create the subset for analyse
#year 2005-2018
#console in "Nintendo Switch","Nintendo DS","Nintendo Wii","Nintendo Wii U","PlayStation 3","PlayStation 4","Xbox 360","Xbox One"
analysis_pegi <- pegiDataFrame[pegiDataFrame$Release >= 2005
                               & pegiDataFrame$Release <= 2018
                               & pegiDataFrame$Console %in% console_analysis_list, ]

str(analysis_pegi)
analysis_pegi$TITTLE <- NULL
#how many videogames have each console
summary(analysis_pegi$Console)
#looks nintendo DS has the most amount of releases

analysis_pegi$Violence[analysis_pegi$Violence == "N"] <- NA
analysis_pegi$Drugs[analysis_pegi$Drugs == "N"] <- NA
analysis_pegi$BadLanguage[analysis_pegi$BadLanguage == "N"] <- NA
analysis_pegi$Sex[analysis_pegi$Sex == "N"] <- NA
analysis_pegi$Fear[analysis_pegi$Fear == "N"] <- NA
analysis_pegi$Gambling[analysis_pegi$Gambling == "N"] <- NA
analysis_pegi$Discrimination[analysis_pegi$Discrimination == "N"] <- NA
library(mice)
descriptorList <- c("Violence","Drugs","BadLanguage","Sex","Fear","Gambling","Discrimination")
#plot violent games
?md.pattern
md.pattern(analysis_pegi[descriptorList], plot = TRUE, rotate.names = TRUE)
#resume of violent/not violent videogames
print( paste("NO Violent games",nrow( analysis_pegi[!is.na(analysis_pegi$Violence),] )))
print( paste("Violent games",nrow( analysis_pegi[is.na(analysis_pegi$Violence),] )))
print( paste("Total games",nrow( analysis_pegi )))
print( paste( 100 * nrow( analysis_pegi[is.na(analysis_pegi$Violence),] ) / nrow( analysis_pegi ), "% of the total are labeled with violence"))

# becasue Only three videogames are labeled with the “Discrimination” descriptor,
# therefore, we will disregard it and we will proceed to eliminate this column from the dataset.
pegiDataFrame$Discrimination <- NULL

# plot relase by year
# note are using a subset of pegi 2005-2018 Specific platform
plot_pegi <- ggplot(analysis_pegi, aes(Release)) +
  geom_bar(fill = "#0073C2FF") +
  scale_color_viridis()

plot_pegi <- plot_pegi +
  ggtitle("Videogames release by Year") +
  xlab("Year of release") + ylab("Number videogames releases")
print(plot_pegi)




#2) perform an ANALYSIS of only sales data set
str(salesDataFrame)
#plot the unit sales by year
boxplot(Global_sales ~ Year, data=salesDataFrame, las=1,
        xlab='Year', ylab='Unit Sales')

?barplot
#barplot(height = salesDataFrame$Genre, width = salesDataFrame$Global_sales,
#        xlab='Year', ylab='Unit Sales')
# can be said there are many videogames outliers 
# far away form the interquartile range
# these videogames are top sellers

#plot the genres
sales_type_frecuency <- ggplot(salesDataFrame, aes(x = Genre, y = Global_sales)) +
  geom_bar(fill = "#0073C2FF",stat = "identity") +
  scale_color_viridis()
print(sales_type_frecuency)
#looks like there are many types of genre with just a few amoun of release
#Better if group together in a new Genre named Others
levels(salesDataFrame$Genre)
salesDataFrame$Genre <- as.character(salesDataFrame$Genre)
#reasign genres with a few amount with the new value "Others"
salesDataFrame$Genre[salesDataFrame$Genre == "Board Game"] <- "Others"
salesDataFrame$Genre[salesDataFrame$Genre == "MMO"] <- "Others"
salesDataFrame$Genre[salesDataFrame$Genre == "Sandbox"] <- "Others"
salesDataFrame$Genre[salesDataFrame$Genre == "Visual Novel"] <- "Others"
#reasing the genre Music into the existing value Party
salesDataFrame$Genre[salesDataFrame$Genre == "Music"] <- "Party"
salesDataFrame$Genre <- as.factor(salesDataFrame$Genre)
levels(salesDataFrame$Genre)
#plot again the genres after the reasignation
sales_type_frecuency <- ggplot(salesDataFrame, aes(x = Genre, y = Global_sales)) +
  geom_bar(fill = "#0073C2FF",stat = "identity") +
  scale_color_viridis()
print(sales_type_frecuency)


#
# Merge the datasets
# 

str(salesDataFrame)
str(pegiDataFrame)
#merge both dataframe
#the most valuable is the sales dataframe, so use left join
library(dplyr)
mergedDataFrame <- left_join(salesDataFrame, 
                   pegiDataFrame, 
                   copy = TRUE,
                   by = c("TITTLE" = "TITTLE","Console" = "Console"))


#show how many match record are and arent
nrow(mergedDataFrame[is.na(mergedDataFrame$Rating),])
nrow(mergedDataFrame[!is.na(mergedDataFrame$Rating),])

#test the not matched
notmatched <- mergedDataFrame[is.na(mergedDataFrame$Rating) & 
                              mergedDataFrame$Console.system == "PlayStation 3",]




#try to remerged with PC the records from sales that werent matched any
#pegi from pc
pegiOthers <- bind_rows(pegiDataFrame[pegiDataFrame$Console == "PC",],
                        pegiDataFrame[pegiDataFrame$Console == "Others",])
pegiOthers[pegiOthers$Console] <- NULL
pegiOthers <- unique(pegiOthers)
# 10134 record werent match
nrow(mergedDataFrame[is.na(mergedDataFrame$Rating),])
mergedOther <- mergedDataFrame[is.na(mergedDataFrame$Rating),]
mergedOther$Title <- NULL
mergedOther$Rating <- NULL
mergedOther$Platform <- NULL
mergedOther$Release.Date <- NULL
mergedOther$Publisher.y <- NULL
mergedOther$Descriptor <- NULL
mergedOther$Consumer.Advice <- NULL
mergedOther$Violence <- NULL
mergedOther$Drugs <- NULL
mergedOther$BadLanguage <- NULL
mergedOther$Sex <- NULL
mergedOther$Fear <- NULL
mergedOther$Gambling <- NULL
mergedOther$Discrimination <- NULL
colnames(mergedOther)

mergedOther <- left_join(mergedOther, 
                         pegiOthers, 
                         by = c("TITTLE" = "TITTLE"))
nrow(mergedOther[is.na(mergedOther$Rating),])
nrow(mergedOther[!is.na(mergedOther$Rating),])
mergedOther$Console.system <- as.factor(mergedOther$Console.system)
summary(mergedOther$Console.system)

?bind_rows
mergedDataFrame <- bind_rows(mergedDataFrame[!is.na(mergedDataFrame$Rating),] ,
                             mergedOther)
#                             mergedOther[!is.na(mergedOther$Rating),] )
nrow(mergedDataFrame[is.na(mergedDataFrame$Rating),])
nrow(mergedDataFrame[!is.na(mergedDataFrame$Rating),])

#match using the url field with pegi title
nrow(mergedDataFrame[is.na(mergedDataFrame$Rating),])
mergedOther <- mergedDataFrame[is.na(mergedDataFrame$Rating),]
mergedOther$Title <- NULL
mergedOther$Rating <- NULL
mergedOther$Platform <- NULL
mergedOther$Release.Date <- NULL
mergedOther$Publisher.y <- NULL
mergedOther$Descriptor <- NULL
mergedOther$Consumer.Advice <- NULL
mergedOther$Violence <- NULL
mergedOther$Drugs <- NULL
mergedOther$BadLanguage <- NULL
mergedOther$Sex <- NULL
mergedOther$Fear <- NULL
mergedOther$Gambling <- NULL
mergedOther$Discrimination <- NULL
colnames(mergedOther)
mergedOther <- left_join(mergedOther, 
                         pegiDataFrame, 
                         by = c("TITTLE_URL" = "TITTLE","Console" = "Console"))
#result of match
nrow(mergedOther[is.na(mergedOther$Rating),])
nrow(mergedOther[!is.na(mergedOther$Rating),])

mergedDataFrame$Console.system <- as.data.frame(mergedDataFrame$Console.system)
summary(mergedDataFrame[is.na(mergedDataFrame$Rating),])

#test specific examples
# Star Wars Battlefront (2015)
# ASSASSIN'S CREED / Assassin’s Creed® Unity
#notmatched <- mergedDataFrame[is.na(mergedDataFrame$Rating) 
#                              & mergedDataFrame$Console.system == "PlayStation 4",]

#sps4 <- salesDataFrame[salesDataFrame$Console.system == "PlayStation 4",]
#sps4 <- pegiDataFrame[pegiDataFrame$Console == "PlayStation 4",]
#salesDataFrame[ps4$TITTLE == "STAR WARS BATTLEFRONT",]
#salesDataFrame[salesDataFrame$Pos == "ASSASSIN'S CREED UNITY",]
#library(data.table)
#pegiDataFrame[pegiDataFrame$Title %like% "Collection",]
#salesDataFrame[salesDataFrame$Pos %like% "Collection",]
#gsub('\\(.*\\)','','Star Wars Battlefront (2015)', fixed = FALSE, useBytes = FALSE)

#salesDataFrame[salesDataFrame$Pos == "LEGO Batman 2: DC Super Heroes",]
#pegiDataFrame[pegiDataFrame$title == "LEGO Batman 2: DC Super Heroes",]


#get only the usefull  variables
str(mergedDataFrame)
mergedDataFrame$Pos <- NULL
mergedDataFrame$Game <- NULL
mergedDataFrame$Console.system <- NULL
mergedDataFrame$Title <- NULL
mergedDataFrame$TITTLE <- NULL
mergedDataFrame$TITTLE_URL <- NULL
mergedDataFrame$Console <- NULL

library(mice)
# 5789 records with pegi descriptor
# 6737 records with missing pegi 
md.pattern(mergedDataFrame)


# there are many record with violent equal NA
# but can be analyced what percentage of the total are
str(mergedDataFrame)
sum(mergedDataFrame$Global_sales)
sum(mergedDataFrame$Global_sales[!is.na(mergedDataFrame$Violence) & mergedDataFrame$Violence == "Y",])
levels(mergedDataFrame$Violence)
summary(mergedDataFrame$Violence)

violent <- mergedDataFrame[!is.na(mergedDataFrame$Violence) & mergedDataFrame$Violence == "N",]
notviolentsales <- sum(violent$Global_sales)
print(paste("total sales of violent = N ", sum(violent$Global_sales)))
print(paste( 100 * sum(violent$Global_sales) / sum(mergedDataFrame$Global_sales), " % sales of violent = N "))

violent <- mergedDataFrame[!is.na(mergedDataFrame$Violence) & mergedDataFrame$Violence == "Y",]
violentsales <- sum(violent$Global_sales)
print(paste("total sales of violent = Y ", sum(violent$Global_sales)))
print(paste( 100 * sum(violent$Global_sales) / sum(mergedDataFrame$Global_sales), " % sales of violent = Y "))

violent <- mergedDataFrame[is.na(mergedDataFrame$Violence),]
naviolentsales <- sum(violent$Global_sales)
print(paste("total sales of violent NA ", sum(violent$Global_sales)))
print(paste( 100 * sum(violent$Global_sales) / sum(mergedDataFrame$Global_sales), " % sales of violent NA "))

percentage_violent_in_sales <- data.frame(
  group = c("VIOLENT", "NOT VIOLENT", "NA"),
  sales = c(violentsales,notviolentsales,naviolentsales)
)
head(percentage_violent_in_sales)
# plot percentages of sales against violent
library(ggplot2)
# Barplot
bp<- ggplot(percentage_violent_in_sales, aes(x="PEGI label", y=sales, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp
pie <- bp + coord_polar("y", start=0)
pie + scale_fill_manual(values=c("#999999", "#C3FF68", "#F02311"))



?aggregate
str(mergedDataFrame)

str(test)
list <- c("Release","Global_sales","Europe","Japan","Rest_of_World","Rating", "Violence")
test <- mergedDataFrame[list]
test <- test[complete.cases(test),]
?aggregate
agg = aggregate(.~test$Rating + test$Violence + test$Release, test, mean)
colnames(agg)[1] <- "Group1"
colnames(agg)[2] <- "Group2"
colnames(agg)[3] <- "testyear"
#agg$Violence <- NULL
agg$Group2 <- as.character(agg$Group2)
agg$Group1 <- as.character(agg$Group1)
str(agg)
#agg$Group1 <- paste(agg$Group1, " ",agg$Group2)
agg$Group1 <- NULL
agg$Group2 <- NULL
agg$testyear <- NULL
colnames(agg)
#correlation
#install.packages("corrplot")
library(corrplot)
?corrplot
corrplot(corr = cor(agg), tl.col = "Black", tl.cex = 0.9)


library(ggplot2)
library(viridis)
#get ready the data for the plot function
?geom_point
sales_type_frecuency <- ggplot(mergedDataFrame, aes(x = Genre, y = Global_sales)) +
  geom_bar(fill = "#0073C2FF",stat = "identity") +
  scale_color_viridis()
print(sales_type_frecuency)

sales_type_frecuency <- ggplot(mergedDataFrame, aes(x = Violence, y = Global_sales)) +
  geom_bar(fill = "#0000C2FF",stat = "identity") +
  scale_color_viridis()
print(sales_type_frecuency)

levels(salesDataFrame$Genre)

years$Year <- as.factor(years$Year)
years$GlobalGame <- as.numeric(years$GlobalGame)
years$Publisher <- factor(years$Publisher)
str(years)
summary(years$Year)
summary(years$Genre)
summary(years$Publisher)



#
# Hypothesis testing
#
# the average sales of a violent video game is higher 
# than the average sales of all video games?
# H0 p: mean of sales of a videogame
# H1 mean of sale of violent videogames > mean of all videogame

str(beaver2)
beaver2
transformed_beaver_data <- transform(beaver2,
                                     activ = factor(activ, labels = c("no", "yes")))
str(transformed_beaver_data)
library("lattice")
histogram(~temp | activ, data = transformed_beaver_data)

t.test(temp ~ activ, data = transformed_beaver_data)

test_sales_hipotesis <- mergedDataFrame
# check the structure field.
# The variable "Violence" is a factor: 
#    "Y" is PEGI labeled the videogame as Violent, 
#    "N" is PEGI unlabeled the videogame as NOT Violent
str(test_sales_hipotesis)


histogram(~Global_sales | Violence, data = test_sales_hipotesis)
# result: Difficult to appreciate the difference between the two histograms, 
# since most video games are grouped in the range of having low sales


boxplot(Global_sales ~ Violence, data=test_sales_hipotesis, las=1,
        xlab='Violence', ylab='Sales')

#Proceed to test
t.test(Global_sales ~ Violence, data = test_sales_hipotesis)
t.test(Global_sales ~ Violence, data = test_sales_hipotesis,
       alternative = c("two.sided", "less", "greater"),
       var.equal=TRUE, conf.level = 0.95)

# the return of the test was:

# data:  Global_sales by Violence
# t = -2.4723, df = 5514.7, p-value = 0.01345
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.23003229 -0.02656615
# sample estimates:
# mean in group N mean in group Y 
# 0.5235424       0.6518416 

# Conclusion:
# becasue p-value = 0.01345 is lower than the establecided 0.05
# can be said with the 95% of confidence  than the difference 
# of the means of the sales of violent videogames and the not violent are not cero
