library(readxl)
src_dir<-c('C:/Rstudy/세미프로젝트/성북구 대출목록/석관동미리내도서관2018')
src_file <- list.files(src_dir)
src_file_cnt<-length(src_file)
a<-list()
library(dplyr)
for(i in 1:src_file_cnt){
  temp <- read_excel(paste0(src_dir, "/", src_file[i])) %>% select(도서명,대출건수)
  a <- append(a, temp)
}

View(a)

b <- list()

for (i in 1:12) {
  temp <- as.data.frame(cbind(a[[2*i-1]], a[[2*i]]), stringsAsFactors=F )
  temp$V2 <- as.numeric(temp$V2)
  temp <- temp %>% arrange(desc(temp$V2)) %>% head(10)
  b[[i]] <- temp
}

c2 <- b[1:12]
