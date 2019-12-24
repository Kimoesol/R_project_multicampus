# 성북구 인기대출도서(1월) 데이터에서 ISBN number 가져오기
setwd("C:/Users/student/R_semi_project/2018년_성북구_ISBN기준_아동_인기대출도서")
data = read.csv("인기대출도서_2018-1.csv", skip=13, header=T, stringsAsFactors=F)
data = data %>% select(서명, ISBN, 대출건수)
View(data)

# 1. 추천도서 목록조회 API 활용
library(dplyr)
library(XML)
API_KEY = ""
ISBN_number = data$ISBN[1]
url = paste0("http://data4library.kr/api/recommandList?authKey=",API_KEY,"&isbn13=",ISBN_number)
doc = xmlParse(url)
top = xmlRoot(doc); top
df = xmlToDataFrame(getNodeSet(doc, "//book")); df
rec_book1 = df %>% select(bookname, isbn13)
View(rec_book1)

# 2. 도서별 이용 분석 API 활용
url = paste0("http://data4library.kr/api/usageAnalysisList?authKey=",API_KEY,"&isbn13=",ISBN_number)
doc = xmlParse(url)
top = xmlRoot(doc); top
df = xmlToDataFrame(getNodeSet(doc, "//recBooks/book"))
rec_book2 = df %>% select(bookname, isbn13)
View(rec_book2)

# 두 방법으로 했을 때 추출되는 도서들의 ISBN number가 같은지 확인
for (i in 1:nrow(rec_book2)) {
  print(rec_book1$isbn13[i] == rec_book2$isbn13[i])  
}

