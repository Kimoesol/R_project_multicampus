rm(list=ls())
setwd("C:/Users/student/R_semi_project")
library(dplyr)
library(XML)
api_key = "6cbf90cf628c9007879727b2f5d6aa59a8f8a6fe77d1700476714f7ef9440ea6"
options(scipen=99)

# 주제 : 전 달 아리랑어린이도서관 인기도서 10권이 대출중인 경우, 
# 이 책을 찾는 사람들에게 유사도가 높으면서 대출 건수가 적은 다른 책을 추천해주는 모델 수립

# 1. 자료수집 - '도서관/지역별 인기대출 도서 조회' API를 활용, 
# 아리랑어린이도서관의 최근 3(~12)개월 인기 상위 10위 아동 도서들 목록 수집 (인기 아동도서들)
## API 호출해 응답받은 xml 문서 파싱해 저장(도서명, ISBN, ISBN부가기호, 주제분류)
lib_code = 111468  # 아리랑어린이도서관 코드
start_d = '2019-09-01'
end_d = '2019-11-30'
fileUrl = paste0('http://data4library.kr/api/loanItemSrchByLib?authKey=', api_key,
                 '&libCode=', lib_code, '&startDt=', start_d, 
                 '&endDt=', end_d, '&addCode=7&pageSize=10')
xml_doc = xmlTreeParse(fileUrl,useInternal=TRUE)

pop_books = trimws(xpathSApply( xmlRoot(xml_doc), "//bookname", xmlValue)); pop_books
pop_ISBN = trimws(xpathSApply( xmlRoot(xml_doc), "//isbn13", xmlValue)); pop_ISBN
pop_addNum = trimws(xpathSApply( xmlRoot(xml_doc), "//addition_symbol", xmlValue)); pop_addNum
pop_classNum = trimws(xpathSApply( xmlRoot(xml_doc), "//class_no", xmlValue)); pop_classNum
pop_author = trimws(xpathSApply(xmlRoot(xml_doc), "//authors", xmlValue)); pop_author
pop_publisher = trimws(xpathSApply(xmlRoot(xml_doc), "//publisher", xmlValue)); pop_publisher

any(is.na(c(pop_books, pop_ISBN, pop_addNum, pop_classNum, pop_author, pop_publisher)))  # 정상이면 False

pop = cbind(pop_books, pop_ISBN, pop_addNum, pop_classNum, pop_author, pop_publisher)

# 2. 자료수집 - 해당 월의 아리랑어린이도서관 '장서/대출.csv' 파일에서, 
# 부가기호가 아동(7)이면서 누적대출건수 0(또는 n미만)인 도서들 목록 수집 (비인기 아동도서들)
# 2019년_11월_아리랑어린이도서관 장서/대출 데이터 로드 & 전처리 및 확인
## load columns : 도서명, ISBN, 부가기호, 주제분류번호, 도서권수, 대출건수
## 도서권수 0인 도서(독본) 제외, 아동도서(부가기호 7)만 추출, 대출건수 0만 추출

lib_df = read.csv('아리랑어린이도서관 장서 대출목록 (2019년 11월).csv',
                  stringsAsFactors=F )[c(2, 3, 4, 6, 8, 10, 11, 12)]
View(lib_df)

lib_df = lib_df %>% filter(도서권수 != 0)  # 도서권수 0 인 도서(독본) 제외
lib_df = lib_df %>% 
  filter(!is.na(부가기호) & 부가기호==7) %>% 
  select(-부가기호)  # 아동도서(부가기호 7)만 추출
lib_df = lib_df %>% 
  filter(대출건수==0) %>% 
  select(-대출건수)  # 누적 대출건수 0만 추출
nrow(lib_df)

str(lib_df)
table(is.na(lib_df))
summary(lib_df)

table(lib_df$주제분류번호)
table(lib_df$주제분류번호)[table(lib_df$주제분류번호) > 20] %>% sort()
# 해당하는 도서 많은 주제만 추출
## 813 소설, 990 전기, 375 유아 및 초등 교육, 811 시

table(lib_df$도서권수)
lib_df[ lib_df$도서권수>=5 , ] %>% arrange(도서권수)  # 도서권수 이상치 확인


# 3. 각 인기도서 별로, 비인기도서들 중 '주제분류번호' 같은 도서 목록 수집 
# (인기도서 1권 + 관련 비인기 아동도서들 m권)
# - 10개 인기도서 별로 생성된 m+1개의 도서목록에 대해, 4~8 진행
matched_books_df = lib_df[ lib_df$주제분류번호 %in% pop_classNum | lib_df$저자 %in% pop_author]
nrow(matched_books_df)  # 999권

table(pop_classNum)


table(pop[,4])
table(matched_books_df$주제분류번호)
table(lib_df$주제분류번호)

pop[,1][pop[,4]=="001"]
