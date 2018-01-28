library(shiny)
library(plyr)
library(dplyr)
library(ggplot2)
privates <- read.csv("privates.csv")
privates$YR <- as.factor(privates$YR)
privates <- privates[,c("YR","NUMSTUDS","STTCH_RT","P_INDIAN", "P_ASIAN", "P_HISP", "P_BLACK", "P_WHITE")]
publics <- read.csv("publics.csv")
publics <- publics[, c("YEAR", "MEMBER", "STTCH_RT", "P_NATIVE", "P_ASIAN", "P_HISP", "P_BLACK", "P_WHITE")]

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Alabama Private Schools"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing type ----
      selectInput("variable", "Choose a variable:", choice= c("Enrollment"=2,
                                                              "Student-Teacher Ratio"=3,
                                                              "Percent Native American"=4,
                                                              "Percent Asian"=5,
                                                              "Percent Hispanic"=6,
                                                              "Percent Black"=7,
                                                              "Percent White"=8)),
      sliderInput("bin", "Select number of bins for histogram", min=5, max=20, value=10),
      
      radioButtons(
        inputId =  "date", 
        label = "Select time period:", 
        choices = c(1993,1995,1997,1999,2001,2003,2005,2007,2009,2011,2013,2015)
      )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Inform the reader about the dataset 
     # p("explanation on what this all is"),
      
      # Output: HTML table with requested number of observations ----
    #  tableOutput("view"),
      
      # Output: Verbatim text for data summary ----
    #  verbatimTextOutput("summary"),
    
      # Output: Boxplot for quick summary
    #  plotOutput("boxplot")
      
      #Output: Time series of enrollment
      plotOutput("hist"),
    
    #Output: Time series of enrollment
    plotOutput("hist2")
      
      #Output: Time series of enrollment
    #  plotOutput("timeseries")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  output$view <- renderTable({
    head(privates, n = input$obs)
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    summary(privates[,as.numeric(input$variable)])
  })
  
  output$boxplot <- renderPlot({
    
    x<-summary(privates[,as.numeric(input$variable)])
    boxplot(x,col="sky blue",border="purple",main=names(privates[as.numeric(input$variable)]))
  })
  
  
  output$hist <- renderPlot({
    dataset <- subset(privates, privates$YR == input$date)
    colm <- as.numeric(input$variable)
    hist(dataset[,colm], main="Histogram of Private Schools", 
         #breaks=seq(0, max(dataset[,colm]),l=input$bin+1), 
         xlab=names(dataset[colm]))
  })
  
  output$hist2 <- renderPlot({
    dataset2 <- subset(publics, publics$YEAR == input$date)
    colm2 <- as.numeric(input$variable)
    hist(dataset2[,colm2], main="Histogram of Public Schools", 
        # breaks=seq(0, max(dataset2[,colm2]),l=input$bin+1), 
         xlab=names(dataset2[colm2]))
  })
  
}

# Run app ----
shinyApp(ui, server)