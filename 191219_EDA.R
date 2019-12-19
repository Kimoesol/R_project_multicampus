setwd("C:/Users/student/R_semi_project")
loan_cnt = read.csv("191219_2016_2018년 서울시 구별 ISBN아동 인기대출도서 대출건수.csv")
View(loan_cnt)
'pop2016' = read.csv("서울시 주민등록연앙인구 (연령별, 구별) 통계_2016년.csv")
'pop2017' = read.csv("서울시 주민등록연앙인구 (연령별, 구별) 통계_2017년.csv")
'pop2018' = read.csv("서울시 주민등록연앙인구 (연령별, 구별) 통계_2018년.csv")
'human_num2016' = read.csv("서울시 세대원수별 세대수(구별) 통계_2016년.csv")
'human_num2017' = read.csv("서울시 세대원수별 세대수(구별) 통계_2017년.csv")
'human_num2018' = read.csv("서울시 세대원수별 세대수(구별) 통계_2018년.csv")


library(dplyr)

# 연도
year2016 = loan_cnt %>% filter(year==2016)
year2017 = loan_cnt %>% filter(year==2017)
year2018 = loan_cnt %>% filter(year==2018)
View(year2016)


# 구별, 연령별 주민등록연앙인구
pop2016 = pop2016 %>% filter(구분.1=="계") %>% group_by(구분)
pop2016 = pop2016[-1,-3]

pop2017 = pop2017 %>% filter(구분.1=="계") %>% group_by(구분)
pop2017 = pop2017[-1,-3]

pop2018 = pop2018 %>% filter(구분.1=="계") %>% group_by(구분)
pop2018 = pop2018[-1,-3]

View(pop2016)

# 구별 세대원수별 세대수
human_num2016 = human_num2016[-1,]
human_num2017 = human_num2017[-1,]
human_num2018 = human_num2018[-1,]


# 각 연도별 데이터 프레임 만들기
data_Y2016 = data.frame()
data_Y2016 = left_join(year2016, pop2016, by=c("gu"="구분","year"="기간"))
data_Y2016 = left_join(data_Y2016, human_num2016, by=c("gu"="자치구", "year"="기간"))
data_Y2017 = left_join(year2017, pop2017, by=c("gu"="구분","year"="기간"))
data_Y2017 = left_join(data_Y2017, human_num2017, by=c("gu"="자치구", "year"="기간"))
data_Y2018 = left_join(year2018, pop2018, by=c("gu"="구분","year"="기간"))
data_Y2018 = left_join(data_Y2018, human_num2018, by=c("gu"="자치구", "year"="기간"))

View(data_Y2016)
View(data_Y2017)
View(data_Y2018)

# 데이터 전처리 (gsub)
for (i in 5:length(names(data_Y2016))){
  data_Y2016[,i] = gsub(",","",data_Y2016[,i])
}

for (i in 5:length(names(data_Y2017))){
  data_Y2017[,i] = gsub(",","",data_Y2017[,i])
}

for (i in 5:length(names(data_Y2018))){
  data_Y2018[,i] = gsub(",","",data_Y2018[,i])
}

# 최종 데이터 프레임 만들기
data_all = rbind(data_Y2016, data_Y2017, data_Y2018)
View(data_all)
