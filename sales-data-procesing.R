#load the files from pegi info
salesFileNames <- list.files(path ="source", 
                            pattern="data.*.csv", 
                            all.files=FALSE,
                            full.names=TRUE, 
                            recursive = TRUE)

salesFileNames
#numbers of file to load
length(salesFileNames)
salesDataFrame = data.frame()
for ( file_name in salesFileNames){
  print(file_name)
  #aux_dataframe <- read.csv(file_name)
  salesDataFrame <- rbind(salesDataFrame, 
                          read.csv(file_name, 
                                  sep= "|", 
                                  header = TRUE, 
                                  strip.white=TRUE, 
                                  encoding = "UTF-8",
                                  quote=""))
  print(nrow(salesDataFrame))
}

#number of videgames in the sales data set
str(salesDataFrame)
levels(salesDataFrame$Year)
# remove game dont have title
# some record were extracted because the html script detect a row,
# but dont content data because are the head or tail of html table
salesDataFrame <- salesDataFrame[!is.na(salesDataFrame$Game), ]

# also there are record with imposible year of release because are error record
# some videogames have NA because never were release
salesDataFrame$Year <- as.numeric(as.character(salesDataFrame$Year))
salesDataFrame <- salesDataFrame[!is.na(salesDataFrame$Year), ]

#show data for test purpose
salesDataFrame[salesDataFrame$Year <= 1985, ]
salesDataFrame[salesDataFrame$Year >= 2021, ]
#remove record with missing title. They are from error collection processing
salesDataFrame[salesDataFrame$Game == "", ]
salesDataFrame <- salesDataFrame[salesDataFrame$Pos != "", ]

levels(salesDataFrame$Genre)
write.table(salesDataFrame, file = "source/total_sales.csv", sep = "|", append = FALSE, quote = FALSE )
