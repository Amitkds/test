
install.packages('pander')
library("pander")
element <- c("a","b","c","d","e")
S1 <- c(0,1,1,0,1)
S2 <- c(0,0,1,0,0)
S3 <- c(1,0,0,0,0)
S4 <- c(1,1,0,1,1)
my.data <- cbind(element,S1,S2,S3,S4)

pandoc.table(my.data,style="rmarkdown")

signature <- c(2,4,3,1)
pandoc.table(signature,style="rmarkdown")

library("pander")
signature <- c(2,4,3,1)
pandoc.table(signature,style="rmarkdown")