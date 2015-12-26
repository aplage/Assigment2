# Loading required packages

require(downloader)
require(R.utils)
require(dplyr)


#NOAA storm database


# Getting files from the Coursera Reproducible Research page

url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"




# Setting the work directory

setwd("F:/vindo Apple/Reproducible Research/Assigments/Assigment2")

download(url, "storm.csv.bz2")
bunzip2("storm.csv.bz2", remove = FALSE, overwrite = TRUE)

#read.table(url1, header = TRUE, sep = "|", dec = ".", stringsAsFactors = FALSE) -> storm




read.table("storm.csv",
           header = TRUE,
           sep = ",",
           dec = ".",
           stringsAsFactors = FALSE
           ) -> storm

tbl_df(storm)

# Correcting the name of the first variable
#rename(storm, stateCode = STATE__)



url2 <- "http://www.census.gov/geo/reference/ansi_statetables.html"
readLines(url2) -> stb

#stb <- gsub("U.S. ", "US ", stb)
#stb[c(4347,4355)] <- gsub("U.S. ", "", stb[c(4347,4355)])


State <- regexec("<td scope=\"row\">([A-Z][a-z].+)</td>|<td scope=\"row\">(U.S. [A-Z][a-z].+)</td>", stb)
#State <- regexec("<td scope=\"row\">([A-Z][a-z].+)</td>", stb)
State <- regmatches(stb,State)
State <- sapply(State, function(xx){ifelse(xx[2] != "", xx[2], xx[3])})
#State <- sapply(State, function(x) x[2])
State <- State[!is.na(State)]

stbindex <- grep("<td scope=\"row\">([A-Z][a-z].+)</td>|<td scope=\"row\">(U.S. [A-Z][a-z].+)</td>", stb)+1
stateCode <- regexec("<td align=\"center\">([0-9]{2})</td>", stb[stbindex])
stateCode <- regmatches(stb[stbindex],stateCode)
stateCode <- sapply(stateCode, function(x) x[2])


stbindex2 <- grep("<td scope=\"row\">([A-Z][a-z].+)</td>|<td scope=\"row\">(U.S. [A-Z][a-z].+)</td>", stb)+2
STATE <- regexec("<td align=\"center\">([A-Z]{2})</td>", stb[stbindex2])
STATE <- regmatches(stb[stbindex2],STATE)
STATE <- sapply(STATE, function(x) x[2])

     
statetable <- data.frame(State, STATE, stateCode, stringsAsFactors = FALSE)

storm <- left_join(storm, statetable, by = STATE)

storm <- storm[!is.na(storm$State),]

rm("statetable", "STATE", "stbindex2", "stateCode", "stbindex", "State")

