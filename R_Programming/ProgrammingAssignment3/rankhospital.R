rankhospital <- function(state, outcome, num='best') {
    # heart failure - column 17
    # heart attack  - column 11
    # pneumonia     - column 23
    list_outcome  <- list("heart failure" = 17, "heart attack" = 11, "pneumonia" = 23)
    outcome_file  <- 'Hospital/outcome-of-care-measures.csv'
    hospital_file <- 'Hospital/hospital-data.csv'
    
    stats <- read.csv(outcome_file, colClasses='character')  
    states <- levels(factor(stats[,7]))
    columns <- names(stats)
    
    if (!state %in% states) stop("invalid state")
    loc_outcome <- list_outcome[outcome]
    if (length(loc_outcome) == 0) stop("invalid outcome")
    loc_outcome <- as.numeric(loc_outcome)
    
    # split the entries that only belong to the state
    sub_stats <- subset(stats, State == state, select=c(columns[2], columns[loc_outcome]))
    sub_stats[, 2] <- suppressWarnings(as.numeric(sub_stats[, 2]))
    sub_stats <- na.omit(sub_stats)
    
    # num is 'best' or 'worst' or numeric
    list_rank <- list('best' = 1, 'worst' = nrow(sub_stats))
    if (is.character(num)) rank_out <- list_rank[[num]]
    else rank_out <- num
    
    # if rank_out is greater than the number of entries, return NA
    # otherwise reorder the data frame
    if (rank_out > nrow(sub_stats)) NA
    else {
        sub_stats <- data.frame(sub_stats[ order(sub_stats[,2], sub_stats[,1]), ], row.names=seq(nrow(sub_stats)))
        sub_stats[rank_out, 'Hospital.Name']    
    }
}