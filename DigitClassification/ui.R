library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cosmo"),
                  headerPanel('Pen-Based Handwritten Digit Recognition using K-Means Clustering'),
                  sidebarPanel(      
                    selectInput('xcol', 'X Variable', names(train_nodig)),
                    selectInput('ycol', 'Y Variable', names(train_nodig),
                                selected=names(train_nodig)[[2]]),
                    
                    sliderInput("clusters",
                                "Number of clusters:",
                                min = 1,
                                max = 10,
                                value = 4)
                  ),
                  mainPanel(
                    p("Digit database by collecting 250 samples from 44 writers. Digits represented as constant length feature vectors. 
                      Temporal resampling (points regularly spaced in time) or spatial resampling (points regularly spaced in arc length) can be used here"),
                    strong("References and Detailed Information"),
                    p("https://archive.ics.uci.edu/ml/datasets/Pen-Based+Recognition+of+Handwritten+Digits"),
                    plotOutput('plot1'),
                    plotOutput('plot2')
                  )
))