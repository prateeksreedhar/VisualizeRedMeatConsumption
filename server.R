library(shiny)

shinyServer(function(input, output) {
  
  # Read input
  Table1 = data.frame(read.csv("data/table1.csv"))
  Table2 = data.frame(read.csv("data/table2.csv"))
  Table4 = data.frame(read.csv("data/table4.csv"))
  RawRedMeatHR = data.frame(read.csv("data/RawRedMeatHR.csv"))
  RawProcessedMeatHR = data.frame(read.csv("data/RawProcessedMeatHR.csv"))
  RawRedProcessedMeatHR = data.frame(read.csv("data/RawRedProcessedMeatHR.csv"))
  RawPoultryHR = data.frame(read.csv("data/RawPoultryHR.csv"))
  RawFishHR = data.frame(read.csv("data/RawFishHR.csv"))
  ScatterData = data.frame(read.csv("data/Scatterplot.csv"))
  NewScatterData = data.frame(read.csv("data/NewScatterplot.csv"))
  
  
  
  # Physical activity at work - Cases Men
  barData = data.frame(Activity = factor(c("No work activity", "Sedentary", "Standing", "Manual")),
                       Percentage = c(42, 26, 16, 15))
  barplot(barData$Percentage, names = barData$Activity, xlab = "Type of labor", ylab = "Percentage of total cases",
          main = "Male Physical Activity Cases", col = c("red", "green", "blue", "yellow"), ylim = c(0, 50))
  barWorkCasesMen = recordPlot()
  
  # Physical activity at work - Non Cases Men
  barData = data.frame(Activity = factor(c("Sedentary", "No work activity", "Standing", "Manual")),
                       Percentage = c(34, 23, 21, 19))
  barplot(barData$Percentage, names = barData$Activity, xlab = "Type of labor", ylab = "Percentage of total non-cases",
          main = "Male Physical Activity Non-Cases", col = c("green", "red", "blue", "yellow"), ylim = c(0, 50))
  barWorkNonCasesMen = recordPlot()
  
  # Physical activity at work - Cases Women
  barData = data.frame(Activity = factor(c("No work activity", "Standing", "Sedentary", "Manual")),
                       Percentage = c(50, 24, 16, 6))
  barplot(barData$Percentage, names = barData$Activity, xlab = "Type of labor", ylab = "Percentage of total cases",
          main = "Female Physical Activity Cases", col = c("red", "blue", "green", "yellow"), ylim = c(0, 50))
  barWorkCasesWomen = recordPlot()
  
  # Physical activity at work - Non Cases Women
  barData = data.frame(Activity = factor(c("No work activity", "Standing", "Sedentary", "Manual")),
                       Percentage = c(30, 28, 22, 7))
  barplot(barData$Percentage, names = barData$Activity, xlab = "Type of labor", ylab = "Percentage of total non-cases",
          main = "Female Physical Activity Non-Cases", col = c("red", "blue", "green", "yellow"), ylim = c(0, 50))
  barWorkNonCasesWomen = recordPlot()
  
  
  
  # Red Meat HR
  plot(ColorectalCancerA ~ GramsPerDay, RawRedMeatHR, ylim = c(1, 1.5), type='l', col='blue',
       xlab="Consumption (g/day)", ylab="Hazard Ratio", main="Red Meat")
  lines(ColorectalCancerB ~ GramsPerDay, RawRedMeatHR, col='red')
  legend("bottomright", c("Measured", "Adjusted"), cex = 1, fill = c("blue", "red"))
  plotRedMeatHR = recordPlot()
  
  # Processed Meat HR
  plot(ColorectalCancerA ~ GramsPerDay, RawProcessedMeatHR, ylim = c(1, 1.5), type='l', col='blue',
       xlab="Consumption (g/day)", ylab="Hazard Ratio", main="Processed Meat")
  lines(ColorectalCancerB ~ GramsPerDay, RawProcessedMeatHR, col='red')
  legend("bottomright", c("Measured", "Adjusted"), cex = 1, fill = c("blue", "red"))
  plotProcessedMeatHR = recordPlot()
  
  # Red and Processed Meat HR
  plot(ColorectalCancerA ~ GramsPerDay, RawRedProcessedMeatHR, ylim=c(0.97, 1.5), type='l', col='blue',
       xlab="Consumption (g/day)", ylab="Hazard Ratio", main="Red and Processed Meat")
  lines(ColorectalCancerB ~ GramsPerDay, RawRedProcessedMeatHR, col='red')
  legend("bottomright", c("Measured", "Adjusted"), cex = 1, fill = c("blue", "red"))
  plotRedProcessedMeatHR = recordPlot()
  
  # Poultry HR
  plot(ColorectalCancerA ~ GramsPerDay, RawPoultryHR, ylim=c(0.5, 1), type='l', col='blue',
       xlab="Consumption (g/day)", ylab="Hazard Ratio", main="Poultry")
  lines(ColorectalCancerB ~ GramsPerDay, RawPoultryHR, col='red')
  legend("bottomright", c("Measured", "Adjusted"), cex = 1, fill = c("blue", "red"))
  plotPoultryHR = recordPlot()
  
  # Fish HR
  plot(ColorectalCancerA ~ GramsPerDay, RawFishHR, ylim=c(0.5, 1), type='l', col='blue',
       xlab="Consumption (g/day)", ylab="Hazard Ratio", main="Fish")
  lines(ColorectalCancerB ~ GramsPerDay, RawFishHR, col='red')
  legend("bottomright", c("Measured", "Adjusted"), cex = 1, fill = c("blue", "red"))
  plotFishHR = recordPlot()

  
  
  # Scatterplot
  plot(CancerPatientPercent ~ MeatConsumption, ScatterData, xlab = "Average Red and Processed Meat Consumption (g/day)",
       ylab = "Colorectal Cancer Patients (% of total)", lty = "solid", lwd = 2, pch = 19, xlim = c(50, 115),
       main = "Correlation between Meat Consumption and Colorectal Cancer")
  text(ScatterData$MeatConsumption, ScatterData$CancerPatientPercent, labels = ScatterData$Country, pos = 4)
  abline(lm(CancerPatientPercent ~ MeatConsumption, NewScatterData), col = "blue")
  plotCorr = recordPlot()
  
  
  # Output slots
  
  # Scatterplot
  output$scatterOne = renderPlot({ plotCorr })
  
  # Data tables
  output$tableOne = renderDataTable({ Table1 })
  output$tableTwo = renderDataTable({ Table2 })
  output$tableFour = renderDataTable({ Table4 })
  
  # Bar charts
  output$barOne = renderPlot({ barWorkCasesMen })
  output$barTwo = renderPlot({ barWorkNonCasesMen })
  output$barThree = renderPlot({ barWorkCasesWomen })
  output$barFour = renderPlot({ barWorkNonCasesWomen })
  
  # Hazard ratio plots
  output$hrOne = renderPlot({ plotRedMeatHR })
  output$hrTwo = renderPlot({ plotProcessedMeatHR })
  output$hrThree = renderPlot({ plotRedProcessedMeatHR })
  output$hrFour = renderPlot({ plotPoultryHR })
  output$hrFive = renderPlot({ plotFishHR })
})