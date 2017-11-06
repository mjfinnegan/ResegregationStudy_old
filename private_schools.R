jeff_poverty2014_15 <- read_excel("~/Documents/Github/BirminghamGentrification/Schools/bham_city_schools_lunch2014_15.xlsx")

invol_deseg <- data.table::fread('~/Dropbox/PkgData/SchoolData/desegregation-orders/invol_data.csv')
vol_deseg <- data.table::fread('~/Dropbox/PkgData/SchoolData/desegregation-orders/vol_data.csv')
invol_deseg<- invol_deseg[which(invol_deseg$State=='AL')]

l.public <- list()

export(characterize(import("~/Documents/Github/Schools/psu97ai.sas7bdat")), "~/Documents/Github/Schools/pub97.csv")
l.public$ccd_97_98 <- data.table::fread('~/Documents/Github/Schools/pub97.csv')
l.public$ccd_97_98 <- l.public$ccd_97_98[ST97=='AL']


export(characterize(import("~/Documents/Github/Schools/sc981cai.sas7bdat")), "~/Documents/Github/Schools/pub98.csv")
l.public$ccd_98_99 <- data.table::fread('~/Documents/Github/Schools/pub98.csv')
l.public$ccd_98_99 <- l.public$ccd_98_99[MSTATE98=='AL']

export(characterize(import("~/Documents/Github/Schools/sc991bai.sas7bdat")), "~/Documents/Github/Schools/pub99.csv")
l.public$ccd_99_00 <- data.table::fread('~/Documents/Github/Schools/pub99.csv')
l.public$ccd_99_00 <- l.public$ccd_99_00[MSTATE99=='AL']

export(characterize(import("~/Documents/Github/Schools/sc001aai.sas7bdat")), "~/Documents/Github/Schools/pub00.csv")
l.public$ccd_00_01 <- data.table::fread('~/Documents/Github/Schools/pub00.csv')
l.public$ccd_00_01 <- l.public$ccd_00_01[MSTATE00=='AL']

export(characterize(import("~/Documents/Github/Schools/sc011aai.sas7bdat")), "~/Documents/Github/Schools/pub01.csv")
l.public$ccd_01_02 <- data.table::fread('~/Documents/Github/Schools/pub01.csv')
l.public$ccd_01_02 <- l.public$ccd_01_02[MSTATE01=='AL']

export(characterize(import("~/Documents/Github/Schools/sc021aai.sas7bdat")), "~/Documents/Github/Schools/pub02.csv")
l.public$ccd_02_03 <- data.table::fread('~/Documents/Github/Schools/pub02.csv')
l.public$ccd_02_03 <- l.public$ccd_02_03[MSTATE02=='AL']

export(characterize(import("~/Documents/Github/Schools/sc031aai.sas7bdat")), "~/Documents/Github/Schools/pub03.csv")
l.public$ccd_03_04 <- data.table::fread('~/Documents/Github/Schools/pub03.csv')
l.public$ccd_03_04 <- l.public$ccd_03_04[MSTATE03=='AL']

export(characterize(import("~/Documents/Github/Schools/sc041bai.sas7bdat")), "~/Documents/Github/Schools/pub04.csv")
l.public$ccd_04_05 <- data.table::fread('~/Documents/Github/Schools/pub04.csv')
l.public$ccd_04_05 <- l.public$ccd_04_05[MSTATE04=='AL']

export(characterize(import("~/Documents/Github/Schools/sc051aai.sas7bdat")), "~/Documents/Github/Schools/pub05.csv")
l.public$ccd_05_06 <- data.table::fread('~/Documents/Github/Schools/pub05.csv')
l.public$ccd_05_06 <- l.public$ccd_05_06[MSTATE05=='AL']

export(characterize(import("~/Documents/Github/sc061cai.sas7bdat")), "~/Documents/Github/Schools/pub6.csv")
l.public$ccd_06_07 <- data.table::fread('~/Documents/Github/Schools/pub6.csv')
l.public$ccd_06_07 <- l.public$ccd_06_07[MSTATE06=='AL']

export(characterize(import("~/Documents/Github/Schools/sc071b.sas7bdat")), "~/Documents/Github/Schools/pub7.csv")
l.public$ccd_07_08 <- data.table::fread('~/Documents/Github/Schools/pub7.csv')
l.public$ccd_07_08 <- l.public$ccd_07_08[MSTATE07=='AL']

export(characterize(import("~/Documents/Github/Schools/sc081b.sas7bdat")), "~/Documents/Github/Schools/pub8.csv")
l.public$ccd_08_09 <- data.table::fread('~/Documents/Github/Schools/pub8.csv')
l.public$ccd_08_09 <- l.public$ccd_08_09[MSTATE08=='AL']

export(characterize(import("~/Documents/Github/Schools/sc092a.sas7bdat")), "~/Documents/Github/Schools/pub9.csv")
l.public$ccd_09_10 <- data.table::fread('~/Documents/Github/Schools/pub9.csv')
l.public$ccd_09_10 <- l.public$ccd_09_10[MSTATE09=='AL']

export(characterize(import("~/Documents/Github/Schools/sc102a.sas7bdat")), "~/Documents/Github/Schools/pub10.csv")
l.public$ccd_10_11 <- data.table::fread('~/Documents/Github/Schools/pub10.csv')
l.public$ccd_10_11 <- l.public$ccd_10_11[MSTATE=='AL']

export(characterize(import("~/Documents/Github/Schools/sc111a_supp.sas7bdat")), "~/Documents/Github/Schools/pub11.csv")
l.public$ccd_11_12 <- data.table::fread('~/Documents/Github/Schools/pub11.csv')
l.public$ccd_11_12 <- l.public$ccd_11_12[MSTATE=='AL']

export(characterize(import("~/Documents/Github/Schools/sc122a.sas7bdat")), "~/Documents/Github/Schools/pub12.csv")
l.public$ccd_12_13 <- data.table::fread('~/Documents/Github/Schools/pub12.csv')
l.public$ccd_12_13 <- l.public$ccd_12_13[MSTATE=='AL']

export(characterize(import("~/Documents/Github/Schools/sc132a.sas7bdat")), "~/Documents/Github/Schools/pub13.csv")
l.public$ccd_13_14 <- data.table::fread('~/Documents/Github/Schools/pub13.csv')
l.public$ccd_13_14 <- l.public$ccd_13_14[MSTATE=='AL']

export(characterize(import("~/Documents/Github/Schools/ccd_sch_052_1415_w_0216161a.sas7bdat")), "~/Documents/Github/Schools/pub14.csv")
l.public$ccd_14_15 <- data.table::fread('~/Documents/Github/Schools/pub14.csv')
l.public$ccd_14_15 <- l.public$ccd_14_15[STABR=='AL']

export(characterize(import("~/Documents/Github/Schools/ccd_sch_029_1516_sas_prel.sas7bdat")), "~/Documents/Github/Schools/pub15.csv")
l.public$ccd_15_16 <- data.table::fread('~/Documents/Github/Schools/pub15.csv')
l.public$ccd_15_16 <- l.public$ccd_15_16[STBR=='AL']

l.public$ccd_16_17 <- data.table::fread('~/Downloads/ccd_sch_029_1617_w_prel_050317.csv')
l.public$ccd_16_17 <- l.public$ccd_16_17[ST=='AL']



pub86 <- read.table('~/Documents/Github/Schools/psu86ai.txt', sep="\t",header=FALSE, fill=FALSE)
export(characterize(import("~/Documents/Github/Schools/psu86ai.txt")), "~/Documents/Github/pub86.csv")
l.public$ccd_86_87 <- data.table::fread('~/Documents/Github/pub86.csv')
l.public$ccd_86_87 <- l.public$ccd_86_87[MSTATE86=='AL']

write.csv("~/Dropbox/PkgData/SchoolData/private/pss1112.txt", "~/Desktop/pss1112.csv")

setwd("~/Documents/Github/private")
export(characterize(import("pss8990_pu.sas7bdat")), "pss89.csv")
export(characterize(import("pss9192_pu.sas7bdat")), "pss91.csv")
export(characterize(import("pss9394_pu.sas7bdat")), "pss93.csv")
export(characterize(import("pss9596_pu.sas7bdat")), "pss95.csv")
export(characterize(import("pss9798_pu.sas7bdat")), "pss97.csv")
export(characterize(import("pss9900_pu.sas7bdat")), "pss99.csv")
export(characterize(import("pss0102_pu.sas7bdat")), "pss01.csv")
export(characterize(import("pss0304_pu.sas7bdat")), "pss03.csv")
export(characterize(import("pss0506_pu.sas7bdat")), "pss05.csv")
export(characterize(import("pss0708_pu.sas7bdat")), "pss07.csv")
export(characterize(import("pss0910_pu.sas7bdat")), "pss09.csv")
export(characterize(import("pss1112_pu.sas7bdat")), "pss11.csv")

pvt_89 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss89.csv")
pvt_91 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss91.csv")
pvt_93 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss93.csv")
pvt_95 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss95.csv")
pvt_97 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss97.csv")
pvt_99 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss99.csv")
pvt_01 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss01.csv")
pvt_03 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss03.csv")
pvt_05 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss05.csv")
pvt_07 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss07.csv")
pvt_09 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss09.csv")
pvt_11 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss11.csv")
pvt_13 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss13.csv")
pvt_15 <- read.csv("~/Dropbox/PkgData/SchoolData/private/pss15.csv")

pvt_89 <- filter(pvt_89, pvt_89$STATE=='AL')
pvt_91 <- filter(pvt_91, pvt_91$ESTABB=='AL')
pvt_93 <- filter(pvt_93, pvt_93$PSTABB=='AL')
pvt_95 <- filter(pvt_95, pvt_95$QSTABB=='AL')
pvt_97 <- filter(pvt_97, pvt_97$RSTABB=='AL')
pvt_99 <- filter(pvt_99, pvt_99$SSTABB=='AL')
pvt_01 <- filter(pvt_01, pvt_01$PSTABB=='AL')
pvt_03 <- filter(pvt_03, pvt_03$PSTABB=='AL')
pvt_05 <- filter(pvt_05, pvt_05$pstabb=='AL')
pvt_07 <- filter(pvt_07, pvt_07$pstabb=='AL')
pvt_09 <- filter(pvt_09, pvt_09$pstabb=='AL')
pvt_11 <- filter(pvt_11, pvt_11$pstabb=='AL')
pvt_13 <- filter(pvt_13, pvt_13$PSTABB=='AL')
pvt_15 <- filter(pvt_15, pvt_15$pstabb=='AL')

pvt_89$EZIP <- substr(pvt_89$EZIP, 1, 5)
pvt_91$EZIP <- substr(pvt_91$EZIP, 1, 5)
pvt_93$PZIP <- substr(pvt_93$PZIP, 1, 5)
pvt_95$QZIP <- substr(pvt_95$QZIP, 1, 5)
pvt_97$RZIP <- substr(pvt_97$RZIP, 1, 5)
pvt_99$SZIP <- substr(pvt_99$SZIP, 1, 5)
pvt_01$PZIP <- substr(pvt_01$PZIP, 1, 5)
pvt_03$PZIP <- substr(pvt_03$PZIP, 1, 5)
pvt_05$pzip <- substr(pvt_05$pzip, 1, 5)
pvt_07$pzip <- substr(pvt_07$pzip, 1, 5)
pvt_09$pzip <- substr(pvt_09$pzip, 1, 5)
pvt_11$pzip <- substr(pvt_11$pzip, 1, 5)
pvt_13$PZIP <- substr(pvt_13$PZIP, 1, 5)
pvt_15$pzip <- substr(pvt_15$pzip, 1, 5)

id05_codes <- data.frame(pvt_05$ppin, pvt_05$longitude, pvt_05$latitude)


max.len = max(length(pvt_89$EPIN), length(pvt_89$EZIP), length(pvt_91$EPIN),
              length(pvt_91$EZIP),
              length(pvt_93$PPIN), length(pvt_93$PZIP), length(pvt_95$QPIN),
              length(pvt_95$QZIP),
              length(pvt_97$RPIN), length(pvt_97$RZIP), length(pvt_99$SPIN),
              length(pvt_99$SZIP),
              length(pvt_01$PPIN), length(pvt_01$PZIP), length(pvt_03$PPIN),
              length(pvt_03$PZIP),
              length(pvt_05$ppin), length(pvt_05$pzip), length(pvt_07$ppin),
              length(pvt_07$pzip),
              length(pvt_09$ppin), length(pvt_09$pzip), length(pvt_11$ppin),
              length(pvt_11$pzip),
              length(pvt_13$PPIN), length(pvt_13$PZIP), length(pvt_15$ppin),
              length(pvt_15$pzip))


pvt.df = list(pvt_89$EPIN, pvt_89$EZIP, pvt_91$EPIN, pvt_91$EZIP,
          pvt_93$PPIN, pvt_93$PZIP, pvt_95$QPIN, pvt_95$QZIP,
          pvt_97$RPIN, pvt_97$RZIP, pvt_99$SPIN, pvt_99$SZIP,
          pvt_01$PPIN, pvt_01$PZIP, pvt_03$PPIN, pvt_03$PZIP,
          pvt_05$ppin, pvt_05$pzip, pvt_07$ppin, pvt_07$pzip,
          pvt_09$ppin, pvt_09$pzip, pvt_11$ppin, pvt_11$pzip,
          pvt_13$PPIN, pvt_13$PZIP, pvt_15$ppin, pvt_15$pzip)
attributes(pvt.df) = list(names = names(pvt.df),
                        row.names=1:max.len, class='data.frame')
colnames(pvt.df) = c("pvt_89_PIN", "pvt_89_ZIP", "pvt_91_PIN", "pvt_91_ZIP",
               "pvt_93_PIN", "pvt_93_ZIP", "pvt_95_PIN", "pvt_95_ZIP",
               "pvt_97_PIN", "pvt_97_ZIP", "pvt_99_PIN", "pvt_99_ZIP",
               "pvt_01_PIN", "pvt_01_ZIP", "pvt_03_PIN", "pvt_03_ZIP",
               "pvt_05_PIN", "pvt_05_ZIP", "pvt_07_PIN", "pvt_07_ZIP",
               "pvt_09_PIN", "pvt_09_ZIP", "pvt_11_PIN", "pvt_11_ZIP",
               "pvt_13_PIN", "pvt_13_ZIP", "pvt_15_PIN", "pvt_15_ZIP")

pvt.df$pvt_13_ZIP <- as.numeric(pvt.df$pvt_13_ZIP)
str(pvt.df$pvt_15_ZIP)

exist_13_15 <- pvt.df[pvt.df$pvt_13_PIN==pvt.df$pvt_15_PIN,]



anything doesnt have a change in zipcode from 2005 to 2003
