pollutantmean <- function(directory, pollutant, id=1:332) {
    retMean <- 0.0
    for (monitor in id) {
        if (monitor < 10)      location <- paste(c(directory, '/', '00', monitor, '.csv'), collapse = '')
        else if(monitor < 100) location <- paste(c(directory, '/', '0',  monitor, '.csv'), collapse = '')
        else                   location <- paste(c(directory, '/',       monitor, '.csv'), collapse = '')
        
        data <- read.csv(location)
        retMean <- retMean + colMeans(data[pollutant], na.rm=TRUE)
    }
    
    retMean / length(id)
}