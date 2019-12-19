setwd('c:\\semi\\semi_semi')
family_Y2016<-read.csv('data/서울시 세대원수별 세대수(구별) 통계_2016년.csv', header=T, stringsAsFactors=F)
family_Y2017<-read.csv('data/서울시 세대원수별 세대수(구별) 통계_2017년.csv', header=T, stringsAsFactors=F)
family_Y2018<-read.csv('data/서울시 세대원수별 세대수(구별) 통계_2018년.csv', header=T, stringsAsFactors=F)

names(family_Y2016)<-c('기간','자치구','전체세대','1인세대','2인세대','3인세대','4인세대','5인세대','6인세대','7인세대','8인세대','9인세대','10인세대이상')
names(family_Y2017)<-c('기간','자치구','전체세대','1인세대','2인세대','3인세대','4인세대','5인세대','6인세대','7인세대','8인세대','9인세대','10인세대이상')
names(family_Y2018)<-c('기간','자치구','전체세대','1인세대','2인세대','3인세대','4인세대','5인세대','6인세대','7인세대','8인세대','9인세대','10인세대이상')

pp_Y2016<-read.csv('data/서울시 주민등록연앙인구 (연령별, 구별) 통계_2016년.csv', header=T, stringsAsFactors=F)
pp_Y2017<-read.csv('data/서울시 주민등록연앙인구 (연령별, 구별) 통계_2017년.csv', header=T, stringsAsFactors=F)
pp_Y2018<-read.csv('data/서울시 주민등록연앙인구 (연령별, 구별) 통계_2018년.csv', header=T, stringsAsFactors=F)


names(pp_Y2016)<-c('기간','자치구','성별','계','0_4','5_9','10_14','15_19','20_24','25_29','30_34','35_39','40_44','45_49','50_54','55_59','60_64','65_69','70_74','75_79','80_84','85_89','90_94','95_99','100_')
names(pp_Y2017)<-c('기간','자치구','성별','계','0_4','5_9','10_14','15_19','20_24','25_29','30_34','35_39','40_44','45_49','50_54','55_59','60_64','65_69','70_74','75_79','80_84','85_89','90_94','95_99','100_')
names(pp_Y2018)<-c('기간','자치구','성별','계','0_4','5_9','10_14','15_19','20_24','25_29','30_34','35_39','40_44','45_49','50_54','55_59','60_64','65_69','70_74','75_79','80_84','85_89','90_94','95_99','100_')


pp_Y2016_tmp<-pp_Y2016[pp_Y2016$자치구!='합계' & pp_Y2016$성별=='계',]
pp_Y2016_tmp<-pp_Y2016_tmp[c(1,2,4,5,6)]
row.names(pp_Y2016_tmp)<-c(1:length(row.names(pp_Y2016_tmp)))

pp_Y2017_tmp<-pp_Y2017[pp_Y2017$자치구!='합계' & pp_Y2017$성별=='계',]
pp_Y2017_tmp<-pp_Y2017_tmp[c(1,2,4,5,6)]
row.names(pp_Y2017_tmp)<-c(1:length(row.names(pp_Y2017_tmp)))

pp_Y2018_tmp<-pp_Y2018[pp_Y2018$자치구!='합계' & pp_Y2018$성별=='계',]
pp_Y2018_tmp<-pp_Y2018_tmp[c(1,2,4,5,6)]
row.names(pp_Y2018_tmp)<-c(1:length(row.names(pp_Y2018_tmp)))

family_Y2016_tmp<-family_Y2016[-1,-1]
row.names(family_Y2016_tmp)<-c(1:length(row.names(family_Y2016_tmp)))

family_Y2017_tmp<-family_Y2017[-1,-1]
row.names(family_Y2017_tmp)<-c(1:length(row.names(family_Y2017_tmp)))

family_Y2018_tmp<-family_Y2018[-1,-1]
row.names(family_Y2018_tmp)<-c(1:length(row.names(family_Y2018_tmp)))


library(dplyr)
gu_Y2016_df<-full_join(pp_Y2016_tmp, family_Y2016_tmp, by='자치구')
gu_Y2017_df<-full_join(pp_Y2017_tmp, family_Y2017_tmp, by='자치구')
gu_Y2018_df<-full_join(pp_Y2018_tmp, family_Y2018_tmp, by='자치구')

gu_Y2016_df$계<-gsub('[,]','',gu_Y2016_df$계)


for (i in 3:length(names(gu_Y2016_df))) {
  gu_Y2016_df[,i]<-gsub('[,]','',gu_Y2016_df[,i])
  gu_Y2017_df[,i]<-gsub('[,]','',gu_Y2017_df[,i])
  gu_Y2018_df[,i]<-gsub('[,]','',gu_Y2018_df[,i])
}
