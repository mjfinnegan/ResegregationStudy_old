#Import median household income data for Birmingham
library(readr)
raw_ACS_data <- read_csv("~/Documents/Github/BirminghamGentrification/ACS_15_1YR_S1903_with_ann.csv")

library(readxl)
Bham_Median_HH_Income <- read_excel("~/Documents/Github/BirminghamGentrification/Bham_Median_HH_Income.xlsx")
Bham_MarginofError <- read_excel("~/Documents/Github/BirminghamGentrification/Bham_Median_HH_Income_MarginofError.xlsx")

install.packages("ggplot2")
library(ggplot2)

Bham_Median_HH_Income$Year <- as.factor(Bham_Median_HH_Income$Year)

#Plot bar chart Overall Household Income for Birmingham-Hoover MSA
ggplot(Bham_Median_HH_Income, aes(x=Year,`Overall Households`)) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Median Household Income")

#Plot same as above with line chart
ggplot(Bham_Median_HH_Income, aes(x=Year,`Overall Households`, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Median Household Income")
  
#Plot Median Household Income for Ethnicity
ggplot(Bham_Median_HH_Income, aes(x=Year, group=1)) +
  geom_line(aes(y=`Overall Households`, colour="Overall")) +
  geom_line(aes(y=`Race: white`, colour="White")) +
  geom_line(aes(y=`Race: black`, colour="Black")) +
  geom_line(aes(y=`Race: hispanic`, colour="Hispanic")) +
  scale_colour_manual("", 
    values = c("Overall"="black", "White"="green", 
    "Black"="blue", "Hispanic"="purple")) +
  xlab("Year") +
  ylab("Median Household Income") +
  ggtitle("Birmingham-Hoover MSA Median Household Income by Race")
  
#Plot Median Household Income for Age
ggplot(Bham_Median_HH_Income, aes(x=Year, group=1)) +
  geom_line(aes(y=`Overall Households`, colour="Overall")) +
  geom_line(aes(y=`Age: 15 to 24 years`, colour="15-24")) +
  geom_line(aes(y=`Age: 25 to 44 years`, colour="25-44")) +
  geom_line(aes(y=`Age: 45 to 64 years`, colour="45-64")) +
  geom_line(aes(y=`Age: 65 years and over`, colour="65+")) +
  scale_colour_manual("", 
    values = c("Overall"="black", "15-24"="green", 
      "25-44"="blue", "45-64"="purple",
      "65+"="red")) +
  xlab("Year") +
  ylab("Median Household Income") +
  ggtitle("Birmingham-Hoover MSA Median Household Income by Age")


#Begin work with tidycensus
install.packages("tidycensus")
install.packages("tidyverse")
library("tidycensus")
library("tidyverse")
library("leaflet")
library("sf")
library("stringr")
library("viridis")
library("viridisLite")

census_api_key("c2d75e7e54dd23544e0d77f8d8b98819f00ccbb3", install=TRUE)
readRenviron("~/.Renviron")

Jeff_home_value <- get_acs(geography = "tract", 
                     variables = "B25077_001", 
                     state = "AL",
                     county = "Jefferson County",
                     geometry = TRUE)

pal <- colorNumeric(palette = "viridis", 
                    domain = Jeff_home_value$estimate)

Jeff_home_value %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(NAME, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "Median Home Value",
            labFormat = labelFormat(prefix = "$"),
            opacity = 1)

v15 <- load_variables(2015, "acs5", cache = TRUE)
View(v15)

Jeff_HH_income10 <- get_acs(geography = "tract", 
                           variables = "B19013_001E",
                           endyear=2010,
                           state = "AL",
                           county = "Jefferson County",
                           geometry = TRUE)

pal <- colorNumeric(palette = "viridis", 
                    domain = Jeff_HH_income10$estimate)

Jeff_HH_income10 %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(estimate, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "2010 Median Household Income",
            labFormat = labelFormat(prefix = "$"),
            opacity = 1)

Jeff_HH_income15 <- get_acs(geography = "tract", 
                          variables = "B19013_001E",
                          endyear=2015,
                          state = "AL",
                          county = "Jefferson County",
                          geometry = TRUE)

pal <- colorNumeric(palette = "viridis", 
                    domain = Jeff_HH_income15$estimate)

Jeff_HH_income15 %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(estimate, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "2015 Median Household Income",
            labFormat = labelFormat(prefix = "$"),
            opacity = 1)


#comptute percentage change from 2010 to 2015

#sort tables for computation
Jeff_HH_income10 <- Jeff_HH_income10[order(Jeff_HH_income10$GEOID),]
Jeff_HH_income15 <- Jeff_HH_income15[order(Jeff_HH_income15$GEOID),]

#compute percentage change
Jeff_HH_income15$estimate2010 <- Jeff_HH_income10$estimate
Jeff_HH_income15$percent_change <- ((Jeff_HH_income15$estimate -
                     Jeff_HH_income15$estimate2010)/Jeff_HH_income15$estimate2010)*100

#check to make sure geometry column is of object class "sf" in order for
#st_transform to be able to map coordinates to map
class(Jeff_HH_income15)
#checks out okay

#create map of percentage change in median household income values
#from 2010 to 2015
pal <- colorNumeric(palette = "viridis", 
                    domain = Jeff_HH_income15$percent_change)

Jeff_HH_income15 %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(percent_change, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(percent_change)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ percent_change,
            title = "Percentage Change Median Household Income",
            labFormat = labelFormat(prefix = "%"),
            opacity = 1)

#Interest. Growing neighbordhoods like Avondale, Highland park,
#and 1st Ave North have positive percentage change.
#Meanwhile, each of these neighborhoods has an adjacent neighborhood that has
#experience a strong negetive percentage change.These neighborhoods are 
#primarily Oak Ridge Park, Graymont, and Irondale.



Jeff_wages15 <- get_acs(geography = "tract", 
                           variables = "B19052_001E", 
                           endyear=2015,
                           state = "AL",
                           county = "Jefferson County",
                           geometry = TRUE)
View(Jeff_wages15)

pal <- colorNumeric(palette = "viridis", 
                    domain = Jeff_wages15$estimate)

Jeff_wages15 %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(estimate, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "2015 Wages",
            labFormat = labelFormat(prefix = "$"),
            opacity = 1)

#Transition to QCEW analysis

library(blsAPI)
Q4Y16 <- blsQCEW('Area', year='2016', quarter='4', area='01073')
#NAICS codes:
#all- 10 & own_code=5
#breweries- 31212
#restaurants and bars-722 & own_code=5

#For Q4Y16i
Q4Y16 <- blsQCEW('Area', year='2016', quarter='4', area='01073')
Q4Y16i <- rbind(
  subset(Q4Y16, industry_code==10 & own_code==5),
  subset(Q4Y16, industry_code==31212),
  subset(Q4Y16, industry_code==722 & own_code==5),
  subset(Q4Y16, industry_code==72233 & own_code==5))

#For Q3Y16i
Q3Y16 <- blsQCEW('Area', year='2016', quarter='3', area='01073')
Q3Y16i <- rbind(
            subset(Q3Y16, industry_code==10 & own_code==5),
            subset(Q3Y16, industry_code==31212),
            subset(Q3Y16, industry_code==722 & own_code==5),
            subset(Q3Y16, industry_code==72233 & own_code==5))

#For Q2Y16i
Q2Y16 <- blsQCEW('Area', year='2016', quarter='2', area='01073')
Q2Y16i <- rbind(
  subset(Q2Y16, industry_code==10 & own_code==5),
  subset(Q2Y16, industry_code==31212),
  subset(Q2Y16, industry_code==722 & own_code==5),
  subset(Q2Y16, industry_code==72233 & own_code==5))

Q4Y16 <- blsQCEW('Area', year='2016', quarter='4', area='01073')
Q3Y16 <- blsQCEW('Area', year='2016', quarter='3', area='01073')
Q2Y16 <- blsQCEW('Area', year='2016', quarter='2', area='01073')
Q1Y16 <- blsQCEW('Area', year='2016', quarter='1', area='01073')

#For Q1Y16i
Q1Y16i <- rbind(
        subset(Q1Y16, industry_code==10 & own_code==5),
        subset(Q1Y16, industry_code==31212),
        subset(Q1Y16, industry_code==722 & own_code==5),
        subset(Q1Y16, industry_code==72233 & own_code==5))
y16i <- rbind(Q4Y16i,Q3Y16i,Q2Y16i,Q1Y16i)

Q4Y15 <- blsQCEW('Area', year='2015', quarter='4', area='01073')
Q3Y15 <- blsQCEW('Area', year='2015', quarter='3', area='01073')
Q2Y15 <- blsQCEW('Area', year='2015', quarter='2', area='01073')
Q1Y15 <- blsQCEW('Area', year='2015', quarter='1', area='01073')

Q4Y15i <- rbind(
  subset(Q4Y15, industry_code==10 & own_code==5),
  subset(Q4Y15, industry_code==31212),
  subset(Q4Y15, industry_code==722 & own_code==5),
  subset(Q4Y15, industry_code==72233 & own_code==5))
Q3Y15i <- rbind(
  subset(Q3Y15, industry_code==10 & own_code==5),
  subset(Q3Y15, industry_code==31212),
  subset(Q3Y15, industry_code==722 & own_code==5),
  subset(Q3Y15, industry_code==72233 & own_code==5))
Q2Y15i <- rbind(
  subset(Q2Y15, industry_code==10 & own_code==5),
  subset(Q2Y15, industry_code==31212),
  subset(Q2Y15, industry_code==722 & own_code==5),
  subset(Q2Y15, industry_code==72233 & own_code==5))
Q1Y15i <- rbind(
  subset(Q1Y15, industry_code==10 & own_code==5),
  subset(Q1Y15, industry_code==31212),
  subset(Q1Y15, industry_code==722 & own_code==5),
  subset(Q1Y15, industry_code==72233 & own_code==5))
y15i <- rbind(Q4Y15i,Q3Y15i,Q2Y15i,Q1Y15i)



Q4Y14 <- blsQCEW('Area', year='2014', quarter='4', area='01073')
Q3Y14 <- blsQCEW('Area', year='2014', quarter='3', area='01073')
Q2Y14 <- blsQCEW('Area', year='2014', quarter='2', area='01073')
Q1Y14 <- blsQCEW('Area', year='2014', quarter='1', area='01073')

Q4Y14i <- rbind(
  subset(Q4Y14, industry_code==10 & own_code==5),
  subset(Q4Y14, industry_code==31212),
  subset(Q4Y14, industry_code==722 & own_code==5),
  subset(Q4Y14, industry_code==72233 & own_code==5))
Q3Y14i <- rbind(
  subset(Q3Y14, industry_code==10 & own_code==5),
  subset(Q3Y14, industry_code==31212),
  subset(Q3Y14, industry_code==722 & own_code==5),
  subset(Q3Y14, industry_code==72233 & own_code==5))
Q2Y14i <- rbind(
  subset(Q2Y14, industry_code==10 & own_code==5),
  subset(Q2Y14, industry_code==31212),
  subset(Q2Y14, industry_code==722 & own_code==5),
  subset(Q2Y14, industry_code==72233 & own_code==5))
Q1Y14i <- rbind(
  subset(Q1Y14, industry_code==10 & own_code==5),
  subset(Q1Y14, industry_code==31212),
  subset(Q1Y14, industry_code==722 & own_code==5),
  subset(Q1Y14, industry_code==72233 & own_code==5))
y14i <- rbind(Q4Y14i,Q3Y14i,Q2Y14i,Q1Y14i)

Q4Y13 <- blsQCEW('Area', year='2013', quarter='4', area='01073')
Q3Y13 <- blsQCEW('Area', year='2013', quarter='3', area='01073')
Q2Y13 <- blsQCEW('Area', year='2013', quarter='2', area='01073')
Q1Y13 <- blsQCEW('Area', year='2013', quarter='1', area='01073')

Q4Y13i <- rbind(
  subset(Q4Y13, industry_code==10 & own_code==5),
  subset(Q4Y13, industry_code==31212),
  subset(Q4Y13, industry_code==722 & own_code==5),
  subset(Q4Y13, industry_code==72233 & own_code==5))
Q3Y13i <- rbind(
  subset(Q3Y13, industry_code==10 & own_code==5),
  subset(Q3Y13, industry_code==31212),
  subset(Q3Y13, industry_code==722 & own_code==5),
  subset(Q3Y13, industry_code==72233 & own_code==5))
Q2Y13i <- rbind(
  subset(Q2Y13, industry_code==10 & own_code==5),
  subset(Q2Y13, industry_code==31212),
  subset(Q2Y13, industry_code==722 & own_code==5),
  subset(Q2Y13, industry_code==72233 & own_code==5))
Q1Y13i <- rbind(
  subset(Q1Y13, industry_code==10 & own_code==5),
  subset(Q1Y13, industry_code==31212),
  subset(Q1Y13, industry_code==722 & own_code==5),
  subset(Q1Y13, industry_code==72233 & own_code==5))
y13i <- rbind(Q4Y13i,Q3Y13i,Q2Y13i,Q1Y13i)

Q4Y12 <- blsQCEW('Area', year='2012', quarter='4', area='01073')
Q3Y12 <- blsQCEW('Area', year='2012', quarter='3', area='01073')
Q2Y12 <- blsQCEW('Area', year='2012', quarter='2', area='01073')
Q1Y12 <- blsQCEW('Area', year='2012', quarter='1', area='01073')

Q4Y12i <- rbind(
  subset(Q4Y12, industry_code==10 & own_code==5),
  subset(Q4Y12, industry_code==31212),
  subset(Q4Y12, industry_code==722 & own_code==5),
  subset(Q4Y12, industry_code==72233 & own_code==5))
Q3Y12i <- rbind(
  subset(Q3Y12, industry_code==10 & own_code==5),
  subset(Q3Y12, industry_code==31212),
  subset(Q3Y12, industry_code==722 & own_code==5),
  subset(Q3Y12, industry_code==72233 & own_code==5))
Q2Y12i <- rbind(
  subset(Q2Y12, industry_code==10 & own_code==5),
  subset(Q2Y12, industry_code==31212),
  subset(Q2Y12, industry_code==722 & own_code==5),
  subset(Q2Y12, industry_code==72233 & own_code==5))
Q1Y12i <- rbind(
  subset(Q1Y12, industry_code==10 & own_code==5),
  subset(Q1Y12, industry_code==31212),
  subset(Q1Y12, industry_code==722 & own_code==5),
  subset(Q1Y12, industry_code==72233 & own_code==5))
y12i <- rbind(Q4Y12i,Q3Y12i,Q2Y12i,Q1Y12i)

#Data only available until 2012

Jeff_county_qcew <- rbind(y16i, y15i, y14i, y13i, y12i)
drops <- c("agglvl_code", "size_code", "disclosure_code", "lq_disclosure_code", "oty_disclosure_code")
Jeff_county_qcew <- Jeff_county_qcew[ , !(names(Jeff_county_qcew) %in% drops)]
Jeff_county_qcew$yearqtr <- paste(Jeff_county_qcew$year,Jeff_county_qcew$qtr, sep="-")
View(Jeff_county_qcew)

#Begin data analysis on Jeff_county_qcew
all <- subset(Jeff_county_qcew, industry_code=="10")
fooddrink <- subset(Jeff_county_qcew, industry_code=="722")
brewery <- subset(Jeff_county_qcew, industry_code=="31212")

ggplot(all, aes(x=yearqtr,qtrly_estabs, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("# of establishments") +
ggtitle("All Private Establishments in Jefferson County")

ggplot(fooddrink, aes(x=yearqtr,qtrly_estabs, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("# of establishments") +
  ggtitle("All Private Restaurants and Bars in Jefferson County")

ggplot(brewery, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=qtrly_estabs, colour="Establishments")) +
  geom_line(aes(y=oty_total_qtrly_wages_pct_chg, colour="Brewery wages % chg")) +
  scale_colour_manual("", 
                      values = c("Establishments"="black", "Brewery wages % chg"="red")) +
  xlab("Year") +
  ylab("# of establishments") +
  ggtitle("All Private Breweries in Jefferson County")

print(brewery$oty_total_qtrly_wages_pct_chg)

#Look at fast-moving industries
Y16a <- blsQCEW('Area', year='2016', quarter='a', area='01073')
#Food trucks are amongst the fastest growing industries
foodtruck <- subset(Jeff_county_qcew, industry_code=="72233")

ggplot(foodtruck, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=qtrly_estabs)) +
  xlab("Year") +
  ylab("# of establishments") +
  ggtitle("All Food Trucks in Jefferson County")

foodtruck$brewery_qtrly_estabs <-brewery$qtrly_estabs

ggplot(foodtruck, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=qtrly_estabs, colour="Food Trucks")) +
  geom_line(aes(y=brewery_qtrly_estabs, colour="Breweries")) +
  scale_colour_manual("", 
                      values = c("Food Trucks"="black", "Breweries"="red")) +
  xlab("Year") +
  ylab("# of establishments") +
  ggtitle("All Private Breweries & Food Trucks in Jefferson County")
#Possible relationship between breweries and food trucks
#There is literally an interaction between them since the food trucks park
#Right outside or even inside the breweries
cor.test(foodtruck$qtrly_estabs, brewery$qtrly_estabs)

#Look at wages
ggplot(brewery, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=total_qtrly_wages)) +
  xlab("Year") +
  ylab("Wages") +
  ggtitle("Brewery Wages in Jefferson County")

ggplot(foodtruck, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=total_qtrly_wages)) +
  xlab("Year") +
  ylab("Wages") +
  ggtitle("Food Truck Wages in Jefferson County")

ggplot(fooddrink, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=oty_total_qtrly_wages_pct_chg)) +
  xlab("Year") +
  ylab("Percent Change in Wages") +
  ggtitle("Restaurant & Bars Wages in Jefferson County")

ggplot(fooddrink, aes(x=yearqtr, group=1)) +
  geom_line(aes(y=total_qtrly_wages)) +
  xlab("Year") +
  ylab("Total Wages") +
  ggtitle("Restaurant & Bars Wages in Jefferson County")

library(pipeR)
library(readr)
library(lubridate)


plot1 <- fooddrink %>>% ggplot() + 
  geom_bar(mapping = aes(x = yearqtr, y = oty_qtrly_estabs_pct_chg),
          stat = "identity") + 
  #geom_point(mapping = aes(x = yearqtr, y = total_qtrly_wages)) + 
  geom_line(mapping = aes(x = yearqtr, y = oty_total_qtrly_wages_pct_chg, group=1)) + 
  scale_y_continuous(name = expression("Percent Change in Quarterly Establishments"),
                     limits = c(-2, 10))
plot2 <- plot1 %+% scale_y_continuous(name = 
                    expression("Percent Change in Quarterly Establishments"), 
                    sec.axis = sec_axis(~ ., 
                        name = "Percent Change in Wages"), limits = c(-2, 10))+
                  labs(title="Restaurants and Bars:",
                       subtitle="Establishments and Wages")
plot2

fooddrink$oty_avg_emplvl_pct_chg <- rowMeans(subset(fooddrink, select = 
                                    c(oty_month1_emplvl_pct_chg,
                                      oty_month2_emplvl_pct_chg,
                                      oty_month3_emplvl_pct_chg)))

plo3 <- fooddrink %>>% ggplot() + 
  geom_bar(mapping = aes(x = yearqtr, y = oty_avg_emplvl_pct_chg), stat="identity") + 
  geom_point(mapping = aes(x = yearqtr, y = oty_total_qtrly_wages_pct_chg)) + 
  geom_line(mapping = aes(x = yearqtr, y = oty_total_qtrly_wages_pct_chg, group=1)) + 
  scale_y_continuous(name = expression("Percent Change in Average Employment"),
                     limits = c(-2, 10))
plot4 <- plo3 %+% scale_y_continuous(name = 
                                       expression("Percent Change in Average Employment"), 
                                     sec.axis = sec_axis(~ ., 
                                                         name = "Percent Change Wages"), limits = c(-2, 10))+
  labs(title="Restaurants and Bars:",
       subtitle="Employment and Wages")
plot4
#Could proceed with accounting for seasonality with the stl function in
#the loess package
  
