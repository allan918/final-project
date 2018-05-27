state_name <- function(input) {
  substr(input, nchar(input) - 1, nchar(input))
}