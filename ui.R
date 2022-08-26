library(shiny)
library(DT)


ds <- read.csv('credit.csv')

shinyUI(fluidPage(
  tags$head(
    tags$style(HTML("
                    * {
                    font-family: Palatino,garamond,serif;
                    font-weight: 500;
                    line-height: 1.2;
                    #color: #000000;
                    }
                    "))
    ),    
  # App title 
  titlePanel(title="Sampling Methods"),
  
  # Sidebar layout 
  sidebarLayout(
    
    # Sidebar objects
    sidebarPanel(
      
      selectInput(inputId = 'filter', 'Choose a filter', c('--', colnames(ds)[c(6, 7, 8, 9, 10)])), 
      
      conditionalPanel(
        condition = "input.filter == 'Age'",
        radioButtons(inputId = "age", "Select an age group",
                     choices = c("20--40" = '2',
                                 "40--60" = '4',
                                 "60-80" = '6',
                                 "80-100" = '8'),
                     selected = '2')
      ),
      
      
      conditionalPanel(
        condition = "input.filter == 'Education'",
        radioButtons(inputId = "edu", "Select an education level",
                     choices = c("High School" = '1',
                                 "College" = '2',
                                 "Graduate" = '3'),
                     selected = '2')
      ),
      
      
      conditionalPanel(
        condition = "input.filter == 'Gender'",
        radioButtons(inputId = "gender", "Select a gender",
                     choices = c("Female" = 'Female',
                                 "Male" = ' Male'),
                     selected = 'Female')
      ),
      
      
      conditionalPanel(
        condition = "input.filter == 'Married'",
        radioButtons(inputId = "married", "Select a marrital status",
                     choices = c("Yes" = 'Yes',
                                 "No" = 'No'),
                     selected = 'Yes')
      ),
      
      
      conditionalPanel(
        condition = "input.filter == 'Student'",
        radioButtons(inputId = "student", "Select a student status",
                     choices = c("Yes" = 'Yes',
                                 "No" = 'No'),
                     selected = 'Yes')
      ),
      
      
      
      numericInput(inputId = 'n', 'Sample size', '', min = 1, max = 30, step = 1),
      
      actionButton(inputId = "draw", "Draw a sample"),
      
      
      
      # Sidebar width can not exceed 12, default 4.
      width = 4
    ), # end of sidebar panel
    
    # Main panel----
    mainPanel(
      tabsetPanel(
        tabPanel("Population", DT::dataTableOutput("rawTable")
                 ),
        tabPanel("Sample", 
                 htmlOutput("notes"),
                 DT::dataTableOutput("sampleTable")
                 )
        )
        
      
      
      
    ) #end of mainPanel
    
  ) #end of sidebarlayout
  
) #end of fluidpage
)