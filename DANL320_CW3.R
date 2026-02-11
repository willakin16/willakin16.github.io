# DANL 320 Classwork 3
library(tidyverse)
library(stargazer)
library(broom)
library(skimr)

# Question 1
oj <- read_csv("https://bcdanl.github.io/data/dominick_oj_feat.csv")
group_by(brand)
skim()
# Question 2
set.seed(1234)

oj <- oj |> 
  mutate(rnd = runif(n())),
        brand = factor(brand,
                       levels = 
                         c("dominicks", "minute.maid", "tropicana")),
        ad_status = factor(ad_status)
dtrain <- oj |>
  filter(rnd > 0.3)
dtest <- oj |> 
  filter(rnd <= 0.3)

# Question 4
m1 <- lm(log(sales) - brand,
                  data = dtrain)

# Question 5


# Question 6
m1_pred <- augment(m1, newdata = dtest)
m1_rmse <- augment(m1, newdata)
m2_rmse <-
m3_rmse <-
  
#m3 is bets lowest error
# Question 7
  
# Question 8
  