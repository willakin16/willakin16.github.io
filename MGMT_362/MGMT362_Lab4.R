## Load packages, make sure you had installed the package in your Rstudio
library(tidyverse)
library(lubridate)
library(scales)

## Load the dataset
data("EuStockMarkets")

## Inspect structure
class(EuStockMarkets)

head(EuStockMarkets)

## Convert to data frame and create a numeric time index t
## rownames are "1", "2", ... for this ts object, so we convert them to integer

## Syntax notation
### |> is the base R pipe, built into R (no package). Similar to %>%, you could replace |> to %>% in our case.
### The :: operator means: “Use this function from this specific package.”

# pipe operator %>% #first part output, plug into following part as input
# base R pip |>
print("MGMT362")
"MGMT362" %>% print()
"MGMT362" |> print()
# ^All 3 the same^

# 2 Convert the ts object into a data frame
eu_tbl <- as.data.frame(EuStockMarkets) |>
  tibble::rownames_to_column(var = "t") |>
  mutate(t = as.integer(t))

head(eu_tbl)

# 3 Create a synthetic data variable
## Choose a start date (synthetic)
start_date <- as.Date("1991-01-01")

## Create a date column by adding (t - 1) days to start_date
eu_tbl_dates <- eu_tbl |>
  mutate(date = start_date + days(t - 1)) |>
  select(date, DAX, SMI, CAC, FTSE)

head(eu_tbl_dates)

# 4. Reshape from wide to long (tidy) format
## Pivot the 4 index columns into:
##  index: the name of the stock index (DAX/SMI/CAC/FTSE)
##  price: the value
eu_long <- eu_tbl_dates |>
  pivot_longer(
    cols = c(DAX, SMI, CAC, FTSE),
    names_to = "index", # condensed cols to index
    values_to = "price"
  ) |>
  arrange(index, date)

head(eu_long)

# 5. Feature engineering with grouped operations
## If we don't ungroup data, usually rank would be computed within each group and this is not actually what we need.
eu <- eu_long |>
  group_by(index) |>
  mutate(
    daily_return = price / lag(price) - 1,
    month = floor_date(date, "month"),
    year = year(date)
  ) |>
  ungroup()

## Preview a few rows for DAX
eu |>
  filter(index == "DAX") |>
  select(date, index, price, daily_return, month, year) |>
  head(10)

# 6. Latest snapshot per index
latest <- eu |>
  group_by(index) |>
  filter(date == max(date)) |>
  summarise(
    latest_date = max(date),
    latest_price = last(price),
    .groups = "drop"
  )

latest

# 7. Cumulative performance (start to end)
cum_perf <- eu |>
  group_by(index) |>
  summarise(
    start_price = first(price),
    end_price = last(price),
    cum_return = (end_price / start_price) - 1,
    .groups = "drop"
  ) |>
  arrange(desc(cum_return))

cum_perf

# 8. Create two focused datasets: DAX and FTSE
dax <- eu |> filter(index == "DAX")
ftse <- eu |> filter(index == "FTSE")

head(dax)

# 9. Plot 1: DAX price over time
dax |>
  ggplot(aes(x = date, y = price)) +
  geom_line() +
  scale_y_continuous(labels = label_number()) +
  labs(
    x = "Date",
    y = "Price",
    title = "DAX Price Level (Synthetic Dates)"
  ) +
  theme_minimal()

# 10. Plot 2: DAX monthly average daily return
dax |>
  group_by(month) |>
  summarise(avg_daily_return = mean(daily_return, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(x = month, y = avg_daily_return)) +
  geom_line() +
  geom_point(size = 0.8) +
  scale_x_date(date_breaks = "6 months", date_labels = "%Y-%m") +
  scale_y_continuous(labels = label_percent(accuracy = 0.1)) +
  labs(
    x = "Month",
    y = "Avg Daily Return",
    title = "DAX Monthly Average Daily Return"
  ) +
  theme_minimal()

# 11. Quick in-class exercises
# Exercise A: Make the same two plots for FTSE.
ftse |>
  ggplot(aes(x = date, y = price)) +
  geom_line() +
  scale_y_continuous(labels = label_number()) +
  labs(
    x = "Date",
    y = "Price",
    title = "ftse Price Level (Synthetic Dates)"
  ) +
  theme_minimal()

ftse |>
  group_by(month) |>
  summarise(avg_daily_return = mean(daily_return, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(x = month, y = avg_daily_return)) +
  geom_line() +
  geom_point(size = 0.8) +
  scale_x_date(date_breaks = "6 months", date_labels = "%Y-%m") +
  scale_y_continuous(labels = label_percent(accuracy = 0.1)) +
  labs(
    x = "Month",
    y = "Avg Daily Return",
    title = "FTSE Monthly Average Daily Return"
  ) +
  theme_minimal()
# Exercise B: Which index has the highest cumulative return in cum_perf?

# 12. Exercise Solutions
## Exercise A (FTSE price plot)
# ftse |>
#   ggplot(aes(x = date, y = price)) +
#   geom_line() +
#   scale_y_continuous(labels = label_number()) +
#   labs(x = "Date", y = "Price", title = "FTSE Price Level") +
#   theme_minimal()

## Exercise A (FTSE monthly avg daily return plot)
# ftse |>
#   group_by(month) |>
#   summarise(avg_daily_return = mean(daily_return, na.rm = TRUE), .groups = "drop") |>
#   ggplot(aes(x = month, y = avg_daily_return)) +
#   geom_line() +
#   geom_point(size = 0.8) +
#   scale_x_date(date_breaks = "6 months", date_labels = "%Y-%m") +
#   scale_y_continuous(labels = label_percent(accuracy = 0.1)) +
#   labs(x = "Month", y = "Avg Daily Return", title = "FTSE Monthly Average Daily Return") +
#   theme_minimal()