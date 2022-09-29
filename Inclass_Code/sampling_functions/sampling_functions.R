#'-----------------------------------------------------------------------------
#'Functions!!!!
#'@date 09/27/2022
#'-----------------------------------------------------------------------------

#### Libraries ####
#### Working dir and other options ####

#### Load in helper code ####
source("scripts/helpers.R")

#### Our first function ####

# We want a function that adds +1 to a number
add_one <- function(x) {
  ret_value <- x + 1
  return(ret_value)
}

# other quick ways to write a function
add_one <- function(x) {
  return(x+1)
}

# First question
add_one <- function(x) x+1

square_root <-  function(x) {
  ret_value <- sqrt(x)
  return(ret_value)
}

square_root(16)

max_minus_min <- function(x){
  ret_value <- max(x) - min(x)
  return(ret_value)
}
max_minus_min(c(4,7,1,6,8))

# debugging techniques, step through
debugonce(max_minus_min)
max_minus_min(c(4,7,1,6,8))

new_min(c(4,5,6))

max_minus_min_detailed <- function(x){
  max_val = new_max(x)
  min_val = new_min(x)
  diff_val = max_val - min_val
  
  ret <- list(max_val = max_val,
              min_val = min_val,
              diff_val = diff_val)
  return(ret)
}

max_minus_min_detailed(c(3,4,5))

# rewriting to a global variable
foo <- 1

clock_tick <- function() foo <<- foo + 1
clock_tick()
foo

# Arguements can have default values
add_values <- function(x, y=0){
  return(x+y)
}

add_values(3)

#### Multiple Arguements ####
# a funciton that adds THREE numbers together,
# but if any of them are missing, assume zero

add_three_numbers <- function(x = 0,
                               y = 0,
                               z = 0){
  return(x+y+z)
}
add_three_numbers()
add_three_numbers(3,)



# You can have ... to pass many arguements
make_mean <- function(a_vector, ...){
  sum_vector <- sum(a_vector, ...)
  n <- length(a_vector)
  return(sum_vector/n)
}

make_mean(c(4,5,6))

#### Exercises ####
square_and_sum <- function(x) {
  squared <- x^2
  ret_val <- sum(squared)
  return(ret_val)
}
square_and_sum(c(4,5,6))

add_elephant <- function(x, def_word = "elephants"){
  ret_val <- paste(x, def_word, sep = " ")
  return(ret_val)
}

combo_nss <- function(x, y, z){
  ret_val <- paste(x, y, sep = z)
  return(ret_val)
}

combo_nss(3, "hello", "-")
