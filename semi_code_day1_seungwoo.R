library(readxl)
src_dir<-c('c:\\semi\\data\\강북\\1')
src_file <- list.files(src_dir)
src_file_cnt<-length(src_file)
a<-list()
library(dplyr)
for(i in 1:src_file_cnt){
  temp <- read_excel(paste0(src_dir, "/", src_file[i])) %>% select(대출건수) %>%  head()
  a<-a+temp
}