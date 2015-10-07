best <- function(state, outcome) {
    # heart failure - column 17
    # heart attack  - column 11
    # pneumonia     - column 23
    list_outcome  <- list("heart failure" = 17, "heart attack" = 11, "pneumonia" = 23)
    outcome_file  <- 'Hospital/outcome-of-care-measures.csv'
    hospital_file <- 'Hospital/hospital-data.csv'
    
    stats <- read.csv(outcome_file, colClasses='character')  
    states <- levels(factor(stats[, 7]))
    
    # test whether the state is valid
    # or match(state, states)
    if (!state %in% states) stop('invalid state')
    
    # test whether the outcome is valid
    loc_outcome <- list_outcome[outcome][[1]]
    if (length(loc_outcome) == 0) stop('invalid outcome')
    else {
        #loc_outcome <- as.numeric(loc_outcome)
        # convert the outcome column to numerics from character
        stats[, loc_outcome] <- suppressWarnings(as.numeric(stats[, loc_outcome]))
    }
    
    subset_hospital <- na.omit(subset(stats, State == state, select=c(2, loc_outcome)))
    
    subset_hospital[which.min(subset_hospital[,2]), 1]
}