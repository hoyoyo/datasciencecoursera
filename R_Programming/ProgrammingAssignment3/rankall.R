rankall <- function (outcome, num='best') {
    list_outcome  <- list("heart failure" = 17, "heart attack" = 11, "pneumonia" = 23)
    loc_outcome <- list_outcome[[outcome]]
    if (is.null(loc_outcome)) stop('invalide outcome')
    
    outcome_file  <- 'Hospital/outcome-of-care-measures.csv'
    hospital_file <- 'Hospital/hospital-data.csv'
    
    stats <- read.csv(outcome_file)
    columns <- colnames(stats)
    
    # convert the loc_outcome to numeric and split out the NA entries
    stats[, loc_outcome] <- suppressWarnings(as.numeric(levels(stats[, loc_outcome]))[stats[, loc_outcome]])
    sub_stats <- subset(stats, !is.na(stats[, loc_outcome]), select=c(columns[2],columns[7],columns[loc_outcome]))
    
    rank <- function(df) {
        if (is.character(num)) {
            list_rank <- list('best'=1, 'worst'=nrow(df))
            num <- list_rank[[num]]
        }
        # if there is no qualified entry or num exceeds the maximal number of entries 
        # return NA
        # otherwise rank the data by mortality rate and hospital name and 
        # select the num-th entry
        # only the hospital.name is returned
        if (nrow(df) == 0 || nrow(df) < num) NA
        else {
            as.character(df[ order(df[3], df[1]), ][num, c(1)])
        }
    }
    ret <- lapply(split(sub_stats, sub_stats$State), rank)

    # return a 2-column data frame, column_1:hospital column_2:state
    data.frame(hospital=as.character(ret), state=names(ret))
}
