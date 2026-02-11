# DANL 320 L2 LinReg Ex
oj <- read_csv('https://bcdanl.github.io/data/dominick_oj_ad.csv')
library(stargazer)
library(tidyverse)

# Model 1
oj_m1 <- lm(log(sales) ~ brand + log(price), 
            data = oj)

stargazer(
  oj_m1,
  type = "html",
  title = "OJ Model 1: log(sales) ~ brand + log(price)",
  dep.var.labels = "log(sales)",
  digits = 3
)

# Model 2
oj_m2 <- lm(log(sales) ~ brand * log(price), 
            data = oj)

stargazer(
  oj_m1, oj_m2,
  type = "html",
  title = "OJ Model 1 vs Model 2 (Brand × log(price))",
  dep.var.labels = "log(sales)",
  digits = 3
  
# Model 3
  oj_m3 <- lm(log(sales) ~ brand * log(price) * ad, 
              data = oj)
  
  stargazer(
    oj_m3,
    type = "html",
    title = "OJ Model 3: brand × log(price) × ad",
    dep.var.labels = "log(sales)",
    digits = 3
  )

