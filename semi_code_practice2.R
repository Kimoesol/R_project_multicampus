# 1. 2018년 성북구 청소년(14~19)세 인기도서 대출건수
setwd('C:/Users/student/R_semi_project')
library(dplyr)

data_all = read.csv(paste0("C:/Users/student/R_semi_project/2018년_성북구_청소년(14~19)_대출목록/인기대출도서_2018-",1,".csv"), skip=13)
data_all = data_all %>% select("서명","대출건수")
for (i in 2:12) {
  data_i = read.csv(paste0("C:/Users/student/R_semi_project/2018년_성북구_청소년(14~19)_대출목록/인기대출도서_2018-",i,".csv"), skip=13)
  data_i = data_i %>% select("서명","대출건수")
  data_all = full_join(data_all, data_i, by=c("서명","서명"))
}


data_all = data_all %>% mutate(count=rowSums(data_all[,2:13], na.rm=T))
data_all = data_all %>% arrange(desc(count)) %>% select("서명","count")
View(data_all)
data_all_sample = head(data_all, 20)
png('semi_practice1.png', width=480, height=480)
barplot(data_all_sample$count, names.arg = data_all_sample$서명, ylim=c(0,30),
        col=rainbow(nrow(data_all_sample)))
dev.off()

View(data_all)


for (i in 1:length(data_all)) {
  if (data_all$서명[i] == data_all$서명[i+1]) {
    data_all$count[i] = data_all$count[i] + data_all$count[i+1]
    data_all = data_all[-(i+1),]
  }
}

data_all = data_all %>% arrange(desc(서명))
data_all = data_all %>% arrange(desc(count))
View(data_all)
for (i in 1:300) {
  if (data_all$서명[i] == data_all$서명[i+1]) {
    data_all$count[i] = data_all$count[i] + data_all$count[i+1]
    data_all = data_all[-(i+1),]
  }
}
View(data_all)

# 2. 성북구에서 각 도서관이 있는 동의 인구 데이터
load("C:/Rstudy/R_semi_project/2018년 성북구 도서관별 대출목록.RData")
names(sb_lib_list) # 성북구: 11개의 도서관 보유

# 2-1 11개 도서관 별로 주소, 위도, 경도 내용을 담고 있는 df 추출
lib_address = read.csv("C:/Users/student/R_semi_project/도서관정보나루_참여도서관목록.csv", header=TRUE, skip=5)
lib_address = lib_address %>% select('참여도서관_11건','X')
names(lib_address) = c('도서관명','주소')
lib_address = lib_address[-1,]
lib_address = lib_address %>% mutate('행정동'=c('월곡2동','정릉1동','석관동','월곡2동',
                                             '돈암2동','돈암2동','월곡2동','정릉2동',
                                             '종암동','정릉4동','돈암2동'))

View(lib_address)

# 2-2 연령별, 동별 인구 통계

# 1) 성북구 동별 총 인구
population = read.csv('C:/Users/student/R_semi_project/서울시 주민등록인구_(연령별,동별) 통계.csv', header=TRUE)
population = population %>% filter(자치구=='성북구') %>% filter(구분=='계')
population = population %>% select(-기간,-자치구,-구분)
population = population[-1,]
View(population)

# 전체 인구 대비 0~4세 인구 비율 구하기
# population = population %>% 
#   mutate('ratio_BabyToTotal'=
#            round((as.numeric(as.character(population$X0.4세))/
#                     as.numeric(as.character(population$계))*100),2))


# 2) 성북구 동별 영아(0~4세) 인구
# population_baby = population %>% select('행정동','X0.4세','ratio_BabyToTotal')
# 
# View(population_baby)

# 3) 성북구 도서관별 행정동, 그리고 행정동 별로 인구 수치, 비율
sb_adr_plus_pop = inner_join(lib_address,population,by="행정동")
View(sb_adr_plus_pop)


# 3 2018 성북구 도서관 데이터
setwd("C:/Rstudy/R_semi_project_data")
gu = 'seongbook'
file_name = paste('2018', gu, 'library cumsum data.rds')
sb_cumsum_list = readRDS(file_name)
nrow(sb_cumsum_list$달빛마루도서관[[1]])

View(sb_cumsum_list)
