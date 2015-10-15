## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## utilize the <<- operator which can be used to assign a value to an object in an
## environment that is different from the current environment. 

## The function is able to cache potentially time-consuming computations, here, the
## inverse of an matrix. If the contents of a vector are not changing, it caches the
## value so that when we need it again, it can be looked up in the cache rather than
## recomputed. 

## makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse
## cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix 
##      above. If the inverse has already been calculated (and the matrix has not changed), then
##      the cachesolve should retrieve the inverse from the cache.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(invs) inv <<- invs
    getinverse <- function() inv
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getinverse()
    if (!is.null(inv)) {
        message("getting cached inverse")
        return(inv)
    }
    matx <- x$get()
    inv <- solve(matx)
    x$setinverse(inv)
    inv
}
