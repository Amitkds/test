getwd()
setwd("D:\\")

subject <- read.csv("nytimes.csv",header = F)

subject <- subject[-1,]

str(subject)

subject1 <- data.frame(subject$V4)

str(subject1)

names(subject1) <- "Subject_Text"

subject1 <- data.frame(subject1)

library(tm)

# Building a corpus

subject.corpus <- Corpus(VectorSource(subject1$Subject_Text))
str(subject.corpus)
summary(subject.corpus)
inspect(subject.corpus[1:10])
class(subject.corpus)
subject.corpus[[2]]
unlist(subject.corpus)

print(lapply(subject.corpus[1:2], as.character))

# Data Transformation

subject.corpus <- tm_map(subject.corpus,tolower) # converting to lowercase
subject.corpus <- tm_map(subject.corpus,stripWhitespace) # strip extra space
subject.corpus <- tm_map(subject.corpus,removePunctuation) # remove punctuation
subject.corpus <- tm_map(subject.corpus,removeNumbers)# remove numbers



my_stopwords<-c(stopwords('english')) #Can add more words apart from standard list
subject.corpus<-tm_map(subject.corpus,removeWords,my_stopwords)


# Building a Term Document Matrix

subject.tdm <- TermDocumentMatrix(subject.corpus)

dim(subject.tdm)

inspect(subject.tdm[1:5,1:5])

?TermDocumentMatrix

#3 Remove Sparse Term with 98%

subject.imp <- removeSparseTerms(subject.tdm,.98)

dim(subject.imp)

inspect(subject.imp[1:9,1:10])


###

dtm <- DocumentTermMatrix(subject.corpus,
                          control = list(weighting = weightTfIdf))

str(dtm)

#Finding word and frequencies
temp1<-inspect(subject.imp)
wordFreq<-data.frame(apply(temp1, 1, sum))
wordFreq<-data.frame(ST = row.names(wordFreq), Freq = wordFreq[, 1])
head(wordFreq)

wordFreq<-wordFreq[order(wordFreq$Freq, decreasing = T), ]
row.names(wordFreq) <- NULL
View(wordFreq)


##Basic Analyses
#Finding the most frequent terms/words

findFreqTerms(subject.tdm,30) #Occuring minimum of 30 times


#Finding association between terms/words
findAssocs(subject.tdm,"health",0.3)

#Building a word cloud
#Visualization using WordCloud
install.packages("wordcloud")
library("wordcloud")
library("RColorBrewer")

#customizing wordcloud
#Need to use text corpus and not term document matrix
#How to choose colors?


display.brewer.all() #Gives you a chart
brewer.pal #Helps you identify the groups of pallete colors
display.brewer.pal(8,"Dark2")

display.brewer.pal(8,"Purples")
display.brewer.pal(3,"Oranges")

pal2<-brewer.pal(8,"Dark2")
#plot your word cloud
wordcloud(subject.corpus,min.freq=10,
          max.words=100,
          random.order=T,colors=pal2,vfont=c("script","plain"))

wordcloud(tweets.corpus,min.freq=50,max.words=100, 
          random.order=T, 
          colors=pal2,vfont=c("script","plain"))

