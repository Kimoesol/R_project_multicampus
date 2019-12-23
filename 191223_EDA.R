setwd("C:/Users/student/R_semi_project/2018년_중구_ISBN기준_아동도서_대출목록")
library(dplyr)

pop = read.csv("인기대출도서_2018-1.csv", header=T, stringsAsFactors=F, skip=13)
pop = pop %>% select(서명, 출판년도, 대출건수)
pop %>% arrange(출판년도)

length(unique(pop$서명))

# if (pop$서명[i] %in% pop$서명) {
#   pop$대출건수 = pop$대출건수 + pop대출건수[i]
#   pop[-i,]
# }

