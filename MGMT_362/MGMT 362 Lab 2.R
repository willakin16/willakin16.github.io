# Lab 2
# 1.1 Numeric and Integer
sales <- 125.75
units_sold <- 40

sales
## [1] 125.75
units_sold
## [1] 40
class(sales)
## [1] "numeric"
class(units_sold)
## [1] "numeric"
typeof(sales)
## [1] "double"
typeof(units_sold)
## [1] "double"
units_sold_int <- 40L
class(units_sold_int)
## [1] "integer"
typeof(units_sold_int)
## [1] "integer"

# 1.2 Character (Text)
School_name <- "SUNY Geneseo"
region <- "Upstate NY"

School_name
## [1] "SUNY Geneseo"
region
## [1] "Upstate NY"
class(School_name)
## [1] "character"
nchar(School_name)
## [1] 12

# 1.3 Logical (TRUE / FALSE)
is_profitable <- TRUE
high_demand <- units_sold > 30

is_profitable
## [1] TRUE
high_demand
## [1] TRUE
class(high_demand)
## [1] "logical"

# 2. Vectors
# A vector is a collection of values of the same type.

# 2.1 Creating Vectors
monthly_sales <- c(1200, 1350, 1420, 1600, 1550)
monthly_sales
## [1] 1200 1350 1420 1600 1550
length(monthly_sales)
## [1] 5
class(monthly_sales)
## [1] "numeric"

# 2.2 Vector Operations
mean(monthly_sales)
## [1] 1424
sum(monthly_sales)
## [1] 7120
max(monthly_sales)
## [1] 1600
min(monthly_sales)
## [1] 1200
monthly_sales * 1.05
## [1] 1260.0 1417.5 1491.0 1680.0 1627.5

# 3. Data Frames
# A data frame stores observations in rows and variables in columns.

# 3.1 Creating a Data Frame
employee_data <- data.frame(
  employee_id = c(101, 102, 103, 104),
  department = c("HR", "Marketing", "Finance", "IT"),
  salary = c(55000, 62000, 70000, 68000),
  full_time = c(TRUE, TRUE, FALSE, TRUE)
)

employee_data
##   employee_id department salary full_time
## 1         101         HR  55000      TRUE
## 2         102  Marketing  62000      TRUE
## 3         103    Finance  70000     FALSE
## 4         104         IT  68000      TRUE

# 3.2 Exploring a Data Frame
str(employee_data)
## 'data.frame':    4 obs. of  4 variables:
##  $ employee_id: num  101 102 103 104
##  $ department : chr  "HR" "Marketing" "Finance" "IT"
##  $ salary     : num  55000 62000 70000 68000
##  $ full_time  : logi  TRUE TRUE FALSE TRUE
summary(employee_data)
##   employee_id     department            salary      full_time      
##  Min.   :101.0   Length:4           Min.   :55000   Mode :logical  
##  1st Qu.:101.8   Class :character   1st Qu.:60250   FALSE:1        
##  Median :102.5   Mode  :character   Median :65000   TRUE :3        
##  Mean   :102.5                      Mean   :63750                  
##  3rd Qu.:103.2                      3rd Qu.:68500                  
##  Max.   :104.0                      Max.   :70000

# 3.3 Accessing Rows and Columns
employee_data$salary
## [1] 55000 62000 70000 68000
employee_data[1, ]
##   employee_id department salary full_time
## 1         101         HR  55000      TRUE
employee_data[, "department"]
## [1] "HR"        "Marketing" "Finance"   "IT"
employee_data[employee_data$salary > 60000, ]
##   employee_id department salary full_time
## 2         102  Marketing  62000      TRUE
## 3         103    Finance  70000     FALSE
## 4         104         IT  68000      TRUE

# 4. Functions in R
# Functions help automate tasks and reduce repetition.

# 4.1 Built-in Functions
mean(employee_data$salary)
## [1] 63750
median(employee_data$salary)
## [1] 65000

# 4.2 Writing a Custom Function
calculate_bonus <- function(salary, rate = 0.10) {
  bonus <- salary * rate
  return(bonus)
}
calculate_bonus(60000)
## [1] 6000
calculate_bonus(60000, rate = 0.15)
## [1] 9000
calculate_bonus(employee_data$salary)
## [1] 5500 6200 7000 6800

# 5. Conditional Logic
performance_bonus <- function(salary, rating) {
  if (rating >= 4) {
    salary * 0.15
  } else {
    salary * 0.05
  }
}
performance_bonus(60000, 5)
## [1] 9000
performance_bonus(60000, 3)
## [1] 3000

# 6. Loops
# Loops repeat code over multiple values.

# 6.1 For Loop Example
bonuses <- numeric(length(employee_data$salary))

for (i in 1:length(employee_data$salary)) {
  bonuses[i] <- calculate_bonus(employee_data$salary[i])
}

bonuses
## [1] 5500 6200 7000 6800
employee_data$bonus <- bonuses
employee_data
##   employee_id department salary full_time bonus
## 1         101         HR  55000      TRUE  5500
## 2         102  Marketing  62000      TRUE  6200
## 3         103    Finance  70000     FALSE  7000
## 4         104         IT  68000      TRUE  6800

# 6.2 Loop with Conditions
performance_rating <- c(5, 4, 3, 5)
performance_rating
## [1] 5 4 3 5
performance_bonus_vec <- numeric(length(performance_rating))

for (i in 1:length(performance_rating)) {
  performance_bonus_vec[i] <- performance_bonus(
    employee_data$salary[i],
    performance_rating[i]
  )
}

performance_bonus_vec
## [1]  8250  9300  3500 10200

# 7. Loops vs Vectorization (Preview)
employee_data$fast_bonus <- employee_data$salary * 0.10
employee_data
##   employee_id department salary full_time bonus fast_bonus
## 1         101         HR  55000      TRUE  5500       5500
## 2         102  Marketing  62000      TRUE  6200       6200
## 3         103    Finance  70000     FALSE  7000       7000
## 4         104         IT  68000      TRUE  6800       6800

# MGMT 362 Lab 2 Practice Exercise
weekly_sales <- c(123, 245, 334, 456, 544, 645)
weekly_sales


total_sales <- sum(weekly_sales)
total_sales
average_sales <- mean(weekly_sales)
average_sales


employee_data <- data.frame(
  employee_id = c(101, 102, 103, 104),
  department = c("HR", "Marketing", "Finance", "IT"),
  salary = c(55000, 62000, 70000, 68000),
  full_time = c(TRUE, TRUE, FALSE, TRUE)
)

employee_data

avg_salary <- mean(employee_data$salary)
avg_salary

employee_data$above_avg_salary <- employee_data$salary > avg_salary
employee_data


monthly_to_annual_sales <- function(monthly_sales) {
  annual_sales <- monthly_salees * 12
  return(annual_sales)
}

monthly_sales <- c(1200, 1350, 1420, 1600, 1550)
monthly_sales
annual_sales_loop <- numeric(length(monthly_sales))

for (i in 1:length(monthly_sales)) {
  annual_sales_loop[i] <- monthly_to_annual(monthly_sales[i])
}

annual_sales_loop

