test1 = read.csv("191219_2016_2018년 서울시 구별 ISBN아동 인기대출도서 대출건수 (인구통계 추가) (1).csv")
test1 = test1 %>% select(기간, 자치구,loan_count, X0.4세, X5.9세, X10.14세)
test1 = test1 %>% arrange(desc(자치구))

barplot(test1$X0.4세+test1$X5.9세+test1$X10.14세, test1$loan_count)

b = c()
for (i in 1:length(nrow(test1))) {
  a = sum(test1[i,]$X0.4세,test1[i,]$X5.9세,test1[i,]$X10.14세)
  b = append(b,a)
}
b
View(test1)

