###########################################################################
# Create Dissimilarity and Exposure Index
###########################################################################
library(dplyr)
library(ggplot2)

###################################################
# Clean Data
###################################################

####################################
# Prepare Private School Data
####################################

## subset private school data to only what we need
pvt.index <- dt.clean[, c("PIN",  "YR", "COUNTY", "CITY", "NUMSTUDS", "WHITE", "BLACK")]
pvt.index <- pvt.index[!pvt.index$YR=='1989']   # drop 1989 and 1991 since no race data
pvt.index <- pvt.index[!pvt.index$YR=='1991']
pvt.index <- mutate_each(pvt.index, funs(toupper))
pvt.index$COUNTY <- paste(pvt.index$COUNTY, "COUNTY", sep=" ")
pvt.index <- na.omit(pvt.index)
data.table::setnames(pvt.index, 'YR', 'YEAR')
pvt.index <- pvt.index[pvt.index$COUNTY!=' COUNTY', ]  # drop privates with no identified county
pvt.index <- pvt.index[!pvt.index$YEAR=='2015',]
pvt.index[which(grepl("BALDWIN COUNTY COUNTY", pvt.index$COUNTY)), 3] = "BALDWIN COUNTY"
pvt.index[which(grepl("MOBILE COUNTY COUNTY", pvt.index$COUNTY)), 3] = "MOBILE COUNTY"
pvt.index[which(grepl("TUSCALOOSA COU COUNTY", pvt.index$COUNTY)), 3] = "TUSCALOOSA COUNTY"
pvt.index[which(grepl("JEFFERSON COUN COUNTY", pvt.index$COUNTY)), 3] = "JEFFERSON COUNTY"
pvt.index[which(grepl("BIRMINGTON", pvt.index$CITY)), 4] = "BIRMINGHAM"
pvt.index$NUMSTUDS <- as.numeric(pvt.index$NUMSTUDS)
pvt.index$WHITE <- as.numeric(pvt.index$WHITE)
pvt.index$BLACK <- as.numeric(pvt.index$BLACK)
pvt.index$COUNTY <- as.factor(pvt.index$COUNTY)
pvt.index$YEAR <- as.factor(pvt.index$YEAR)
pvt.index <- pvt.index[with(pvt.index, order(YEAR, COUNTY)),]
pvt.index$PRIVATE <- 1

###### add dismissal to privates
pvt.city.county <- unique(pvt.index[,c('CITY','COUNTY')])
data.table::setnames(invol_deseg, 'City', 'CITY')
invol_deseg$region <- ifelse(grepl("CITY", invol_deseg$DISTRICT), "CITY", "COUNTY")
deseg_detail <- merge(pvt.city.county, invol_deseg, by="CITY", all.x=TRUE)
# if there is no city match, then it must be that the city is apart of a county district
deseg_detail$region[is.na(deseg_detail$region)] <- "COUNTY"
deseg_detail$DISTRICT[is.na(deseg_detail$DISTRICT)] <- as.character(deseg_detail$COUNTY[is.na(deseg_detail$DISTRICT)])
deseg_detail <- deseg_detail[, -c(4,6)] # drop state and year placed since unneccessary

for(id in 1:nrow(invol_deseg)){
  deseg_detail$`Year Lifted`[deseg_detail$DISTRICT %in% invol_deseg$DISTRICT[id]] <- invol_deseg$`Year Lifted`[id]
}
# fix NA for St. Clair. COUNTY
deseg_detail$`Year Lifted`[is.na(deseg_detail$`Year Lifted`)] <- "STILL OPEN" 

# if school in city where both city and county under order, then say dismissal occured at first date
deseg_detail <- deseg_detail %>% group_by(COUNTY, CITY) %>% top_n(n=1) 
pvt.index <- merge(pvt.index, deseg_detail, by=c("CITY", "COUNTY"), all.x=TRUE)
pvt.index$DISMISSED <- ifelse(pvt.index$`Year Lifted`=="STILL OPEN", 0, 1)
data.table::setnames(pvt.index, 'Year Lifted', 'YEAR_LIFTED')
write.csv(pvt.index, "~/Documents/Github/Schools/pvt.index.csv")


####################################
# Prepare Public School Data
####################################

pub.index <- dt.public[, c("NCESSCH", "DISTRICT", "YEAR", "COUNTY", "CITY", "MEMBER", "WHITE", "BLACK", "Year Lifted")]
data.table::setnames(pub.index, 'NCESSCH', 'PIN')
data.table::setnames(pub.index, 'MEMBER', 'NUMSTUDS')
data.table::setnames(pub.index, 'Year Lifted', 'YEAR_LIFTED')
# select years for which private school data also available
pub.index <- subset(pub.index, YEAR %in% c(1993,1995, 1997, 1999, 2001,2003,2005,2007,2009,2011,2013)) 
# throw out rows with missing values
# WARNING: this will omit a large amount of our data
pub.index <- na.omit(pub.index)
pub.index$PIN <- as.character(pub.index$PIN)
pub.index$WHITE <- round(as.numeric(pub.index$WHITE),0)
pub.index$BLACK <- round(as.numeric(pub.index$BLACK),0)
pub.index$NUMSTUDS <- as.numeric(pub.index$NUMSTUDS)
pub.index$COUNTY <- as.factor(pub.index$COUNTY)
pub.index$YEAR <- as.factor(pub.index$YEAR)
pub.index <- pub.index[with(pub.index, order(YEAR, COUNTY)),]
# only keep rows with recorded number of students (-2 was listed for no response)
pub.index <- pub.index[pub.index$NUMSTUDS>=0,]
# indicator for dismissal
pub.index$DISMISSED <- ifelse(pub.index$YEAR_LIFTED=="STILL OPEN", 0, 1)
# whether school is apart of a city or county district
pub.index$region <- ifelse(grepl("CITY", pub.index$DISTRICT), "CITY", "COUNTY")
pub.index$PRIVATE <- 0
pub.index$WHITE <- as.numeric(pub.index$WHITE)
pub.index$BLACK <- as.numeric(pub.index$BLACK)
write.csv(pub.index, "~/Documents/Github/Schools/pub.index.csv")




#pvt.index$DISMISSED <- NA
#for(id in 1:nrow(invol_deseg)){
#if (pvt.index$CITY %in% invol_deseg$CITY[id] && invol_deseg$region[id]=="CITY"){
#  pvt.index$DISMISSED[pvt.index$CITY %in% invol_deseg$CITY[id] && invol_deseg$region[id]=="CITY"] <- invol_deseg$`Year Lifted`[id]
#} else if (pvt.index$COUNTY %in% invol_deseg$DISTRICT[id] && invol_deseg$region[id]=="COUNTY"){
#  pvt.index$DISMISSED[pvt.index$COUNTY %in% invol_deseg$DISTRICT[id] && invol_deseg$region[id]=="COUNTY"] <- invol_deseg$`Year Lifted`[id]
#  }
#}


# code any school that had dismissal as 1 for the entire period
# code privates as dimissed if either city or country district dismissed







###################################################
# Create Index
###################################################

pub.index <- read.csv("file path")
pub.index <- pub.index[,-1] # throw out first column holding row number
pvt.index <- read.csv("file path")
pvt.index <- pvt.index[,-1]
df.schools <- rbind(pub.index, pvt.index)
###################################################
# Publics and Privates
###################################################

################################
# Dissimilarity Index: County
################################

# create the denominators of the index, i.e. the capital letters
df.schools <- df.schools %>% 
  group_by(COUNTY, YEAR) %>%
  mutate(county.total=sum(NUMSTUDS),
         black.county.total=sum(BLACK),
         white.county.total=sum(WHITE))

df.schools$pct.black.county.lvl <- df.schools$BLACK/df.schools$black.county.total
df.schools$pct.white.county.lvl <- df.schools$WHITE/df.schools$white.county.total
df.schools$pct.diff.county.lvl <- abs(df.schools$pct.black.county.lvl-df.schools$pct.white.county.lvl)
# recode NA's resulting from the above calculations as 0, since that is in fact what the value should be
df.schools[is.na(df.schools)] <- 0

# Create seperate dataset to hold dissimilarity index
# If there should be as many rows as there are counties*years
dissimilarity.county.level <- df.schools %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=0.5*sum(pct.diff.county.lvl))

# Avearge the indexes across counties by year and dismissal
avg.diss.county.both <- dissimilarity.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.diss.county.both$DISMISSED <- as.factor(avg.diss.county.both$DISMISSED)
avg.diss.county.both$YEAR <- as.factor(avg.diss.county.both$YEAR)

# plot
ggplot(avg.diss.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on County
          Level Including Publics and Privates")

################################
# Dissimilarity Index: District
################################

df.schools <- df.schools %>% 
  group_by(DISTRICT, YEAR) %>%
  mutate(district.total=sum(NUMSTUDS),
         black.district.total=sum(BLACK),
         white.district.total=sum(WHITE))

df.schools$pct.black.district.lvl <- df.schools$BLACK/df.schools$black.district.total
df.schools$pct.white.district.lvl <- df.schools$WHITE/df.schools$white.district.total
df.schools$pct.diff.district.lvl <- abs(df.schools$pct.black.district.lvl-df.schools$pct.white.district.lvl)
df.schools[is.na(df.schools)] <- 0

dissimilarity.district.level <- df.schools %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=0.5*sum(pct.diff.district.lvl))

avg.diss.district.both <- dissimilarity.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.diss.district.both$DISMISSED <- as.factor(avg.diss.district.both$DISMISSED)
avg.diss.district.both$YEAR <- as.factor(avg.diss.district.both$YEAR)

ggplot(avg.diss.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on District
          Level Including Publics and Privates")


################################
# Exposure Index: County
################################

df.schools$pct.to.sum <- (df.schools$WHITE/df.schools$NUMSTUDS)*df.schools$BLACK

# partially create exposure index
exp.county.level <- df.schools %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.county.total=sum(BLACK))
exp.county.level[is.na(exp.county.level)] <- 0

# finish calculating exposure index
exp.county.level$county.index <- exp.county.level$county.index/exp.county.level$black.county.total

#values that should be 0 have been coded as NA, so change them to 0
exp.county.level[is.na(exp.county.level)] <- 0

# average exposure across counties by year and dismissal
avg.exp.county.both <- exp.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.exp.county.both$DISMISSED <- as.factor(avg.exp.county.both$DISMISSED)
avg.exp.county.both$YEAR <- as.factor(avg.exp.county.both$YEAR)

# plot
ggplot(avg.exp.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on County
          Level Including Publics and Privates")



################################
# Exposure Index: District
################################

df.schools$pct.to.sum <- (df.schools$WHITE/df.schools$NUMSTUDS)*df.schools$BLACK

exp.district.level <- df.schools %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.district.total=sum(BLACK))
exp.district.level[is.na(exp.district.level)] <- 0
exp.district.level$district.index <- exp.district.level$district.index/exp.district.level$black.district.total
exp.district.level[is.na(exp.district.level)] <- 0


avg.exp.district.both <- exp.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.exp.district.both$DISMISSED <- as.factor(avg.exp.district.both$DISMISSED)
avg.exp.district.both$YEAR <- as.factor(avg.exp.district.both$YEAR)


ggplot(avg.exp.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on District
          Level Including Publics and Privates")




###################################################
# Publics Only
###################################################

################################
# Dissimilarity Index: County
################################

pub.index <- pub.index %>% 
  group_by(COUNTY, YEAR) %>%
  mutate(county.total=sum(NUMSTUDS),
         black.county.total=sum(BLACK),
         white.county.total=sum(WHITE))

pub.index$pct.black.county.lvl <- pub.index$BLACK/pub.index$black.county.total
pub.index$pct.white.county.lvl <- pub.index$WHITE/pub.index$white.county.total
pub.index$pct.diff.county.lvl <- abs(pub.index$pct.black.county.lvl-pub.index$pct.white.county.lvl)
pub.index[is.na(pub.index)] <- 0

dissimilarity.county.level <- pub.index %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=0.5*sum(pct.diff.county.lvl))

avg.diss.county.both <- dissimilarity.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.diss.county.both$DISMISSED <- as.factor(avg.diss.county.both$DISMISSED)
avg.diss.county.both$YEAR <- as.factor(avg.diss.county.both$YEAR)


ggplot(avg.diss.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on County
          Level Including Publics Only")


################################
# Dissimilarity Index: District
################################

pub.index <- pub.index %>% 
  group_by(DISTRICT, YEAR) %>%
  mutate(district.total=sum(NUMSTUDS),
         black.district.total=sum(BLACK),
         white.district.total=sum(WHITE))

pub.index$pct.black.district.lvl <- pub.index$BLACK/pub.index$black.district.total
pub.index$pct.white.district.lvl <- pub.index$WHITE/pub.index$white.district.total
pub.index$pct.diff.district.lvl <- abs(pub.index$pct.black.district.lvl-pub.index$pct.white.district.lvl)
pub.index[is.na(pub.index)] <- 0

dissimilarity.district.level <- pub.index %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=0.5*sum(pct.diff.district.lvl))

avg.diss.district.both <- dissimilarity.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.diss.district.both$DISMISSED <- as.factor(avg.diss.district.both$DISMISSED)
avg.diss.district.both$YEAR <- as.factor(avg.diss.district.both$YEAR)

ggplot(avg.diss.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on District
          Level Including Publics Only")


################################
# Exposure Index: County
################################

pub.index$pct.to.sum <- (pub.index$WHITE/pub.index$NUMSTUDS)*pub.index$BLACK

exp.county.level <- pub.index %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.county.total=sum(BLACK))
exp.county.level[is.na(exp.county.level)] <- 0
exp.county.level$county.index <- exp.county.level$county.index/exp.county.level$black.county.total
exp.county.level[is.na(exp.county.level)] <- 0


avg.exp.county.both <- exp.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.exp.county.both$DISMISSED <- as.factor(avg.exp.county.both$DISMISSED)
avg.exp.county.both$YEAR <- as.factor(avg.exp.county.both$YEAR)


ggplot(avg.exp.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on County
          Level Including Publics Only")

################################
# Exposure Index: District
################################

pub.index$pct.to.sum <- (pub.index$WHITE/pub.index$NUMSTUDS)*pub.index$BLACK

exp.district.level <- pub.index %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.district.total=sum(BLACK))
exp.district.level[is.na(exp.district.level)] <- 0
exp.district.level$district.index <- exp.district.level$district.index/exp.district.level$black.district.total
exp.district.level[is.na(exp.district.level)] <- 0


avg.exp.district.both <- exp.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.exp.district.both$DISMISSED <- as.factor(avg.exp.district.both$DISMISSED)
avg.exp.district.both$YEAR <- as.factor(avg.exp.district.both$YEAR)


ggplot(avg.exp.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on District
          Level Including Publics Only")

###################################################
# Privates Only
###################################################

################################
# Dissimilarity Index: County
################################

pvt.index <- pvt.index %>% 
  group_by(COUNTY, YEAR) %>%
  mutate(county.total=sum(NUMSTUDS),
         black.county.total=sum(BLACK),
         white.county.total=sum(WHITE))

pvt.index$pct.black.county.lvl <- pvt.index$BLACK/pvt.index$black.county.total
pvt.index$pct.white.county.lvl <- pvt.index$WHITE/pvt.index$white.county.total
pvt.index$pct.diff.county.lvl <- abs(pvt.index$pct.black.county.lvl-pvt.index$pct.white.county.lvl)
pvt.index[is.na(pvt.index)] <- 0

dissimilarity.county.level <- pvt.index %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=0.5*sum(pct.diff.county.lvl))

avg.diss.county.both <- dissimilarity.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.diss.county.both$DISMISSED <- as.factor(avg.diss.county.both$DISMISSED)
avg.diss.county.both$YEAR <- as.factor(avg.diss.county.both$YEAR)


ggplot(avg.diss.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on County
          Level Including Privates Only")

################################
# Dissimilarity Index: District
################################

pvt.index <- pvt.index %>% 
  group_by(DISTRICT, YEAR) %>%
  mutate(district.total=sum(NUMSTUDS),
         black.district.total=sum(BLACK),
         white.district.total=sum(WHITE))

pvt.index$pct.black.district.lvl <- pvt.index$BLACK/pvt.index$black.district.total
pvt.index$pct.white.district.lvl <- pvt.index$WHITE/pvt.index$white.district.total
pvt.index$pct.diff.district.lvl <- abs(pvt.index$pct.black.district.lvl-pvt.index$pct.white.district.lvl)
pvt.index[is.na(pvt.index)] <- 0

dissimilarity.district.level <- pvt.index %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=0.5*sum(pct.diff.district.lvl))

avg.diss.district.both <- dissimilarity.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.diss.district.both$DISMISSED <- as.factor(avg.diss.district.both$DISMISSED)
avg.diss.district.both$YEAR <- as.factor(avg.diss.district.both$YEAR)

ggplot(avg.diss.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index by Dismissal Status on District
          Level Including Privates Only")



################################
# Exposure Index: County
################################

pvt.index$pct.to.sum <- (pvt.index$WHITE/pvt.index$NUMSTUDS)*pvt.index$BLACK

exp.county.level <- pvt.index %>% 
  group_by(COUNTY, YEAR, DISMISSED) %>%
  summarise(county.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.county.total=sum(BLACK))
exp.county.level[is.na(exp.county.level)] <- 0
exp.county.level$county.index <- exp.county.level$county.index/exp.county.level$black.county.total
exp.county.level[is.na(exp.county.level)] <- 0


avg.exp.county.both <- exp.county.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.county.index = mean(county.index))
avg.exp.county.both$DISMISSED <- as.factor(avg.exp.county.both$DISMISSED)
avg.exp.county.both$YEAR <- as.factor(avg.exp.county.both$YEAR)


ggplot(avg.exp.county.both, aes(x=YEAR, average.county.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on County
          Level Including Privates Only")

################################
# Exposure Index: District
################################

pvt.index$pct.to.sum <- (pvt.index$WHITE/pvt.index$NUMSTUDS)*pvt.index$BLACK

exp.district.level <- pvt.index %>% 
  group_by(DISTRICT, YEAR, DISMISSED) %>%
  summarise(district.index=sum((WHITE/NUMSTUDS)*BLACK),
            black.district.total=sum(BLACK))
exp.district.level[is.na(exp.district.level)] <- 0
exp.district.level$district.index <- exp.district.level$district.index/exp.district.level$black.district.total
exp.district.level[is.na(exp.district.level)] <- 0


avg.exp.district.both <- exp.district.level %>%
  group_by(YEAR, DISMISSED) %>%
  summarise(average.district.index = mean(district.index))
avg.exp.district.both$DISMISSED <- as.factor(avg.exp.district.both$DISMISSED)
avg.exp.district.both$YEAR <- as.factor(avg.exp.district.both$YEAR)


ggplot(avg.exp.district.both, aes(x=YEAR, average.district.index, group=DISMISSED, color=DISMISSED)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept=5)+
  xlab("Year") +
  ylab("Average Exposure Index")+
  ggtitle("Average Exposure Index by Dismissal Status on District
          Level Including Privates Only")
