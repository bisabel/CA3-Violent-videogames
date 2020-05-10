# first, put togehter all the info collected from pegi.info in the same dataframe
# second, filter and clean the data of the dataframe
# finally, save the dataframe in a new file, for future uses.


#load the files from pegi info
pegiFileNames <- list.files(path ="source", 
                    pattern="pegi.*.csv", 
                    all.files=FALSE,
                    full.names=TRUE, 
                    recursive = TRUE)

pegiFileNames
#numbers of file to load
length(pegiFileNames)
pegiDataFrame = data.frame()
for ( file_name in pegiFileNames){
  print(file_name)
  #aux_dataframe <- read.csv(file_name)
  pegiDataFrame <- rbind(pegiDataFrame, 
                         unique(read.csv(file_name, 
                                  sep= "|", 
                                  header = TRUE, 
                                  strip.white=TRUE, 
                                  encoding = "UTF-8",
                                  quote="")))
  print(nrow(pegiDataFrame))
}

write.table(pegiDataFrame, file = "source/total_pegi.csv", sep = "|", append = FALSE, quote = FALSE )

str(pegiDataFrame)
# check empty values from the field age. That the field for the pegi age recomendation.
# If there were rows in the empty field(or different values than  "3"  "7"  "12" "16" "18"),
# it would be a badly saved record
pegiDataFrame[pegiDataFrame$age == ""]
#last time was executed the result: data frame with 0 columns and 12372 rows
#so trandform the column to a factor and proceed to check the different values
pegiDataFrame$age <- as.factor(pegiDataFrame$age)
levels(pegiDataFrame$age)
#last time the result was  "3"  "7"  "12" "16" "18"
summary(pegiDataFrame$age)

#calculate the percentage of game with each pegi age clasification
#   1(3)    2(7)    3(12)   4(16)   5(18) 
#3842    1526    1508     578     323 
#  49.40   19.62   19.39    7.43    4.15
tablepegi <- table(pegiDataFrame$age)
lapply(tablepegi[1:length(tablepegi)], function(i) 100 * i/nrow(pegiDataFrame))
length(pegiDataFrame$age)
nrow(pegiDataFrame)

#calculate the descriptor of videogames
descriptor <- pegiDataFrame[6:12]
levels(descriptor$DISCRIMINATION) <- c(FALSE, TRUE)
levels(descriptor$DRUGS) <- c(FALSE, TRUE)
levels(descriptor$FEAR) <- c(FALSE, TRUE)
levels(descriptor$GAMBLING) <- c(FALSE, TRUE)
levels(descriptor$SEX) <- c(FALSE, TRUE)
levels(descriptor$VIOLENCE) <- c(FALSE, TRUE)
levels(descriptor$INGAMEPURCHASES) <- c(FALSE, TRUE)
descriptor$DISCRIMINATION[descriptor$DISCRIMINATION == FALSE] <- NA
descriptor$DRUGS[descriptor$DRUGS == FALSE] <- NA
descriptor$FEAR[descriptor$FEAR == FALSE] <- NA
descriptor$GAMBLING[descriptor$GAMBLING == FALSE] <- NA
descriptor$SEX[descriptor$SEX == FALSE] <- NA
descriptor$VIOLENCE[descriptor$VIOLENCE == FALSE] <- NA
descriptor$INGAMEPURCHASES[descriptor$INGAMEPURCHASES == FALSE] <- NA


summary(descriptor$VIOLENCE)
str(descriptor)
library(mice)
md.pattern(descriptor, plot = TRUE, rotate.names = TRUE)
# result no games marked with discrimination
descriptor$DISCRIMINATION <- NULL
colnames(descriptor) <- c("DRU", "FEA", "GAM", "SEX", "VIO", "ING")
colnames(descriptor)
md.pattern(descriptor, plot = TRUE, rotate.names = TRUE)

# reorder the colum position
# VIO will be the first
descriptor <- descriptor[,c(5,1,2,3,4,6)]

#field in detail with relation with violent
get_percentage_voilent_by_descriptor <- function(field){
  print(paste("Amount of videogame mark with ",colnames(descriptor)[field],": ",nrow(subset(descriptor, descriptor[field] == TRUE))))
  print(paste("Amount of videogame mark with ",colnames(descriptor)[field]," and VIOLENT as well: ",nrow(subset(descriptor,descriptor[field] == TRUE & descriptor$VIO == TRUE))))
  percentage <- 100 * nrow(subset(descriptor, descriptor[field] == TRUE & descriptor$VIO == TRUE)) / nrow(subset(descriptor, descriptor[field] == TRUE))
  print(paste("The amount of videogames mark with ",colnames(descriptor)[field]," the ",percentage," % were marked with VIOLENT as well"))  
  return (percentage)
}

#get the percentage of each descriptor videogames type that are VIOLENT
lapply(c(2:6), get_percentage_voilent_by_descriptor)
get_percentage_voilent_by_descriptor(2)

levels(pegiDataFrame$age)
str(pegiDataFrame)

?md.pattern
md.pattern(pegiDataFrame)
pegiDataFrame$age <- as.numeric(pegiDataFrame$age)




#time to analyce the games were mark as violent by pegi.
levels(pegiDataFrame$VIOLENCE) <- c(FALSE, TRUE)
levels(pegiDataFrame$VIOLENCE)
summary(pegiDataFrame$VIOLENCE)

#pegiDataFrame$title <- as.character(pegiDataFrame$title)
test_paw_patrol <- pegiDataFrame[ pegiDataFrame$title == "PAW Patrol: On A Roll!",]
test_paw_patrol$platform.filter

?read.csv
pegips4 <- read.csv("source/pegi-PlayStation-4.csv", sep= "|", header = TRUE, strip.white=TRUE, encoding = "UTF-8",  quote="" )
testps4patrol <- pegips4[ pegips4$title == "PAW Patrol: On A Roll!",]
testps4patrol

library(dplyr)
pegips4 %>%
  group_by(title) %>%
  summarise(count=n())
