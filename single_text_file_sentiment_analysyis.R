setwd("~/Desktop/ML GIT/text mining/")

readLines("1.txt")

paste(readLines("1.txt") , collapse = " ")

text_file <- paste(readLines("1.txt") , collapse = " ")

text_clean <- gsub(pattern = "\\W" , replace = " " , text_file)

text_clean <- gsub(pattern = "\\d" , replace = " " , text_clean)

text_clean <- tolower(text_clean)

library(tm)

text_clean <- removeWords(text_clean , stopwords())

text_clean <- gsub(pattern = "\\b[A-z]\\b{1}" , replace = " " , text_clean)

text_clean <- stripWhitespace(text_clean)




library(stringr)
library(wordcloud)

text_splitted <- str_split(text_clean , pattern = "\\s+")

text_splitted <- unlist(text_splitted)



positivewords <- readLines("positive-words.txt")
negativewords <- readLines("negative-words.txt")



positive_score <- sum(!is.na(match(text_splitted , positivewords)))

negative_score <- sum(!is.na(match(text_splitted , negativewords)))





