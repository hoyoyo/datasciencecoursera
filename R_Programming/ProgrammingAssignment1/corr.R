corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  files <- list.files(path=directory, pattern='\\.csv')
  
  ret <- c()
  for (file in files) {
        full_file <- paste(c(directory, '/', file), collapse='')
        data <- na.omit(read.csv(full_file))
        if (nrow(data) >= threshold) {
            ret <- c(ret, cor(data$nitrate, data$sulfate)) 
        }
  }
  
  if (length(ret) == 0) vector('numeric', length=0)
  else ret
}