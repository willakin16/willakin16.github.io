# DANL 310 Lect 2
# color blind
library(ggthemes)
library(tidyverse)
ggplot( data = mpg,
        mapping = 
          aes(x = displ,
              y = hwy, 
              color = class) ) + 
  geom_point(size = 3) +
  scale_color_colorblind()

# tableau
ggplot( data = mpg,
        mapping = 
          aes(x = displ,
              y = hwy, 
              color = class) ) + 
  geom_point(size = 3) +
  scale_color_tableau()

# Box PLot
ggplot(data = mpg,
       mapping = 
         aes(x = class,
             y = hwy)) + 
  geom_boxplot() 

# Box Plot: Color
library(ggthemes) 
ggplot(data = mpg,
       mapping = 
         aes(x = hwy,
             y = class,
             fill = class)) + 
  geom_boxplot(
    show.legend = FALSE) +
  scale_fill_tableau() 

# fct_reorder Reorders graph by (category, numerical)
# labs() can label
#   x-axis, y-axis, and more

ggplot(data = mpg,
       mapping = 
         aes(x = hwy,
             y = 
               fct_reorder(class, hwy), # can put - in front to flip
             fill = class)) + 
  geom_boxplot(
    show.legend = FALSE) +
  scale_fill_tableau() +
  labs(x = "Highway MPG",
       y = "Class") 

# Bar Chart
diamonds <- ggplot2::diamonds
?diamonds

ggplot(data = diamonds,
       mapping = aes(x = cut)) + # switch x with y to rotate graph
  geom_bar()a

# Bar Chart: Color
ggplot(data = diamonds,
       mapping = 
         aes(x = cut, 
             fill = cut)) + 
  geom_bar(
    show.legend = FALSE
  ) 

# count
count(diamonds,
      cut,
      clarity)

# count (|>)
diamonds |> count(cut, clarity)

# stacked bar chart (specified fill)
ggplot(data = diamonds,
       mapping = 
         aes(x = cut, 
             fill = clarity)) + 
  geom_bar()

# 100% filled
ggplot(data = diamonds,
       mapping = 
         aes(x = cut, 
             fill = clarity)) + 
  geom_bar(position = "fill") +
  labs(y = "Proportion") # Changed y-axis label

# Clustered Bar Charts
ggplot(data = diamonds,
       mapping = 
         aes(x = cut, 
             fill = clarity)) + 
  geom_bar(position = "dodge")

# position = "dodge"
library(nycflights13)
ggplot(data = flights,
       mapping = 
         aes(y = carrier, 
             fill = origin)) + 
  geom_bar(position = "dodge")

# position_dodge2 
ggplot(data = flights,
       mapping = 
         aes(y = carrier, 
             fill = origin)) + 
  geom_bar(position = position_dodge2(
    preserve = "single"))

# geom_col & fct_reorder(categorial, class)
df <- mpg |> 
  count(class)

ggplot(data = df,
       mapping = 
         aes(x = n,
             y = 
               fct_reorder(class, n))
) + 
  geom_col() + # No geom_bar used
  labs(y = "Class")

