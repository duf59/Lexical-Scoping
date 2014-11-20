# cachematrix.R
#
# Author    : duf59
# Date      : November, 20, 2014
# R version : R-3.1.1
#
# This file is part of the programming assignment 2
# for the "R programming" course for Coursera
#
################################################################################
#
# We define here two functions which, when used together, enable to cache
# matrix inversion computation (potentially time-consuming).
#
# The functions should be used as follow :
#
#   - First create a special so-called "matrix"-object with makeCacheMatrix().
#     The latter takes a matrix as argument and returns a "matrix"-object
#     that stores the input matrix value and caches its inverse.
#
#   - Then, to compute the inverse of the matrix, use the cacheSolve() function. 
#     It takes as argument a "matrix"-object created with makeCacheMatrix().
#     It checks if the inverse has already been calculated. If so, it gets the
#     inverse from the cache and skips the computation. Otherwise, it calculates
#     the inverse and sets the value in the cache.
#
# Important note : the setInverse() function return by makeCacheMatrix(), which
#                  is part of the "matrix"-object, should not be called directly
#                  (this will corrupt the functioning of the code).
#                  It is only intended to be called by cacheSolve() function.
#
################################################################################


makeCacheMatrix <- function(matrix.value = matrix()) {
  # creates a "matrix"-object which is a list of functions
  #
  # Arg:
  #   - x: a square matrix
  #
  # Returns:
  #   - a "matrix"-object which is a list of the following functions:
  #     -- set():         set the value of the matrix
  #     -- get():         get the value of the matrix
  #     -- setInverse():  set the value of the inverse matrix,
  #                       should not be called directly, only from cacheSolve()
  #     -- getmInverse(): get the value of the inverse matrix

  # Initialize the inverse matrix to NULL when object is created
  matrix.inverse <- NULL
  
  set <- function(passed.value) {
    # to set the value of an existing "matrix"-object
    # it resets the inverse matrix to NULL
    matrix.value   <<- passed.value
    matrix.inverse <<- NULL
  }
  
  get <- function() {
    # to retrieve the value of a "matrix"-object
    matrix.value
  }
  
  setInverse <- function(passed.inverse) {
    # to set the inverse of a "matrix"-object
    # should not be called directly, only from the function cacheSolve()
    matrix.inverse <<- passed.inverse
  }
  
  getInverse <- function() {
    # to retrieve the inverse of a "matrix"-object
    matrix.inverse
  }
  
  # return the "matrix"-object which is a list of the above functions
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


cacheSolve <- function(matrix.object, ...) {
  # calculates the inverse of a "matrix"-object created with makeCacheMatrix()
  #
  # Args:
  #   - matrix.object: a "matrix"-object created with makeCacheMatrix()
  #
  # Returns:
  #   - the inverse of the matrix contained in the "matrix"-object
  #     If the inverse was already computed, it skips the computation and
  #     retrieves the inverse from matrix.object.
  #     Otherwise, inverse is calculated and stored in matrix.object

  matrix.inverse <- matrix.object$getInverse()
  
  if(!is.null(matrix.inverse)) {      # inverse is already present in matrix.object
    message("getting cached data")    # --> return the stored value
    return(matrix.inverse)
  }
  
  # If inverse is not present in matrix.object, --> compute it ...
  matrix.value <- matrix.object$get()     
  matrix.inverse <- solve(matrix.value, ...)
  
  # ... and store the inverse matrix in matrix.object
  matrix.object$setInverse(matrix.inverse)
  
  # return inverse matrix
  matrix.inverse
}

