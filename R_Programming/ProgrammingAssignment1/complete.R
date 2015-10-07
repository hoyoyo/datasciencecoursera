complete <- function(directory, id=1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  ret <- data.frame(id = id, nobs = numeric(length(id)))
  for (monitor in id) {
    if (monitor < 10)      location <- paste(c(directory, '/', '00', monitor, '.csv'), collapse = '')
    else if(monitor < 100) location <- paste(c(directory, '/', '0',  monitor, '.csv'), collapse = '')
    else                   location <- paste(c(directory, '/',       monitor, '.csv'), collapse = '')
    
    data <- read.csv(location)
    ret$nobs[ret$id == monitor] <- nrow(na.omit(data))
  }
  print(ret)
}