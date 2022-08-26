#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)



server <- function(input, output){
  
  ds <- read.csv('credit.csv')
  
  
  small <- eventReactive(c(input$filter,
                           input$age,
                           input$edu,
                           input$gender, 
                           input$married, 
                           input$student), {
    out <- ds
    if(input$filter == 'Age'){
      if(input$age == '2'){
        out <- ds[which(ds$Age >= 20 & ds$Age < 40), ]
        }
      else if(input$age == '4'){
        out <- ds[which(ds$Age >= 40 & ds$Age < 60), ]
        }
      else if(input$age == '6'){
        out <- ds[which(ds$Age >= 60 & ds$Age < 80), ]
        }
      else {
        out <- ds[which(ds$Age >= 80 & ds$Age < 100), ] 
        } 
    }else if (input$filter == 'Education'){
      if(input$edu == '1'){
        out <- ds[which(ds$Education <= 12), ]
      }
      else if(input$edu == '2'){
        out <- ds[which(ds$Education > 12 & ds$Education <= 16), ]
      }
      else {
        out <- ds[which(ds$Education > 16), ]
      }
    }else if(input$filter == 'Gender'){
      out <- ds[which(ds$Gender == input$gender),]
    }else if (input$filter == 'Married'){
      out <- ds[which(ds$Married == input$married),]
    }else if (input$filter == 'Student'){
      out <- ds[which(ds$Student == input$student),]
    }
    return(out)
  })
  
  tiny <- eventReactive(input$draw, {
    x <- sample(1:nrow(small()), input$n)
    out <- small()[x, ]
    return(out)
  })
  
     

  # Output: raw data table ----
  output$rawTable <- DT::renderDT({
    datatable(small(), rownames = FALSE, options = list(
      pageLength = 10,
      dom = 'p',
      columnDefs = list(list(className ='dt-center', targets = 0:10))))
  })
  
  output$sampleTable <- DT::renderDT({
    datatable(tiny(), rownames = FALSE, options = list(
      pageLength = 10,
      dom = 'p',
      columnDefs = list(list(className ='dt-center', targets = 0:10))))
  })
  
  output$notes <- renderText({
    out <- paste("<br>","<ul>", 
                 "<li>The total credit limit in this sample is ",
                 "<span style='color:red;'><b>",
                 sprintf('%.0f.', sum(tiny()$Limit)),
                 "</b></span>",
                 "</li>",
                 "</ul>")
    out
  })
  
} #end server
