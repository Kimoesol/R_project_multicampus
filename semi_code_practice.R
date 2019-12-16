# 1. 성북구 청소년(14~19세) 인기도서 대출건수 정리

setwd('C:/codingstudy/R_semi_project')
install.packages('dplyr')
library(dplyr)

for(i in 1:12) {
  data_i = read.csv(paste0("C:/codingstudy/R_semi_project/2018년_성북구_청소년(14~19)_대출목록/인기대출도서_2018-",i,".csv"), skip=13)
  data_i = data_i %>% select("서명","대출건수")
  # join 함수를 사용하여 대출건수에 대한 데이터를 합친다.
  data_all = full_join(data_all, data_i, by=c("서명","서명"))
}
  
class(data_all)
View(data_all[3:18])
data_all = data_all %>% mutate(count=rowSums(data_all[,3:18], na.rm=T))
data_all = data_all %>% arrange(desc(count)) %>% select("서명","count")
View(data_all)
head(data_all)
data_all_sample = head(data_all, 20)
View(data_all_sample)
png('semi_practice1.png', width=480, height=480)
barplot(data_all_sample$count, names.arg = data_all_sample$서명, ylim=c(0,40),
        col=rainbow(nrow(data_all_sample)))
dev.off()

# 2. 성북구 도서관별 대출 상황

load("C:/codingstudy/R_semi_project/2018년 성북구 도서관별 대출목록.RData")

a = full_join(sb_lib_list$달빛마루도서관[[1]],sb_lib_list$달빛마루도서관[[2]],by=c("도서명","도서명"))
a = a %>% mutate("2월 대출건수"=a$대출건수.y-a$대출건수.x)
a = a %>% select(-2)
View(a)

a = full_join(a, sb_lib_list$달빛마루도서관[[3]],by=c("도서명","도서명"))
a = a %>% mutate("3월 대출건수"=a$대출건수-a$대출건수.y)
a = a %>% select(-2)
View(a)

a = full_join(a, sb_lib_list$달빛마루도서관[[4]],by=c("도서명","도서명"))
a = a %>% mutate("4월 대출건수"=a$대출건수.y-a$대출건수.x)
a = a %>% select(-3)
View(a)

b = a %>% arrange(desc(대출건수.y))
View(b)

# 아직 진행하지 않은 단계 (5월~12월)
a = full_join(a, sb_lib_list$달빛마루도서관[[5]],by=c("도서명","도서명"))


# 함부로 실행시키면 골로 가는 소스
# for(i in 3:12) {
#   a = full_join(a, sb_lib_list$달빛마루도서관[[i]],by=c("도서명","도서명"))
# }