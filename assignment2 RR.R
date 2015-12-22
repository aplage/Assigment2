# Loading required packages

require(dplyr)
require(downloader)
require(R.utils)
#NOAA storm database


# Getting files from the Coursera Reproducible Research page

url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"


# Setting the work directory

setwd("F:/vindo Apple/Reproducible Research/Assigments/Assigment2")

download(url, "storm.csv.bz2")
bunzip2("storm.csv.bz2", remove = F, overwrite = T)


read.table("storm.csv",
           header = TRUE,
           sep = ",",
           dec = ".",
           stringsAsFactors = FALSE
           ) -> storm

# Correcting the name of the first variable
names(storm)[1] <- "STATEx"

tbl_df(storm)


