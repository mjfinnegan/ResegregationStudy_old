#Begin public school data

library(sas7bdat)
library(rio)
export(characterize(import("~/Documents/Github/Schools/Public/psu89.sas7bdat")), "~/Documents/Github/Schools/Public/pub89.csv")
pub89 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub89.csv')
pub89 <- pub89[st89=='AL']
names(pub89) <- sub('89', '', names(pub89))
pub89 <- as.data.frame(pub89)
drop <- grep("^i", names(pub89), value = TRUE)
drop <- drop[!drop=="ind"]
pub89 = pub89[,!(names(pub89) %in% drop)]


export(characterize(import("~/Documents/Github/Schools/Public/psu90.sas7bdat")), "~/Documents/Github/Schools/Public/pub90.csv")
pub90 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub90.csv')
pub90 <- pub90[st90=='AL']
names(pub90) <- sub('90', '', names(pub90))
pub90 <- as.data.frame(pub90)
drop <- grep("^I", names(pub90), value = TRUE)
drop <- drop[!drop=="ind"]
try = pub89[,!(names(pub89) %in% drop)]


export(characterize(import("~/Documents/Github/Schools/Public/psu91.sas7bdat")), "~/Documents/Github/Schools/Public/pub91.csv")
pub91 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub91.csv')
pub91 <- pub91[st91=='AL']
names(pub91) <- sub('91', '', names(pub91))


export(characterize(import("~/Documents/Github/Schools/Public/psu92.sas7bdat")), "~/Documents/Github/Schools/Public/pub92.csv")
pub92 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub92.csv')
pub92 <- pub92[st92=='AL']
names(pub92) <- sub('92', '', names(pub92))


export(characterize(import("~/Documents/Github/Schools/Public/psu93.sas7bdat")), "~/Documents/Github/Schools/Public/pub93.csv")
pub93 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub93.csv')
pub93 <- pub93[st93=='AL']
names(pub93) <- sub('93', '', names(pub93))


export(characterize(import("~/Documents/Github/Schools/Public/psu94.sas7bdat")), "~/Documents/Github/Schools/Public/pub94.csv")
pub94 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub94.csv')
pub94 <- pub94[st94=='AL']
names(pub94) <- sub('94', '', names(pub94))


export(characterize(import("~/Documents/Github/Schools/Public/psu95.sas7bdat")), "~/Documents/Github/Schools/Public/pub95.csv")
pub95 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub95.csv')
pub95 <- pub95[st95=='AL']
names(pub95) <- sub('95', '', names(pub95))


export(characterize(import("~/Documents/Github/Schools/Public/psu96.sas7bdat")), "~/Documents/Github/Schools/Public/pub96.csv")
pub96 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub96.csv')
pub96 <- pub96[st96=='AL']
names(pub96) <- sub('96', '', names(pub96))

pub97 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub97.csv')
pub97 <- pub97[ST97=='AL']
names(pub97) <- sub('97', '', names(pub97))

pub98 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub98.csv')
pub98 <- pub98[MSTATE98=='AL']
names(pub98) <- sub('98', '', names(pub98))

pub99 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub99.csv')
pub99 <- pub99[MSTATE99=='AL']
names(pub99) <- sub('99', '', names(pub99))

pub00 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub00.csv')
pub00 <- pub00[MSTATE00=='AL']
names(pub00) <- sub('00', '', names(pub00))


pub01 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub01.csv')
pub01 <- pub01[MSTATE01=='AL']
names(pub01) <- sub('01', '', names(pub01)) 

substrRight <- function(x, n){     #create function to state last to characters in string
  sapply(x, function(xx)
    substr(xx, (nchar(xx)-n+1), nchar(xx))
  )
}
  old <- names(which(substrRight(names(pub01),2)=="01"))    #list column names with year attached
  new <- substr(old,1,nchar(old)-2)   # list column names without year attached
  data.table::setnames(pub01, old, new)    # replace old names with new names, i.e. remove the year ending 
  pub01

pub02 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub02.csv')
pub02 <- pub02[MSTATE02=='AL']
old <- names(which(substrRight(names(pub02),2)=="02"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub02, old, new)    # replace old names with new names, i.e. remove the year ending 
pub02

pub03 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub03.csv')
pub03 <- pub03[MSTATE03=='AL']
old <- names(which(substrRight(names(pub03),2)=="03"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub03, old, new)    # replace old names with new names, i.e. remove the year ending 
pub03

pub04 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub04.csv')
pub04 <- pub04[MSTATE04=='AL']
old <- names(which(substrRight(names(pub04),2)=="04"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub04, old, new)    # replace old names with new names, i.e. remove the year ending 
pub04

pub05 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub05.csv')
pub05 <- pub05[MSTATE05=='AL']
old <- names(which(substrRight(names(pub05),2)=="05"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub05, old, new)    # replace old names with new names, i.e. remove the year ending 
pub05

pub06 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub06.csv')
pub06 <- pub06[MSTATE06=='AL']
old <- names(which(substrRight(names(pub06),2)=="06"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub06, old, new)    # replace old names with new names, i.e. remove the year ending 
pub06

pub07 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub07.csv')
pub07 <- pub07[MSTATE07=='AL']
old <- names(which(substrRight(names(pub07),2)=="07"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub07, old, new)    # replace old names with new names, i.e. remove the year ending 
pub07

pub08 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub08.csv')
pub08 <- pub08[MSTATE08=='AL']
old <- names(which(substrRight(names(pub08),2)=="08"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub08, old, new)    # replace old names with new names, i.e. remove the year ending 
pub08

pub09 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub09.csv')
pub09 <- pub09[MSTATE09=='AL']
old <- names(which(substrRight(names(pub09),2)=="09"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub09, old, new)    # replace old names with new names, i.e. remove the year ending 
pub09

pub10 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub10.csv')
pub10 <- pub10[MSTATE=='AL']
old <- names(which(substrRight(names(pub10),2)=="10"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub10, old, new)    # replace old names with new names, i.e. remove the year ending 
pub10

pub11 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub11.csv')
pub11 <- pub11[MSTATE=='AL']
old <- names(which(substrRight(names(pub11),2)=="11"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub11, old, new)    # replace old names with new names, i.e. remove the year ending 
pub11

pub12 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub12.csv')
pub12 <- pub12[MSTATE=='AL']
old <- names(which(substrRight(names(pub12),2)=="12"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub12, old, new)    # replace old names with new names, i.e. remove the year ending 
pub12

pub13 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub13.csv')
pub13 <- pub13[MSTATE=='AL']
old <- names(which(substrRight(names(pub13),2)=="13"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub13, old, new)    # replace old names with new names, i.e. remove the year ending 
pub13

pub14 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub14.csv')
pub14 <- pub14[STABR=='AL']
old <- names(which(substrRight(names(pub14),2)=="14"))    #list column names with year attached
new <- substr(old,1,nchar(old)-2)   # list column names without year attached
data.table::setnames(pub14, old, new)    # replace old names with new names, i.e. remove the year ending 
data.table::setnames(pub14, 'AS', 'ASIAN')
data.table::setnames(pub14, 'HI', 'HISP')
data.table::setnames(pub14, 'BL', 'BLACK')
data.table::setnames(pub14, 'WH', 'WHITE')
#HP is hawaiin/pacific islander


#pub15 <- data.table::fread('~/Dropbox/PkgData/SchoolData/public/pub15.csv')
#pub15 <- pub15[STABR=='AL']

pub89 <- pub89[, c("ncessch", "leaid", "schno", "leanm89", "schnam89", "street89", "city89",
                   "st89", "zip89", "locale89", "type89", "status89", "fte89", "gslo89", "gshi89", "member89", "fle89",
                   "ind89", "asian89", "hisp89", "black89", "white89")]

pub89$YEAR <- 1989
pub90$YEAR <- 1990
pub91$YEAR <- 1991
pub92$YEAR <- 1992
pub93$YEAR <- 1993
pub94$YEAR <- 1994
pub95$YEAR <- 1995
pub96$YEAR <- 1996
pub97$YEAR <- 1997
pub98$YEAR <- 1998
pub99$YEAR <- 1999
pub00$YEAR <- 2000
pub01$YEAR <- 2001
pub02$YEAR <- 2002
pub03$YEAR <- 2003
pub04$YEAR <- 2004
pub05$YEAR <- 2005
pub06$YEAR <- 2006
pub07$YEAR <- 2007
pub08$YEAR <- 2008
pub09$YEAR <- 2009
pub10$YEAR <- 2010
pub11$YEAR <- 2011
pub12$YEAR <- 2012
pub13$YEAR <- 2013
pub14$YEAR <- 2014
pub15$YEAR <- 2015


#ncessch is unique id
#leaid identifies school district
#schno identifies school
#type89:{1 = Regular school; 
        #2 = Special education school; 
        #3 = Vocational school; 
        #4 = Other/alternative school}
#status89:{1 = School continues operational from previous report; 
          #2 was used for schools which were closed;
          #3 = School has been opened since last report;
          #4 = School was operational during previous report but was not reported.}
#local89:{1 = Large Central City - A central city of Standard Metropolitan Statistical Area (SMSA) 
              #with population greater than or equal to 400,000 or a population density greater than
              #or equal to 6,000 persons per square mile.
         #2 = Mid-size Central City - A central city SMSA not designated Large Central City.
         #3 = Urban Fringe of Large City - A place within am SMSA of Large Central City and defined 
              #as urban by the U.S. Bureau of Census.
         #4 = Urban Fringe of Mid-size City - Any incorporated place, Census Designated Place, or non-place 
              #territory within a CMSA or MSA of a Mid-size City and defined as urban by the Census Bureau.
         #5 = Large Town - Place not within am SMSA, but with population greater than or to 25,000 and
              #defined as urban by the U.S. Bureau of the Census.
         #6 = Small Town - Place not within an SMSA, with population less than 25,000 but greater than or 
              #equal to 2,500 and defined as urban by the U.S. Bureau of the Census.
         #7 = Rural - Place with population less than 2,500 and defined as rural by U.S. Bureau of the Census.
#fte89 is number of teachers
#gslo89 is lowest grade at school
#member89 is total number of students
#fle89 is number of students on free lunch
#latcod is latitude
#loncod is longitude
#TITLEI is whether school is eligible for participation in programs authorized by Title I
#MAGNET is indicator for magnet school
#CHARTR is indicator for charter school
#FRELCH is number of students on free lunch
#REDLCH is number of students on reduced lunch
#G01 is total number of first grade students
#AM01M is number of american indian/alaskan native first-grade males
#AM01F is number of american indian/alaskan native first-grade females
#AM01U is number of american indian/alaskan native first-grade of unknown gender
#AS01M is number of asian/pacific islander first-grade males
#HI01M is number of hispanic first-grade males
#BL01M is number of black, non-hispanic first-grade males
#WH01M is number of white, non-hispanic first-grade males
#...
#AM06 is total number of american indian/alaskan native students in all grades
#AMALM is total number of american indian/alaskan native males in all grades
#ASIAN is total number of asian/pacific islander students in all grades
#ASALM is total number of asian/pacific islander males in all grades
#HISP is total number of hispanic students in all grades
#HIALM is total number of hispanic males in all grades
#BLACK is total number of black, non-hispanic students in all grades
#BLALM is total number of black, non-hispanic males in all grades
#WHITE is total number of white, non-hispanic students in all grades
#WHALM is total number of white, non-hispanic males in all grades
#PUPTCH is student-teacher ratio

#dt.pub <- readRDS("~/Dropbox/PkgData/SchoolData/public/dt.public.rds")

# generate list
l.public <- list(pub89, pub90, pub91, pub92, pub93, pub94, pub95, pub96, pub97, pub98, pub99, pub00, 
             pub01, pub02, pub03, pub04, pub05, pub06, pub07, pub08, pub09, pub10, pub11, pub12, 
             pub13, pub14)

# build standardize function
funStandardizeFields.pub <- function(dt){
  data.table::setnames(dt, names(dt), stringr::str_to_upper(names(dt)))
  dt$NCESSCH <- as.character(as.numeric(dt$NCESSCH))
  dt <- as.data.frame(dt)
  drop <- grep("^I", names(dt), value = TRUE)
  drop <- drop[!drop=="IND"]
  dt = dt[,!(names(dt) %in% drop)]
  
  if (length(grep('SCHNAM', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('SCHNAM', names(dt))], 'SCHNAM')
  }
  if (length(grep('LEANM', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('LEANM', names(dt))], 'LEANM')
  }
  if (length(grep('LSTATE', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('LSTATE', names(dt))], 'STATE')
  }
  if (length(grep('LCITY', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('LCITY', names(dt))], 'CITY')
  }
  #if (length(grep('FTE', names(dt)))>0){
   # data.table::setnames(dt, 'FTE', 'NUMTEACH')
  #}
  if (length(grep('CONAME', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('CONAME', names(dt))], 'COUNTY')
  }
  if (length(grep('GSLO', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('GSLO', names(dt))], 'LOWGRADE')
  }
  if (length(grep('GSHI', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('GSHI', names(dt))], 'HIGHGRADE')
  }
  if (length(grep('LATCOD', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('LATCOD', names(dt))], 'LATITUDE')
    data.table::setnames(dt, names(dt)[grep('LONCOD', names(dt))], 'LONGITUDE')
  }
  if (length(grep('MAGNET', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('MAGNET', names(dt))], 'MAGNET')
  }
  if (length(grep('CHARTR', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('CHARTR', names(dt))], 'CHARTR')
  }
  if (length(grep('FRELCH', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('FRELCH', names(dt))], 'FREELUNCH')
  }
  if (length(grep('REDLCH', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('REDLCH', names(dt))], 'REDUCEDLUNCH')
  }
  if (length(grep('MEMBER', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('MEMBER', names(dt))], 'MEMBER')
  }
  if (length(grep('PUPTCH', names(dt)))>0){
    data.table::setnames(dt, names(dt)[grep('PUPTCH', names(dt))], 'STTCH_RT')
}
  return(dt)
} 
# use lapply to clean each dataset
l.public <- lapply(l.public, funStandardizeFields.pub)
# rbind each dataset in the list
dt.public <- data.table::rbindlist(l.public, fill=TRUE, use.names=TRUE)
data.table::setnames(dt.public, 'IND', 'NATIVE')
data.table::setnames(dt.public, 'FTE', 'NUMTEACH')

# construct race percentage variables
dt.public$P_NATIVE <- dt.public$NATIVE/dt.public$MEMBER
dt.public$P_ASIAN <- dt.public$ASIAN/dt.public$MEMBER
dt.public$P_HISP <- dt.public$HISP/dt.public$MEMBER
dt.public$P_BLACK <- dt.public$BLACK/dt.public$MEMBER
dt.public$P_WHITE <- dt.public$WHITE/dt.public$MEMBER


drop <- grep("^I", names(dt.public), value = TRUE)
drop <- drop[!drop=="IND"]
var.out<-setdiff(names(dt.public),drop)
dt.public <- dt.public %>% dplyr:: select(var.out)

library(plyr)
library(dplyr)
library(data.table)
try <- dt.public[, CITY := unique(CITY[!is.na(CITY)]), by = NCESSCH]

dt.cnty <- na.omit(dplyr::distinct(select(dt.public, NCESSCH, COUNTY)))
for(id in 1:nrow(dt.cnty)){
  dt.public$COUNTY[dt.public$NCESSCH %in% dt.cnty$NCESSCH[id]] <- dt.cnty$COUNTY[id]
}
rm(dt.cnty)

cc <- data.frame(dt.public$COUNTY, dt.public$CITY)
cc <- na.omit(cc)
cc <- cc[!duplicated(cc),]
cc <- cc[grep("COUNTY", cc$dt.public.COUNTY), ]
cc <- mutate_each(cc, funs(toupper))


data.table::setnames(cc, 'dt.public.COUNTY', 'COUNTY')
data.table::setnames(cc, 'dt.public.CITY', 'CITY')

nm <- c("COUNTY")
dt.public <- as.data.frame(dt.public)
dt.public[nm] <- lapply(nm, function(x) cc[[x]][match(dt.public$CITY, cc$CITY)])


dt.public <- dt.public[with(dt.public, order(LEANM)),]

### prepare data to be merged with invol deseg order data ###

# first clean district names
dt.public$LEANM <- gsub(" SCH DIST.*","",dt.public$LEANM)
dt.public$LEANM <- gsub(" CITY CITY.*"," CITY",dt.public$LEANM)
dt.public$LEANM <- gsub(" CO.*"," COUNTY",dt.public$LEANM)

# capitalize  names in order data
invol_deseg <- mutate_each(invol_deseg, funs(toupper))

# merge public and deseg order data
data.table::setnames(invol_deseg, 'District Name', 'DISTRICT')
data.table::setnames(dt.public, 'LEANM', 'DISTRICT')
dt.public <- merge( x = dt.public, y = invol_deseg, by = "DISTRICT", all.x=TRUE)


dt.public$YEAR <- as.factor(dt.public$YEAR)
race.totals.public <- dt.public %>%
  group_by(YEAR) %>%
  summarise(n.native = sum(NATIVE, na.rm=TRUE),
            n.asian = sum(ASIAN, na.rm=TRUE),
            n.hisp = sum(HISP, na.rm=TRUE),
            n.black = sum(BLACK, na.rm=TRUE),
            n.white = sum(WHITE, na.rm=TRUE))
race.totals.public <- race.totals.public[as.numeric(race.totals.public$YEAR)%%2==1,]   # select only odd years

dt.clean$YR <- as.factor(dt.clean$YR)
race.totals.private <- dt.clean %>%
  group_by(YR) %>%
  summarise(n.native = sum(NUMSTUDS*(P_NATIVE/100), na.rm=TRUE),
            n.asian = sum(NUMSTUDS*(P_ASIAN/100), na.rm=TRUE),
            n.hisp = sum(NUMSTUDS*(P_HISP/100), na.rm=TRUE),
            n.black = sum(NUMSTUDS*(P_BLACK/100), na.rm=TRUE),
            n.white = sum(NUMSTUDS*(P_WHITE/100), na.rm=TRUE))

total.hisp <- race.totals.public$n.hisp+race.totals.private$n.hisp     # calculuate total number of students in state
total.asian <- race.totals.public$n.asian+race.totals.private$n.asian
total.black <- race.totals.public$n.black+race.totals.private$n.black
total.white <- race.totals.public$n.white+race.totals.private$n.white

race.pct.pvt <- data.frame(YEAR=race.totals.public$YEAR,              # create dataset on percent of state going to private by race
                               pct.pvt.hisp=race.totals.private$n.hisp/total.hisp,
                               pct.pvt.asian=race.totals.private$n.asian/total.asian,
                               pct.pvt.black=race.totals.private$n.black/total.black,
                               pct.pvt.white=race.totals.private$n.white/total.white)
race.pct.pvt <- race.pct.pvt[race.pct.pvt$YEAR!=2015,]

ggplot(race.pct.pvt, aes(x=YEAR, group=1)) +       # graph private school enrollment by race 
  geom_line(aes(y=pct.pvt.white, colour="White")) +
  geom_line(aes(y=pct.pvt.black, colour="Black")) +
  geom_line(aes(y=pct.pvt.hisp, colour="Hispanic")) +
  geom_line(aes(y=pct.pvt.asian, colour="Asian")) +
  scale_colour_manual("", 
                      values = c("White"="black", "Black"="green", 
                                 "Hispanic"="blue", "Asian"="purple")) +
  xlab("Year") +
  ylab("Percent") +
  ggtitle("Percent of Students Attending Privates by Race")


race.local.totals.public <- dt.public %>%
  group_by(YEAR,LOCAL) %>%
  summarise(n.native = sum(NATIVE, na.rm=TRUE),
            n.asian = sum(ASIAN, na.rm=TRUE),
            n.hisp = sum(HISP, na.rm=TRUE),
            n.black = sum(BLACK, na.rm=TRUE),
            n.white = sum(WHITE, na.rm=TRUE))
ggplot(race.pct.pvt, aes(x=YEAR, group=1)) +
  geom_line(aes(y=pct.pvt.white, colour="White")) +
  geom_line(aes(y=pct.pvt.black, colour="Black")) +
  geom_line(aes(y=pct.pvt.hisp, colour="Hispanic")) +
  geom_line(aes(y=pct.pvt.asian, colour="Asian")) +
  scale_colour_manual("", 
                      values = c("White"="black", "Black"="green", 
                                 "Hispanic"="blue", "Asian"="purple")) +
  xlab("Year") +
  ylab("Percent") +
  ggtitle("Percent of Students Attending Privates by Race") 



