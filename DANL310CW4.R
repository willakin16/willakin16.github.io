# DANL 310 Classwork 4
library(tidyverse)
# install.packages("gapminder")
library(gapminder)
??gapminder
df_gapminder <- gapminder::gapminder
# Question 1 Part A
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = gdpPercap)) +
  geom_point(size = .5) +
  geom_line()

# Part 2
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = gdpPercap,
                     group = country)) +
  geom_point(size = .5,
             color = "black") +
  geom_line()

# Part 3
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = gdpPercap,
                     group = country)) +
  geom_point(size = .5,
             color = "black") +
  geom_line(show.legend = FALSE)

# Part B 1
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = gdpPercap,
                     group = country)) +
  geom_point(size = .5,
             color = "black") +
  geom_line(show.legend = FALSE) +
  facet_wrap( ~ continent)
  
# 2
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = gdpPercap,
                     group = country)) +
  geom_point(size = .5,
             color = "black") +
  geom_line(show.legend = FALSE) +
  facet_wrap( ~ continent, 
                nrow = 1)
# 3
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = log(gdpPercap),
                     group = country)) +
  geom_point(size = .5,
             color = "black") +
  geom_line(show.legend = FALSE) +
  facet_wrap( ~ continent, 
                     nrow = 1)

# 4
ggplot(data = df_gapminder,
       mapping = aes(x = year,
                     y = log(gdpPercap))) +
  geom_point(show.legend = FALSE,
                   color = 'grey',
                   mapping = aes(group = country)) + # Advanced ggplot: we can add a specific aes() to a specific geom.
  geom_line() +
  facet_wrap(~ continent, 
             nrow = 1)
