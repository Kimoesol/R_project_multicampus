setwd("C:/Users/student/R_semi_project")
file_name = 'sb_lib_list2.rds'
sb_lib_list2 = readRDS(file_name)
View(sb_lib_list2)
library(dplyr)

# 각 도서관 별로 2018년 2월 데이터의 class 확인
for (i in 1:11) {
  print(class(sb_lib_list2[[i]]$`2018년 2월`))
}
# 전부 data.frame 형식 갖춘 것 확인 [3~12월도 확인했음]


################################### 진짜 시작

# 1. 각 도서관마다 월별로 대출건수가 0인 목록 도출

# 1-1. 각 도서관마다 2018년 2월에 대출건수가 0인 도서명 추출 
list_num_0 = c()
loan_num_0 = data.frame()
for (i in 1:11) {
  sb_library = sb_lib_list2[[i]]
  month = sb_library$`2018년 02월`
  temp = month %>% filter(대출건수==0)
  temp$도서명 = as.character(temp$도서명)
  loan_num_0 = c(loan_num_0, temp)
  list_num_0 = c(list_num_0, loan_num_0[2*i-1])
}
names(list_num_0) = names(sb_lib_list2)
View(list_num_0)


# 1-2. 각 도서관마다 2018년 2월에 대출건수가 0이 아닌 도서명 추출
list_num_not0 = c()
loan_num_not0 = data.frame()
for (i in 1:11) {
  sb_library = sb_lib_list2[[i]]
  month = sb_library$`2018년 02월`
  temp = month %>% filter(대출건수!=0)
  temp$도서명 = as.character(temp$도서명)
  loan_num_not0 = c(loan_num_not0, temp)
  list_num_not0 = c(list_num_not0, loan_num_not0[2*i-1])
}
names(list_num_not0) = names(sb_lib_list2)
View(list_num_not0)


# 2-1. 
# 달빛마루도서관에서 2018년 02월에 대출건수가 0이 아닌 도서들 중에 대출건수 기준으로 내림차순
b = data.frame()
# d = list()
for (i in 1:11) {
  a = sb_lib_list2[[i]][[1]] %>% filter(대출건수!=0) %>% arrange(desc(대출건수))
  a$도서명 = as.character(a$도서명)
  a$대출건수 = as.integer(a$대출건수)
  b = c(b, a)
  # d = c(d, as.data.frame(b[2*i-1], b[2*i]))
}
View(b)
class(b)
b

list_data = list()
for (i in 1:length(b)) {
  list_data[[i]] = b[[i]]
  # if (i %% 10 == 0) {
  #   cat(i,"번째 출력중",'\n')
  # }
}
class(list_data)


for (i in 1:length(b)) {
  if (i %% 2 == 1) {
    names(list_data[[i]]) = as.vector(names(sb_lib_list2))[i]
  }
}

g = c()
for (i in 1:length(names(sb_lib_list2))) {
  g = c(g, names(sb_lib_list2)[i])
}

h = c()
for (i in 1:length(g)) {
  h = c(h, paste0(g[i]," ","도서명"))
  h = c(h, paste0(g[i]," ","대출건수"))
}

h

names(list_data) = h

View(list_data)



# <중요> 이름 인덱싱 하는 방법 !!
# list_data[[tmp_name]]  = temp

# r_list = list()
# for (tmp_lib_name in names(sb_lib_list2)) {
#   tmp_lib_list = sb_lib_list2[[tmp_lib_name]]
#   
#   
#   
#   r_list[[tmp_lib_name]] = tmp_lib_list
# }

