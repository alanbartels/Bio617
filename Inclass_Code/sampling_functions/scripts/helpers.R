#' ---------------------------------------------------------------------------
#' Helper Functions
#' ----------------------------------------------------------------------------

# some max and min functions

new_min <- function(x){
  ret_value <- min(x)
  return(ret_value)
}

new_max <- function(x) {
  ret_value <- max(x)
  return(ret_value)
}

# a function that uses length.out as it's third arguement to seq
seq_by_length <- function(from = 1, to = 1,
                          length.out = 1,
                          ...){
  ret <- seq(from = from, to = to, length.out = length.out, ...)
}
