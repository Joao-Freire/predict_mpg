# Predict MPG

library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict MPG"),
  sidebarLayout(
    sidebarPanel(
       radioButtons("cyl","Number of cylinders",choices=c("4","6","8")),
       numericInput("disp","Displacement (cu.in.)",min=50,max=550,value=50,step=1),
       numericInput("hp","Gross horsepower",min=30,max=500,value=30,step=1),
       numericInput("drat","Rear axle ratio",min=2,max=5,value=2,step=0.01),
       numericInput("wt","Weight (1000 lbs)",min=1,max=6.5,value=1,step=0.001),
       numericInput("qsec","1/4 mile time",min=8,max=30,value=8,step=0.01),
       radioButtons("vs","Engine",choices=c("V-shaped","straight")),
       radioButtons("am","Transmission",choices=c("automatic","manual")),
       sliderInput("gear","Number of forward gears",min=3,max=5,value=3,step=1),
       radioButtons("carb","Number of carburetors",choices=c("1","2","3","4","6","8")),
       submitButton("Submit")
    ),
    mainPanel(
            h2("This app uses a predictive algorithm to predict the miles per gallon a car is expected to travel based on 10 variables"),
            tabsetPanel(type="tabs",
                        tabPanel("Miles per gallon prediction",br(),textOutput("pred")),
                        tabPanel("New car comparison plot",br(),plotOutput("plot")),
                        tabPanel("Training data set structure",br(),verbatimTextOutput("td_str")),
                        tabPanel("Instructions",br(),verbatimTextOutput("inst"))
            )
            
    )
  )
))
