library(ggplot2)
library(fpp2)
library(ggthemes)
library(forecast)
library(GGally) 
library(gridExtra)

# Set working directory (directory path has been removed for privacy reasons)
setwd("*****")

# Read in CSV file
nba_df <- read.csv("NbaThreePointStatsCSV.csv")

# View data
nba_df

# Create ts object for total 3PM
NbaTotalThrees_ts <- ts(nba_df$Total3PM, start=1979)

# Plot nba three pointers over time
autoplot(NbaTotalThrees_ts) + 
  ggtitle("Total Three Pointers Made in NBA Season") +
  ylab("# Three Pointers")

# Create ts object for Avg 3PM
NbaAvgThrees_ts <- ts(nba_df$Avg3PM, start=1979)

# Plot avg nba three pointers over time
autoplot(NbaAvgThrees_ts) + 
  ggtitle("Avg Three Pointers Made by Team in NBA Season") +
  ylab("# Three Pointers")

# Create ts object for Avg Percent
NbaAvgPercent_ts <- ts(nba_df$AvgPercent, start=1979)

# Plot nba three point percentage over time
autoplot(NbaAvgPercent_ts) + 
  ggtitle("Avg Three Pointer Percentage Made in NBA Season") +
  ylab("Avg Percentage")

# Show all three plots on one grid
x <- autoplot(NbaTotalThrees_ts) + 
  ggtitle("Total Three Pointers Made in NBA Season") +
  ylab("# Three Pointers")
y <- autoplot(NbaAvgThrees_ts) + 
  ggtitle("Avg Three Pointers Made by Team in NBA Season") +
  ylab("# Three Pointers")
z <- autoplot(NbaAvgPercent_ts) + 
  ggtitle("Avg Three Pointer Percentage Made in NBA Season") +
  ylab("Avg Percentage")
grid.arrange(x, y, z, nrow = 1)

# ARIMA forecast
arima <- auto.arima(NbaTotalThrees_ts, seasonal=FALSE, stepwise=FALSE, approximation=FALSE)
fc_arima <- forecast(arima, h=5)
fc_arima
autoplot(fc_arima) + 
  ggtitle("Total Three Pointers Made in NBA Season") +
  ylab("# Three Pointers")
summary(arima)
checkresiduals(arima)