## The function makeCacheMatrix creates a special ""vector", which is a list
## containing 4 functions:
##      set: can be used to set a new matrix, in this case the "old" inverse
##           must be resetted (set to NULL)
##      get: returning the matrix
##      setinverse: setting the value of the inverse mmatrix for caching

makeCacheMatrix <- function(x = matrix())
{
    inv <- NULL                ## no initial inverse
    set <- function(y)         ## function to set a new matrix
    {
        x <<- y                ## set the new matrix
        inv <<- null           ## no initial inverse data availlable
    }
    
    get <- function() x        ## function returning cached matrix
    
    setinverse <- function(inverse) inv <<- inverse    ## cache inverse matrix
    
    getinverse <- function() inv                       ## return cached inverse
    
    list(set = set,             ## vector containing the four functions
         get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## The function cacheSolve first checks whether there is a cached invberse of
## given matrix.
## If there is a cached inverse, print a message and return the inverse
## If there's no chache inverse, get the matrix, compute the inverse and cache 
## the inverse for later use
## In either case return the inverse of the matrix

cacheSolve <- function(x, ...)
{
    inv <- x$getinverse()                       ## Try to get the inverse
    if(!is.null(inv))                           ## If there is a cached inverse
    {
        message("getting cached inverse data")  ## Print info message
        return(inv)                             ## return cached inverse
    }
    data <- x$get()                             ## no cached inverse, get matrix
    inv <- solve(data, ...)                     ## compute the inverse
    x$setinverse(inv)                           ## cache the inverse for later use
    inv 
}

## Small test case
v = c(1, 3, 2, 4)               ## test vector
m = matrix(v, 2)                ## test matrix from vector
myinv <- makeCacheMatrix(m)     ## cache matrix, but not inverse
invmatrix <- cacheSolve(myinv)  ## get inverse of matrix
invmatrix                       ## 1st time: compute (no info message)
invmatrix <- cacheSolve(myinv)  ## get inverse of same matrix
invmatrix                       ## 2nd time: return cached inverse (info message)
