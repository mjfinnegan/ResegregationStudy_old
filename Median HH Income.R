#Import median household income data for Birmingham
library(readr)
raw_ACS_data <- read_csv("~/Documents/Data/Birmingham/Birmingham/ACS_15_1YR_S1903_with_ann.csv")
View(median_household_income)

library(readxl)
Bham_Median_HH_Income <- read_excel("~/Documents/Data/Birmingham/Birmingham/Bham_Median_HH_Income.xlsx")
View(Bham_Median_HH_Income)
Bham_MarginofError <- read_excel("~/Documents/Data/Birmingham/Birmingham/Bham_Median_HH_Income_MarginofError.xlsx")
View(Bham_MarginofError)

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

census_api_key("c2d75e7e54dd23544e0d77f8d8b98819f00ccbb3", install=TRUE)
readRenviron("~/.Renviron")

m2015 <- get_acs(geography = "county", variables = "B01003_001",
                 state="AL", geometry=TRUE)
m2015

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

#do same for year 200 using decennial survey
#comptute percentage change from 2010 to 2015

Jeff_HH_income10$Year <- 2010
Jeff_HH_income15$Year <- 2015
Jeff_HH_income_facet <- rbind.data.frame(Jeff_HH_income10,
                                         Jeff_HH_income15)


