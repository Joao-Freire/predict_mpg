# Predict MPG

library(shiny)

shinyServer(function(input, output) {
        model <- lm(mpg~as.factor(cyl)+disp+hp+drat+wt+qsec+
                            as.factor(vs)+as.factor(am)+gear+carb,data=mtcars)
        
        model_pred <- reactive({
                cyl_input <- as.factor(input$cyl)
                disp_input <- input$disp
                hp_input <- input$hp
                drat_input <- input$drat
                wt_input <- input$wt
                qsec_input <- input$qsec
                vs_input <- as.factor(ifelse(input$vs=="V-shaped",0,1))
                am_input <- as.factor(ifelse(input$am=="automatic",0,1))
                gear_input <- input$gear
                carb_input <- as.numeric(input$carb)
                
                new_car_data <- data.frame(
                        cyl=cyl_input,
                        disp=disp_input,
                        hp=hp_input,
                        drat=drat_input,
                        wt=wt_input,
                        qsec=qsec_input,
                        vs=vs_input,
                        am=am_input,
                        gear=gear_input,
                        carb=carb_input)
                
                predict(model,newdata=new_car_data,interval="prediction")[1]
        })
        
        output$pred <- renderPrint({
                cat("The new car is expected to travel",round(model_pred(),1),"miles per gallon.")
        })
        
        output$plot <- renderPlot({
                cyl_input <- as.factor(input$cyl)
                disp_input <- input$disp
                hp_input <- input$hp
                drat_input <- input$drat
                wt_input <- input$wt
                qsec_input <- input$qsec
                vs_input <- as.factor(ifelse(input$vs=="V-shaped",0,1))
                am_input <- as.factor(ifelse(input$am=="automatic",0,1))
                gear_input <- input$gear
                carb_input <- as.numeric(input$carb)
                
                new_car_data <- data.frame(
                        cyl=cyl_input,
                        disp=disp_input,
                        hp=hp_input,
                        drat=drat_input,
                        wt=wt_input,
                        qsec=qsec_input,
                        vs=vs_input,
                        am=am_input,
                        gear=gear_input,
                        carb=carb_input)
                
                new_car_data_1 <- cbind(mpg=round(model_pred(),1),new_car_data)
                mtcars_1 <- rbind(mtcars,"New car"=new_car_data_1)
                par(mar=c(7,4,1,3),oma=c(2,2,2,2))
                col_1 <- c("lightblue", "red")[(row.names(mtcars_1)=="New car") + 1]
                
                barplot(mtcars_1$mpg,main="New car compared to the cars in the training data set",
                        ylab="Miles per gallon",xlim=c(1,37),ylim=c(0,50),
                        names.arg=row.names(mtcars_1),las=2,cex.names=1,col=col_1)
        })
        
        output$td_str <- renderPrint({
                str(mtcars)
        })
        
        output$inst <- renderPrint({
                cat(" 1: Select and introduce the values of the new car for the 10 variables",
                    "\n 2: Click on the 'Submit' button",
                    "\n 3: The predicted MPG value shows up in the 'Miles per gallon prediction' tab",
                    "\n 4: See how the predicted MPG of the new car compares to the MPG of the cars in the training data set \n    in the 'New car comparison plot' tab")
        })
})
