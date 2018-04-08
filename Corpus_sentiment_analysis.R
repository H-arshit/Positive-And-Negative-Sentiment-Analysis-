setwd("~/Desktop/ML GIT/text mining/")

library(tm)
library(wordcloud)
library(stringr)



file_names <- list.files(path = "corpus/" , pattern = "*.txt")
filenames <- paste("corpus/" , file_names , sep = "")


text_corpus <- lapply(filenames, FUN = readLines)

text_corpus <- lapply(text_corpus, FUN = paste , collapse = " ")



corpus_clean <- gsub(pattern = "\\W" , replace = " "  , text_corpus)

corpus_clean <- gsub(pattern = "\\d" , replace = " " , corpus_clean)

corpus_clean <- tolower(corpus_clean)

corpus_clean <- removeWords(corpus_clean , stopwords("english"))

corpus_clean <- gsub(pattern = "\\b[A-z]\\b{1}" , replace = " " , corpus_clean)

corpus_clean <- stripWhitespace(corpus_clean)

# 
# combined wordcloud

wordcloud(corpus_clean , random.order = F , col = rainbow(3))


pure_corpus <- Corpus(VectorSource(corpus_clean))



# creating document matrix

doc_mat <- TermDocumentMatrix(pure_corpus)

term_dm <- as.matrix(doc_mat)

colnames(term_dm) <- c("Doc 1" , "Doc 2" , "Doc 3" , "Doc 4" , "Doc 5" , "Doc 6")

# comparison of doc word cloud
comparison.cloud(term_dm)




positive_lexicon <- readLines("positive-words.txt")
negative_lexicon <- readLines("negative-words.txt")


corpus_words <- str_split(text_corpus , pattern = "\\s+")


sentiment_score <- unlist(lapply(corpus_words , function(x) { sum(!is.na(match(x , positive_lexicon))) - sum(!is.na(match(x , negative_lexicon))) }))

mean(sentiment_score)
hist(sentiment_score)
sd(sentiment_score)
