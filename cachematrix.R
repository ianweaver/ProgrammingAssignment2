## These functions provide a means to create special matrices that can store 
## their inverse, and also a matrix solver that checks this cached inverse
## and uses the cached value where available to save computation time.  

## Created in Response to R Programming course, programming assignment 2
## Created by Ian Weaver on 2016/05/01, contact ian.g.weaver@gmail.com
## Forked from https://github.com/rdpeng/ProgrammingAssignment2
## (ignore) Minor edit to enable new push




## The first function, makeCacheMatrix creates a special "matrix", 
## which is really a list containing a function to

## 1)set the value of the matrix
## 2)get the value of the matrix
## 3)set the value of the inverse
## 4)get the value of the inverse (return the value, not solve for the value)

makeCacheMatrix <- function(x = matrix()) {
	# Intialise the inverse as null
	inv <- NULL
	
	# Set function
        set <- function(y) {
                x <<- y
		# If matrix has been changed, old inverse is now invalid
                inv <<- NULL
        }
	
	# Get function
        get <- function() x
	
	# setinverse function
        setinverse <- function(inverse) inv <<- inverse
	
	# gertinverse function
        getinverse <- function() inv
	
	# return list of functions
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## The following function calculates the inverse of the special "matrix" 
## created with the above function. However, it first checks to see if 
## the inverse has already been calculated. If so, it gets the inverse 
## from the cache and skips the computation. Otherwise, it calculates 
## the inverse of the matrix and sets the value of the matrix in the cache 
## via the setinverse function.

## This function assumes that the matrix is invertable.  

cacheSolve <- function(x, ...) {
        # Get the cached inverse
	inv <- x$getinverse()
	
	# If it's not null return that value and exit
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
	
	# Else get the data and invert the matrix
        data <- x$get()
        inv <- solve(data, ...)
	
	# Store the inverse for cached use next time
        x$setinverse(inv)
	
	# Return the value
        inv
}

