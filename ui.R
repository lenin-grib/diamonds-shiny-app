library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(navbarPage(
        title = "",
        windowTitle = "Diamond price prediction tool",
        tabPanel(
                "The App",
                fluidPage(
                        titlePanel(title = "Diamond price prediction tool"),
                        hr(),
                        sidebarLayout(
                                sidebarPanel(
                                        h4(em("Choose the parameters of your diamond below")),
                                        hr(),
                                        sliderInput("carat", label = "weight in carat", min = 0.1, 
                                                max = 6, value = 1.5, step = 0.1),
                                        radioButtons("cut", label = "Choose cut",
                                                choices = list("Fair", "Good", "Very Good","Premium", "Ideal"), 
                                                selected = "Good", inline = TRUE),
                                        selectInput("color", label = "Choose color",
                                                choices = list("J (worst)" = "J",
                                                        "I","H","G","F","E",
                                                        "D (best)" = "D"), 
                                                selected = "D"),
                                        selectInput("clarity", label = "Choose clarity",
                                                choices = list("I1 (worst)" = "I1", "SI1", 
                                                        "SI2", "VS1", "VS2", "VVS1",
                                                        "VVS2", "IF (best)" = "IF"), 
                                                selected = "IF"),
                                        submitButton("submit")
                                        ),
                                mainPanel(
                                        h4("Predicted price of the diamond is"),
                                        h3(textOutput("result")),
                                        br(),
                                        plotOutput("plot"),
                                        absolutePanel(
                                                bottom = 20, right = 120, width = 350,
                                                draggable = TRUE,
                                                style = "opacity: 0.8",
                                                wellPanel(
                                                        div(style="display: inline-block;vertical-align:top; width: 80px;",
                                                                selectInput("clr", label = "colour by", 
                                                                        choices = colnames(diamonds[c(2:4)]),
                                                                        selected = colnames(diamonds)[2])
                                                        )
                                                        
                                                )
                                        )
                                        
                                )   
                        )
                )
                ),
        tabPanel(
                "How to use the app",
                fluidPage(
                        fluidRow(
                                column(
                                        10,
                                        wellPanel(
                                                helpText("The app uses diamonds dataser from the package ggplot2"),
                                                helpText("You can adjust 4 parameters: weights, colour, cut quality
                                                        and a clarity to predict price of such a diamond in USD"),
                                                helpText("App will fit a linear model and display the estimated price for you"),
                                                helpText("The result of predicted price will be dispayed in USD 
                                                        in the middle of the page."),
                                                helpText("In the top right corner you will see an approximate size 
                                                        of your diamond (basing on the chosen carat). Don't hope 
                                                        too much, it's really approximate and just for fun :)"),
                                                helpText("You can also play with the plot visualizing the global 'Diamonds' dataset.
                                                        Check out the draggable window letting you choose the axes of the plot!"),
                                                helpText(
                                                        "Now go ahead! ", span("Switch to the App at the top of 
                                                                the page", style = "color:blue")," and calculate your diamond price!"),
                                                helpText(
                                                        style="text-align: right;",
                                                        "Any comments and contribution are welcome on", 
                                                        a("GitHub",
                                                                href = "https://github.com/t0tem/DevDataProd_Assignment3", 
                                                                target="_blank")
                                                )
                                        )
                                )
                        )
                )
                
               
        )
        )
)
