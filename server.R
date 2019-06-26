library(shiny)

#model
library(ggplot2)
library(dplyr)

fit <- lm(price ~ carat + cut + color + clarity, data = diamonds)

shinyServer(function(input, output) {
        
        
        #getting data
        newData <- reactive({
                        data.frame(carat = input$carat,
                          cut = input$cut,
                                color = input$color,
                                clarity = input$clarity)
                
        })
        
        # prediction
        pred <- reactive({
                p <- predict(fit, newdata = newData()) 
                p
        })
        
        output$result <- renderText({
                pr <-  pred() %>% round(digits = 2) %>% format(big.mark = ",", nsmall = 2)
                paste0(pr, " USD")})
        
        
        #rendering plot
        output$plot <- renderPlot({
                clr <- diamonds[[input$clr]]
                df <- newData() %>% mutate(prd = predict(fit, newdata = newData()))
                

                g1 <- ggplot(diamonds, aes(carat, price, color = clr)) + 
                        labs(main = "Diamonds plot", xlab = "weight, carats", ylab = "price, USD") +
                        geom_point() +
                        labs(color = clr) +
                        geom_point(aes(as.numeric(df$carat), as.numeric(df$prd)), 
                                color = "red", size = 3, shape = 5, stroke = 3)
                g1
                
        })
        
        
})