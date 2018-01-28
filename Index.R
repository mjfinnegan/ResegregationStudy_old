### The percent race variables were originally created by the NCES by computing the inverse of the
### formula below, so this is not any sort of imputation.

dt.clean$WHITE <- round((dt.clean$P_WHITE/100)*dt.clean$NUMSTUDS, 0)
dt.clean$BLACK <- round((dt.clean$P_BLACK/100)*dt.clean$NUMSTUDS, 0)
dt.clean$HISP <- round((dt.clean$P_HISP/100)*dt.clean$NUMSTUDS, 0)
dt.clean$ASIAN <- round((dt.clean$P_ASIAN/100)*dt.clean$NUMSTUDS, 0)
dt.clean$NATIVE <- round((dt.clean$P_NATIVE/100)*dt.clean$NUMSTUDS, 0)

## subset private school data to only what we need
dt.clean <- dt.clean[!dt.clean$YR=='1989']   # drop 1989 and 1991 since no race data
dt.clean <- dt.clean[!dt.clean$YR=='1991']
pvt.index <- dt.clean[, c("PIN",  "YR", "COUNTY", "CITY", "NUMSTUDS", "WHITE", "BLACK")]
pvt.index <- mutate_each(pvt.index, funs(toupper))
pvt.index$COUNTY <- paste(pvt.index$COUNTY, "COUNTY", sep=" ")
pvt.index <- na.omit(pvt.index)
data.table::setnames(pvt.index, 'YR', 'YEAR')

## subset public school data
pub.index <- dt.public[, c("NCESSCH", "YEAR", "CONAME", "CITY", "MEMBER", "WHITE", "BLACK")]
data.table::setnames(pub.index, 'CONAME', 'COUNTY')
data.table::setnames(pub.index, 'NCESSCH', 'PIN')
data.table::setnames(pub.index, 'MEMBER', 'NUMSTUDS')
pub.index <- subset(pub.index, YEAR %in% c(1993,1995, 1997, 1999, 2001,2003,2005,2007,2009,2011,2013)) 
pub.index <- na.omit(pub.index)
pub.index$PIN <- as.character(pub.index$PIN)

# rbind public and private data by county and year
pub.index$PRIVATE <- 0
pvt.index$PRIVATE <- 1
df.schools <- rbind(pub.index, pvt.index)
df.schools$WHITE <- round(as.numeric(df.schools$WHITE),0)
df.schools$BLACK <- round(as.numeric(df.schools$BLACK),0)

df.schools <- df.schools[df.schools$COUNTY!=' COUNTY', ]  # drop privates with no identified county
df.schools$NUMSTUDS <- as.numeric(df.schools$NUMSTUDS)
df.schools$COUNTY <- as.factor(df.schools$COUNTY)
df.schools$YEAR <- as.factor(df.schools$YEAR)
df.schools <- df.schools[!df.schools$YEAR=='2015',]
df.schools <- df.schools[with(df.schools, order(YEAR, COUNTY)),]
df.schools[1588, 3] = "BALDWIN COUNTY"
df.schools[which(grepl("MOBILE COUNTY COUNTY", df.schools$COUNTY)), 3] = "MOBILE COUNTY"
df.schools[which(grepl("TUSCALOOSA COU COUNTY", df.schools$COUNTY)), 3] = "TUSCALOOSA COUNTY"
  
#use mutate for capital letters in index formulas
df.schools <- df.schools %>% 
  group_by(COUNTY, YEAR) %>%
  mutate(county.total=sum(NUMSTUDS),
         black.county.total=sum(BLACK),
         white.county.total=sum(WHITE))

df.schools$pct.black.county.lvl <- df.schools$BLACK/df.schools$black.county.total
df.schools$pct.white.county.lvl <- df.schools$WHITE/df.schools$white.county.total
df.schools$pct.diff.county.lvl <- abs(df.schools$pct.black.county.lvl-df.schools$pct.white.county.lvl)

df.schools[which(grepl("NAn", df.schools$pct.black.county.lvl)), 3] = "TUSCALOOSA COUNTY"
df.schools[is.na(df.schools)] <- 0

dissimilarity.county.level <- df.schools %>% 
  group_by(COUNTY, YEAR) %>%
  summarise(county.index=0.5*sum(pct.diff.county.lvl))

temp <- dissimilarity.county.level %>%
  group_by(YEAR) %>%
  summarise(average.county.index = mean(county.index))
library(ggplot2)
ggplot(temp, aes(x=YEAR, average.county.index, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Average Dissimilarity Index")+
  ggtitle("Average Dissimilarity Index on County
  Level Including Publics and Privates")

