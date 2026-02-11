# DANL320 CW2

# Question 1
library(tidyverse)
library(broom)
library(stargazer)
library(skimr)
bikeshare <- read_csv("https://bcdanl.github.io/data/bikeshare_cleaned.csv")
# Year is Categorical
# Month is Categorical
# Date is Categorical
# Hour is Categorical
# Weekday is Categorical
# Holiday is Categorical
# Seasons is Categorical
# Weather condition is Categorical
# Temperature is Continuos
# Humidity is Continous
# Windspeed is Continuous

# Question 2
bikeshare <- bikeshare |>
  mutate(
    year = factor(year),
    year = fct_relevel(year, "2011"),
    seasons = factor(seasons,levels = c("spring",
                                        "summer",
                                        "fall",
                                        "winter")),

    month = factor(month),
    month = fct_relevel(month,"01"),
    hr = factor(hr),
    hr = fct_relevel(hr, "0"),
    wkday = factor(wkday, levels = c("saturday", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday")),

    weather_cond = factor(weather_cond,levels = c("Clear or Few Cloudy","Light Snow or Light Rain","Mist or Cloudy"))
)


set.seed(1)

bikeshare <- bikeshare |>
  mutate(rnd = runif(n()))
dtrain <- bikeshare |>
  filter(rnd > 0.4)
dtest <- bikeshare |>
  filter(rnd <= 0.4)

nrow(dtrain)/nrow(bikeshare)

# Question 3
model <- lm(cnt ~ temp + hum + windspeed +
              year +
              month +
              hr +
              wkday +
              holiday +
              seasons +
              weather_cond,
            data = dtrain)

stargazer(model, type = "text")

model_out_1 <- tidy(model, conf.int = T)
model_out_2 <- glance(model)
model_out_3 <- augment(model)

# rm(model_out)

# Question 4
dtest <- dtest |>
  mutate(pred = predict(model, newdata = dtest))

# Question 5
# -4.965

# Question 6
stargzaer(model, type = "text")

model_out_hr <- model_out_1 |>
  filter(str_detect(term, "hr")) |>
  arrange(-abs(estimate))
# hr17
# 378.85232

# Question 7
model_out_1 |>
  filter(term %in% c("temp", "hum",
                     "windspeed")) |>
  ggplot() +
  geom_pointrange(
    aes(xmin = conf.low, xmax = conf.high,
        x = estimate,
        y = term
        )
  ) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Coefficient Plot: temp, hum, windspeed",
       x = "Variable",
       y = "Beta Estimate")
  

