## Load packages, make sure you had installed the package in your Rstudio
library(tidyverse)
library(lubridate)
library(scales)
library(gt)

# 1. Rebuild the tidy dataset (same pipeline idea as Lab 4)
# Load and pre-define data
data("EuStockMarkets")

## Convert to data frame + time index
eu_tbl <- as.data.frame(EuStockMarkets) |>
  tibble::rownames_to_column(var = "t") |>
  mutate(t = as.integer(t))

## Synthetic date index
start_date <- as.Date("1991-01-01")

## Build tidy long dataset + features
eu <- eu_tbl |>
  mutate(date = start_date + days(t - 1)) |>
  select(date, DAX, SMI, CAC, FTSE) |>
  pivot_longer(cols = c(DAX, SMI, CAC, FTSE), names_to = "index", values_to = "price") |>
  arrange(index, date) |>
  group_by(index) |>
  mutate(
    daily_return = price / lag(price) - 1,
    month = floor_date(date, "month"),
    year = year(date)
  ) |>
  ungroup()

## Focus on DAX for this lab
dax <- eu |> filter(index == "DAX")

# 2. Volatility of DAX (standard deviation of daily returns)
# Interpretation
# Higher standard deviation means returns fluctuate more (more “risk” in a basic sense).

## What pull() does, Extracts a single column from a tibble and Returns it as a plain vector, not a data frame
DAX_vol <- dax |>
  summarise(sd = sd(daily_return, na.rm = TRUE)) |>
  pull(sd)

DAX_vol
## [1] 0.01028088

# 3. Best and worst month for DAX (by average daily return)
# Steps
# Group by month
# Compute average daily return each month
# Pick the highest and lowest months

dax_monthly <- dax |>
  group_by(month) |>
  summarise(avg_daily_return = mean(daily_return, na.rm = TRUE), .groups = "drop")

DAX_best_month <- dax_monthly |>
  arrange(desc(avg_daily_return)) |>
  slice_head(n = 1)

DAX_worst_month <- dax_monthly |>
  arrange(avg_daily_return) |>
  slice_head(n = 1)

DAX_best_month
DAX_worst_month

# 4. Table: Top 30 best daily returns for DAX
dax |>
  filter(!is.na(daily_return)) |>
  arrange(desc(daily_return)) |>
  slice_head(n = 30) |>
  transmute(
    Date = date,
    Price = round(price, 2),
    `Daily Return` = percent(daily_return, accuracy = 0.01)
  ) |>
  gt() |>
  tab_header(title = "DAX — Top 30 Best Daily Returns")

# 5. In class exercise: Top 30 worst daily returns for DAX
 dax |>
   filter(!is.na(daily_return)) |>
   arrange(daily_return) |>
   slice_head(n = 30) |>
   transmute(
     Date = date,
     Price = round(price, 2),
     `Daily Return` = percent(daily_return, accuracy = 0.01)
   ) |>
   gt() |>
   tab_header(title = "DAX — Top 30 Worst Daily Returns")

 # 6. Exercise A
  eu |>
    group_by(index) |>
    summarise(
      start_price = first(price),
      end_price = last(price),
      cum_return = (end_price / start_price) - 1,
      mean_return = mean(daily_return, na.rm = TRUE),
      vol = sd(daily_return, na.rm = TRUE),
      .groups = "drop"
    ) |>
    arrange(desc(cum_return))
  
  #6. Exercise B
  
   eu |>
     group_by(index) |>
     summarise(
       start_price = first(price),
       end_price = last(price),
       cum_return = (end_price / start_price) - 1,
       mean_return = mean(daily_return, na.rm = TRUE),
       vol = sd(daily_return, na.rm = TRUE),
       .groups = "drop"
     ) |>
     arrange(desc(cum_return))
