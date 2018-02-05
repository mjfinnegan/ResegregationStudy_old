invol_deseg <- data.table::fread('~/Dropbox/PkgData/SchoolData/desegregation-orders/invol_data.csv')
vol_deseg <- data.table::fread('~/Dropbox/PkgData/SchoolData/desegregation-orders/vol_data.csv')
invol_deseg<- invol_deseg[which(invol_deseg$State=='AL')]

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

pvt_89 <- subset(pvt_89, STATE=='AL')
pvt_91 <- subset(pvt_91, pvt_91$ESTABB=='AL')
pvt_93 <- subset(pvt_93, pvt_93$PSTABB=='AL')
pvt_95 <- subset(pvt_95, pvt_95$QSTABB=='AL')
pvt_97 <- subset(pvt_97, pvt_97$RSTABB=='AL')
pvt_99 <- subset(pvt_99, pvt_99$SSTABB=='AL')
pvt_01 <- subset(pvt_01, pvt_01$PSTABB=='AL')
pvt_03 <- subset(pvt_03, pvt_03$PSTABB=='AL')
pvt_05 <- subset(pvt_05, pvt_05$pstabb=='AL')
pvt_07 <- subset(pvt_07, pvt_07$pstabb=='AL')
pvt_09 <- subset(pvt_09, pvt_09$pstabb=='AL')
pvt_11 <- subset(pvt_11, pvt_11$pstabb=='AL')
pvt_13 <- subset(pvt_13, pvt_13$PSTABB=='AL')
pvt_15 <- subset(pvt_15, pvt_15$pstabb=='AL')

pvt_03$PZIP <- substr(pvt_03$PZIP, 1, 5)
pvt_05$pzip <- substr(pvt_05$pzip, 1, 5)
pvt_07$pzip <- substr(pvt_07$pzip, 1, 5)
pvt_09$pzip <- substr(pvt_09$pzip, 1, 5)
pvt_11$pzip <- substr(pvt_11$pzip, 1, 5)
pvt_13$PZIP <- substr(pvt_13$PZIP, 1, 5)
pvt_15$pzip <- substr(pvt_15$pzip, 1, 5)

##consolidate variables

keep89 <- c("EPIN", "CITY", "STATE", "EZIP", "PSS064",
            "NUMSTUDS", "STTCH_RT", "HIGRADE") 
pvt_89 <- pvt_89[keep89]
names(pvt_89)[names(pvt_89)=="PSS064"] <- "religious"
names(pvt_89)[names(pvt_89)=="EZIP"] <- "zip89"
names(pvt_89)[names(pvt_89)=="EPIN"] <- "pin"
names(pvt_89)[names(pvt_89)=="STATE"] <- "STABB"
pvt_89$INST <- NA
pvt_89$ADDRS <- NA
pvt_89$CNT <- NA
pvt_89$MINOR <- NA
pvt_89$zip89 <- substr(pvt_89$zip89, 1, 5)

keep91 <- c("EPIN", "ECITY", "ESTABB", "ECNTNM", "EZIP", "PSC063",
            "NUMSTUDS", "STTCH_RT", "HIGRADE") 
pvt_91 <- pvt_91[keep91]
names(pvt_91)[names(pvt_91)=="PSC063"] <- "religious"
names(pvt_91)[names(pvt_91)=="EZIP"] <- "zip91"
names(pvt_91)[names(pvt_91)=="EPIN"] <- "pin"
pvt_91$INST <- NA
pvt_91$ADDRS <- NA
pvt_91$MINOR <- NA
pvt_91$zip91 <- substr(pvt_91$zip91, 1, 5)

keep93 <- c("PPIN", "PCITY", "PSTABB", "PCNTNM", "PZIP", "P380", "P210", "P215", "P220", "P225", "P230",
            "NUMSTUDS", "STTCH_RT", "HIGRADE",  "P_INDIAN", "P_ASIAN", "P_HISP", "P_BLACK", "P_WHITE",
            "PMINOR") 
pvt_93 <- pvt_93[keep93]
names(pvt_93)[names(pvt_93)=="P380"] <- "religious"
names(pvt_93)[names(pvt_93)=="PZIP"] <- "zip93"
names(pvt_93)[names(pvt_93)=="PPIN"] <- "pin"
pvt_93$WHITE <- pvt_93$NUMSTUDS*pvt_93$P_INDIAN
pvt_93$ASIAN <- pvt_93$NUMSTUDS*pvt_93$P_ASIAN
pvt_93$HISP <- pvt_93$NUMSTUDS*pvt_93$P_HISP
pvt_93$BLACK <- pvt_93$NUMSTUDS*pvt_93$P_BLACK
pvt_93$WHITE <- pvt_93$NUMSTUDS*pvt_93$P_WHITE
## 1993 race counts are now considered 'imputed', but in fact the percentages were the created variables
## the counts simply werent included in the report.
pvt_93$INST <- NA
pvt_93$ADDRS <- NA
pvt_93$zip93 <- substr(pvt_93$zip93, 1, 5)

keep95 <- c("QPIN", "QCITY", "QSTABB", "QCNTNM", "QZIP","P345", "P350", "P355", "P360", "P365", "P430",
            "NUMSTUDS", "STTCH_RT",  "P_INDIAN", "P_ASIAN", "P_HISP",
            "P_BLACK", "P_WHITE", "PERMINOR", "QHIGR6") 
pvt_95 <- pvt_95[keep95]
names(pvt_95)[names(pvt_95)=="P430"] <- "religious"
names(pvt_95)[names(pvt_95)=="QPIN"] <- "pin"
names(pvt_95)[names(pvt_95)=="QZIP"] <- "zip95"
names(pvt_95)[names(pvt_95)=="QHIGR6"] <- "HIGR1996"
pvt_95$INST <- NA
pvt_95$ADDRS <- NA
pvt_95$zip95 <- substr(pvt_95$zip95, 1, 5)

keep97 <- c("RPIN", "RCITY", "RSTABB", "RCNTNM", "RZIP","P310", "P315", "P320", "P325", "P330", "P340", "P430",
            "NUMSTUDS", "STTCH_RT",  "P_INDIAN", "P_ASIAN", "P_HISP",
            "P_BLACK", "P_WHITE", "PMINOR", "HIGR8") 
pvt_97 <- pvt_97[keep97]
names(pvt_97)[names(pvt_97)=="P340"] <- "MALES"
names(pvt_97)[names(pvt_97)=="P430"] <- "religious"
names(pvt_97)[names(pvt_97)=="RPIN"] <- "pin"
names(pvt_97)[names(pvt_97)=="RZIP"] <- "zip97"
names(pvt_97)[names(pvt_97)=="HIGR8"] <- "HIGR1998"
pvt_97$INST <- NA
pvt_97$ADDRS <- NA
pvt_97$zip97 <- substr(pvt_97$zip97, 1, 5)

keep99 <- c("SPIN", "SCITY", "SSTABB", "SCNTYNM", "SZIP","P310", "P315", "P320", "P325", "P330", "P340", "P360", 
            "P361", "P430", "NUMSTUDS", "STTCH_RT",  "P_INDIAN", "P_ASIAN", 
            "P_HISP", "P_BLACK", "P_WHITE", "PMINOR", "HIGR2000") 
pvt_99 <- pvt_99[keep99]
names(pvt_99)[names(pvt_99)=="P340"] <- "MALES"
names(pvt_99)[names(pvt_99)=="P360"] <- "pct_4year"
names(pvt_99)[names(pvt_99)=="P361"] <- "pct_2year"
names(pvt_99)[names(pvt_99)=="P430"] <- "religious"
names(pvt_99)[names(pvt_99)=="SPIN"] <- "pin"
names(pvt_99)[names(pvt_99)=="SZIP"] <- "zip99"
pvt_99$INST <- NA
pvt_99$ADDRS <- NA
pvt_99$zip99 <- substr(pvt_99$zip99, 1, 5)

keep01 <- c("PPIN", "PCITY", "PSTABB", "PCNTNM", "PZIP","P310", "P315", "P320", "P325", "P330", "P340", "P360", 
            "P361", "P430", "NUMSTUDS", "STTCH_RT",  "P_INDIAN", "P_ASIAN", 
            "P_HISP", "P_BLACK", "P_WHITE", "PMINOR", "HIGR2002") 
pvt_01 <- pvt_01[keep01]
names(pvt_01)[names(pvt_01)=="P340"] <- "MALES"
names(pvt_01)[names(pvt_01)=="P360"] <- "pct_4year"
names(pvt_01)[names(pvt_01)=="P361"] <- "pct_2year"
names(pvt_01)[names(pvt_01)=="P430"] <- "religious"
names(pvt_01)[names(pvt_01)=="PPIN"] <- "pin"
names(pvt_01)[names(pvt_01)=="PZIP"] <- "zip01"
pvt_01$INST <- NA
pvt_01$ADDRS <- NA
pvt_01$zip01 <- substr(pvt_01$zip01, 1, 5)

keep03 <- c("PPIN", "PCITY", "PSTABB", "PCNTNM",
            "PZIP", "P310", "P315", "P320", "P325", "P330", "P360", "P361", "P430", "MALES", "NUMSTUDS",
            "P_INDIAN", "P_ASIAN", "P_HISP", "P_BLACK", "P_WHITE",
            "PMINOR", "STTCH_RT", "HIGR2004") 
pvt_03 <- pvt_03[keep03]
names(pvt_03)[names(pvt_03)=="P360"] <- "pct_4year"
names(pvt_03)[names(pvt_03)=="P361"] <- "pct_2year"
names(pvt_03)[names(pvt_03)=="P430"] <- "religious"
names(pvt_03)[names(pvt_03)=="PZIP"] <- "zip03"
names(pvt_03)[names(pvt_03)=="PPIN"] <- "pin"
pvt_03$INST <- NA
pvt_03$ADDRS <- NA
pvt_03$zip03 <- substr(pvt_03$zip03, 1, 5)

keep05 <- c("ppin", "pinst", "pcity", "pstabb", "pcntnm",
            "pzip","latitude", "longitude","P310", "P315", "P320", "P325", "P330", "P360", "P361", "P430",
            "males", "numstuds", "p_indian", "p_asian", "p_hisp", 
            "p_black", "p_white", "pminor", "sttch_rt", "higr2006")
pvt_05 <- pvt_05[keep05]
names(pvt_05)[names(pvt_05)=="P360"] <- "pct_4year"
names(pvt_05)[names(pvt_05)=="P361"] <- "pct_2year"
names(pvt_05)[names(pvt_05)=="P430"] <- "religious"
names(pvt_05)[names(pvt_05)=="pzip"] <- "zip05"
names(pvt_05)[names(pvt_05)=="ppin"] <- "pin"
pvt_05$ADDRS <- NA
pvt_05$zip05 <- substr(pvt_05$zip05, 1, 5)

keep07 <- c("ppin", "pinst", "pcity", "pstabb", "pcntnm",
            "pzip", "paddrs","latitude", "longitude", "P310", "P315", "P320", "P325", "P330", "P360", "P430",
            "males", "numstuds", "p_indian", "p_asian", "p_hisp", 
            "p_black", "p_white", "pminor", "sttch_rt", "higr2008")
pvt_07 <- pvt_07[keep07]
names(pvt_07)[names(pvt_07)=="P360"] <- "pct_4year"
names(pvt_07)[names(pvt_07)=="P430"] <- "religious"
names(pvt_07)[names(pvt_07)=="pzip"] <- "zip07"
names(pvt_07)[names(pvt_07)=="PPIN"] <- "pin"
pvt_07$zip07 <- substr(pvt_07$zip07, 1, 5)

keep09 <- c("ppin", "pinst", "pcity", "pstabb", "pcntnm",
            "pzip", "paddrs", "latitude10", "longitude10","P320", "P330", "P325", "P316", "P318", "P310", "P360", "P430",
            "males", "numstuds", "p_indian", "p_asian", "p_hisp", 
            "p_pacific","p_black", "p_white", "p_two", "sttch_rt", 
            "higr2010")
pvt_09 <- pvt_09[keep09]
names(pvt_09)[names(pvt_09)=="P360"] <- "pct_4year"
names(pvt_09)[names(pvt_09)=="P430"] <- "religious"
names(pvt_09)[names(pvt_09)=="pzip"] <- "zip09"
names(pvt_09)[names(pvt_09)=="ppin"] <- "pin"
names(pvt_09)[names(pvt_09)=="p_two"] <- "P_TR"
pvt_09$zip09 <- substr(pvt_09$zip09, 1, 5)


keep11 <- c("ppin", "pinst", "pcity", "pstabb", "pcntnm",
            "pzip", "paddrs", "latitude12", "longitude12","p320", "p330", "p325", "p316", "p318", "p310", "p360", "p430",
            "males", "numstuds", "p_indian", "p_asian", "p_hisp", 
            "p_pacific","p_black", "p_white", "p_tr", "sttch_rt", 
            "higr2012")
pvt_11 <- pvt_11[keep11]
names(pvt_11)[names(pvt_11)=="p360"] <- "pct_4year"
names(pvt_11)[names(pvt_11)=="p430"] <- "religious"
names(pvt_11)[names(pvt_11)=="pzip"] <- "zip11"
names(pvt_11)[names(pvt_11)=="ppin"] <- "pin"
pvt_11$zip11 <- substr(pvt_11$zip11, 1, 5)

keep13 <- c("PPIN", "PINST", "PCITY", "PSTABB", "PCNTNM",
            "PZIP", "PADDRS", "LATITUDE14", "LONGITUDE14", "P320", "P330", "P325", "P316", "P318", "P310", "P360", "P430",
            "MALES", "NUMSTUDS", "P_INDIAN", "P_ASIAN", "P_PACIFIC",
            "P_HISP","P_BLACK", "P_WHITE", "P_TR", "STTCH_RT", 
            "HIGR2014")
pvt_13 <- pvt_13[keep13]
names(pvt_13)[names(pvt_13)=="P360"] <- "pct_4year"
names(pvt_13)[names(pvt_13)=="P430"] <- "religious"
names(pvt_13)[names(pvt_13)=="PZIP"] <- "zip13"
names(pvt_13)[names(pvt_13)=="PPIN"] <- "pin"
pvt_13$zip13 <- substr(pvt_13$zip13, 1, 5)

keep15 <- c("ppin", "pinst", "pcity", "pstabb", "pcntnm",
            "pzip", "paddrs", "latitude16", "longitude16", "p320", "p330", "p325", "p316", "p318", "p310", "p360", "p430",
            "males", "numstuds", "p_indian", "p_asian", "p_hisp", 
            "p_pacific","p_black", "p_white", "p_tr", "sttch_rt", 
            "higr2016")
pvt_15 <- pvt_15[keep15]
names(pvt_15)[names(pvt_15)=="p360"] <- "pct_4year"
names(pvt_15)[names(pvt_15)=="p430"] <- "religious"
names(pvt_15)[names(pvt_15)=="pzip"] <- "zip15"
names(pvt_15)[names(pvt_15)=="ppin"] <- "pin"
pvt_15$zip15 <- substr(pvt_15$zip15, 1, 5)


pvt_89$YR <- '1989'
pvt_91$YR <- '1991'
pvt_93$YR <- '1993'
pvt_95$YR <- '1995'
pvt_97$YR <- '1997'
pvt_99$YR <- '1999'
pvt_01$YR <- '2001'
pvt_03$YR <- '2003'
pvt_05$YR <- '2005'
pvt_07$YR <- '2007'
pvt_09$YR <- '2009'
pvt_11$YR <- '2011'
pvt_13$YR <- '2013'
pvt_15$YR <- '2015'

l.pvt <- list(pvt_89, pvt_91, pvt_93, pvt_95, pvt_97, pvt_99, pvt_01, pvt_03, pvt_05, pvt_07, pvt_09, pvt_11, pvt_13, pvt_15)

funStandardizeFields <- function(dt){
  data.table::setnames(dt, names(dt), stringr::str_to_upper(names(dt)))
  data.table::setnames(dt, names(dt)[grep('HIGR', names(dt))], 'HIGR')
  data.table::setnames(dt, names(dt)[grep('ZIP', names(dt))], 'ZIP')
  data.table::setnames(dt, names(dt)[grep('CITY', names(dt))], 'CITY')
  if (length(grep('CNT', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('CNT', names(dt))], 'COUNTY')
  }
  if (length(grep('STABB', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('STABB', names(dt))], 'STATE')
  }
  if (length(grep('INST', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('INST', names(dt))], 'SCHOOL')
  }
  if (length(grep('ADDRS', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('ADDRS', names(dt))], 'ADDRESS')
  }
  if (length(grep('MINOR', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('MINOR', names(dt))], 'P_MINOR')
  }
  if (length(grep('P310', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P310', names(dt))], 'NATIVE')
  }
  if (length(grep('P315', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P315', names(dt))], 'ASIAN')
  }
  if (length(grep('P316', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P316', names(dt))], 'ASIAN')
  }
  if (length(grep('P320', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P320', names(dt))], 'HISP')
  }
  if (length(grep('P325', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P325', names(dt))], 'BLACK')
  }
  if (length(grep('P325', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P325', names(dt))], 'BLACK')
  }
  if (length(grep('P330', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('P330', names(dt))], 'WHITE')
  }
  if (length(grep('LATITUDE', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('LATITUDE', names(dt))], 'LATITUDE')
    data.table::setnames(dt, names(dt)[grep('LONGITUDE', names(dt))], 'LONGITUDE')
  }
  dt$PIN <- as.character(dt$PIN)
  return(dt)
} 
l.pvt <- lapply(l.pvt, funStandardizeFields)
dt.pvt <- data.table::rbindlist(l.pvt, fill=TRUE, use.names=TRUE)
dt.pvt$STATE <- "AL"
#Recode non-parochial schools as having value of 0
dt.pvt$RELIGIOUS[dt.pvt$RELIGIOUS==2] <- 0


# Build zip 'best guess'
centroids <- data.table::fread("~/Box Sync/zip_centroids_2010census.csv")
centroids$intptlat <- as.numeric(stringr::str_replace(centroids$intptlat, '\\+', ''))
centroids$intptlon <- as.numeric(centroids$intptlon)


funAssignGeo <- function(x.pin, dt.pvt, zip.locs, centroids){
  cat(x.pin, '\n')
  dt.pin <- dt.pvt[PIN==x.pin]

  if (x.pin=='00002369'){
    dt.pin$ZIP <- '36426'  #originally zip=36427, but no centroid match so recoded to 36426
  }
  if (x.pin=='01926175'){
    dt.pin$ZIP <- '36301'
  }
  if (x.pin=='02001283'){
    dt.pin$ZIP <- '36744'
  } 
  if (x.pin=='00001886'){
    dt.pin$ZIP <- '36925'
  }
  if (x.pin=='01925987'){
    dt.pin$ZIP <- '35601'
  }
  if (x.pin=='A9100120'){
    dt.pin$ZIP <- '36693'
  }
  if (x.pin=='A9100161'){
    dt.pin$ZIP <- '36804'
  }
  if (x.pin=='A9300004'){
    dt.pin$ZIP <- '36330'
  }
  if (x.pin=='A9300006'){
    dt.pin$ZIP <- '36532'
  }
  if (x.pin=='A9300016'){
    dt.pin$ZIP <- '36117'
  } 
  if (x.pin=='A9302013'){
    dt.pin$ZIP <- '35233'
  } 
  
  if (unique(dt.pin$ZIP %in% centroids$zcta5)==FALSE){
    dt.pin$ZIP <- unique(centroids$zcta5[findInterval(dt.pin$ZIP,centroids$zcta5)])
  }
  # Check to see if missed survey for a given year
  #n.years <- length(unique(dt.pvt$YR))
  #n.pin.years <- nrow(dt.pin)
  #ifelse(n.years != n.pin.years, dt.pin$survey.notes <- 'Missed year', dt.pin$survey.notes <- 'Full')

  # If unique zipcodes then try to assign lat long
  zips <- unique(dt.pin$ZIP)
  zips <- zips[!is.na(zips)]
  

  
  if (!(is.na(zips)) && length(zips==1)){
    lat.val <- unique(round(dt.pin$LATITUDE,digits = 3))
    long.val <- unique(round(dt.pin$LONGITUDE,digits = 3))
    recent.year <- max(dt.pin[!(is.na(LATITUDE))]$YR)
    lat.val.recent <- dt.pin[YR==recent.year]$LATITUDE
    long.val.recent <- dt.pin[YR==recent.year]$LONGITUDE
    address.recent <- dt.pin[YR==recent.year]$ADDRESS
    if (length(lat.val[!is.na(lat.val)])==1 && length(zips==1)){
      dt.pin$data.notes <- 'One lat and long pair'
      dt.pin$LATITUDE <- lat.val.recent
      dt.pin$LONGITUDE <- long.val.recent
      dt.pin$ADDRESS <- address.recent
    }
    if (length(lat.val[!is.na(lat.val)])>1 && length(zips==1)){ # approximately one lat long pair... use 2015 lat long pair
      dt.pin$data.notes <- 'Multiple Lat and Long'
      dt.pin$LATITUDE <- lat.val.recent
      dt.pin$LONGITUDE <- long.val.recent
      dt.pin$ADDRESS <- address.recent
      #use 2015 lat/long
    } 
    if (length(zips)>=2){ # multiple zips
      dt.pin$data.notes <- 'changed locations'
      #manually adjust in excel
    } 
    if (length(is.na(unique(lat.val)))==1 && is.na(unique(lat.val))==TRUE){ # No lat long pair
      # Use zip centroid        ^[^ ]+
          dt.pin$LATITUDE <- centroids[zcta5 %in% zips]$intptlat
          dt.pin$LONGITUDE <- centroids[zcta5 %in% zips]$intptlon
          dt.pin$data.notes <- 'Lat and Long from zip centroid'
          }
  # print(head(dt.pin))
  return(dt.pin)
  }
}

PINS <- unique(dt.pvt$PIN)


l.clean <- lapply(PINS, function(x.pin) funAssignGeo(x.pin, dt.pvt, zip.locs, centroids))
dt.clean <- data.table::rbindlist(l.clean,use.names = TRUE, fill=TRUE)
data.table::setnames(dt.clean, 'P_INDIAN', 'P_NATIVE')

library(dplyr)
dt.names <- na.omit(distinct(select(dt.clean, PIN, SCHOOL)))
for(id in 1:nrow(dt.names)){
  dt.clean$SCHOOL[dt.clean$PIN %in% dt.names$PIN[id]] <- dt.names$SCHOOL[id]
}

dt.cnty <- na.omit(distinct(select(dt.clean, PIN, COUNTY)))
for(id in 1:nrow(dt.cnty)){
  dt.clean$COUNTY[dt.clean$PIN %in% dt.cnty$PIN[id]] <- dt.cnty$COUNTY[id]
}
rm(dt.cnty)
rm(dt.names)

write.csv(dt.clean, '~/Desktop/privates.csv')



#graph pct going to 4 year, religious, race

library(ggplot2)
count.schools <- data.frame(table(dt.clean$YR))
count.schools$YR <- c(1989, 1991, 1993, 1995, 1997, 1999, 2001, 2003, 2005, 2007, 2009, 2011, 2013, 2015)
ggplot(count.schools, aes(x=YR, Freq)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("# of Private Schools") +
  ggtitle("All Private Schools in Alabama from 1989 to 2015")

library(purrr)
summary.stats <- dt.clean %>% split(.$YR) %>% map(summary)

library(psych)
summary.stats.pwhite <- na.omit(describe.by(dt.clean$P_WHITE, group=dt.clean$YR, mat=TRUE))
summary.stats.pwhite$YR <- c(1993, 1995, 1997, 1999, 2001, 2003, 2005, 2007, 2009, 2011, 2013, 2015)
ggplot(summary.stats.pwhite, aes(x=YR, mean)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Mean Percent of White Students") +
  ggtitle("Percent White in Alabama Privates from 1989 to 2015")

summary.stats.pblack <- na.omit(describe.by(dt.clean$P_BLACK, group=dt.clean$YR, mat=TRUE))

summary.stats.phisp <- na.omit(describe.by(dt.clean$P_HISP, group=dt.clean$YR, mat=TRUE))

summary.stats.pasian <- na.omit(describe.by(dt.clean$P_ASIAN, group=dt.clean$YR, mat=TRUE))

races.means <- bind_cols(summary.stats.pwhite, summary.stats.pblack, summary.stats.phisp, summary.stats.pasian)
races.means$YR <- c(1993, 1995, 1997, 1999, 2001, 2003, 2005, 2007, 2009, 2011, 2013, 2015)
races.means <- races.means[,c("YR","mean","mean1","mean2", "mean3")]
names(races.means)[names(races.means)=="mean"] <- "p_white"
names(races.means)[names(races.means)=="mean1"] <- "p_black"
names(races.means)[names(races.means)=="mean2"] <- "p_hispanic"
names(races.means)[names(races.means)=="mean3"] <- "p_asian"
races.means <- races.means[with(races.means, order(YR)),]
races.means$total <- races.means$p_white+races.means$p_black+races.means$p_hispanic+races.means$p_asian


ggplot(races.means, aes(x=YR, group=1)) +
  geom_line(aes(y=p_white, colour="White")) +
  geom_line(aes(y=p_black, colour="Black")) +
  geom_line(aes(y=p_hispanic, colour="Hispanic")) +
  geom_line(aes(y=p_asian, colour="Asian")) +
  scale_colour_manual("", 
                      values = c("White"="black", "Black"="green", 
                                 "Hispanic"="blue", "Asian"="purple")) +
  xlab("Year") +
  ylab("Percent") +
  ggtitle("Ethnicities of Students who are in Private Schools")


summary.stats.parochial <- na.omit(describe.by(dt.clean$RELIGIOUS, group=dt.clean$YR, mat=TRUE))
summary.stats.parochial$YR <- c(1989, 1991, 1993, 1995, 1997, 1999, 2001, 2003, 2005, 2007, 2009, 2011, 2013, 2015)

ggplot(summary.stats.parochial, aes(x=YR, mean)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Mean Percent of Parochial Schools") +
  ggtitle("Percent of Alabama Privates that are Parochial from 1989 to 2015")
#1993 is clearly a sketchy year

dt.clean$YR <- as.factor(dt.clean$YR)
temp <- dt.clean %>%
  group_by(YR) %>%
  summarise(n.students = sum(NUMSTUDS))

ggplot(temp, aes(x=YR, n.students, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Number of students")

### The percent race variables were originally created by the NCES by computing the inverse of the
### formula below, so this is not any sort of imputation.
dt.clean$WHITE <- round((dt.clean$P_WHITE/100)*dt.clean$NUMSTUDS, 0)
dt.clean$BLACK <- round((dt.clean$P_BLACK/100)*dt.clean$NUMSTUDS, 0)
dt.clean$HISP <- round((dt.clean$P_HISP/100)*dt.clean$NUMSTUDS, 0)
dt.clean$ASIAN <- round((dt.clean$P_ASIAN/100)*dt.clean$NUMSTUDS, 0)
dt.clean$NATIVE <- round((dt.clean$P_NATIVE/100)*dt.clean$NUMSTUDS, 0)



