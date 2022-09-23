#' -----------------------------------------------------------------------
#' 
#' Pipes
#' 
#' -----------------------------------------------------------------------

# sum 1 through 10 and turn into a character
sum(1:10)

# nesting
as.character(sum(1:10))

as.character(
  sum(1:10)
)

# take sum of 1:10
# turn into a character
# paste this phrase "this is the answer"
# print

print(
  paste("This is the answer",
        as.character(
          sum(1:10)
        )
  )
)

# Lots of objects
my_answer <- sum(1:10)
my_answer <- as.character(my_answer)
my_answer <- paste("This is the answer", my_answer)
print(my_answer)

# Enter the pipe
# take an output and pipe it as the first arguement ot the next function

sum(1:10) |> #cmd-shift-m
  as.character() |>
  paste("is the answer") |>
  print()

#### If you don't know how to code something, write it out! ####

# This is the pipe from magrittr
library(magrittr)
sum(1:10)%>%
  as.character()

# use the magrittr pape to make 55 the 2nd arguement
sum(1:10)%>%
  as.character()%>%
  paste("this is the answer:", .)

# the native pipe requires a named arguement and uses _
sum(1:10) |>
  as.character() |>
  paste("this is the answer", a = _)

# Let's sum 1:10 and then get 100 random numbbers with a mean of sum(1:10)
# using a nromal dist

sum(1:10) |>
  rnorm(n=100, mean = _)

