Lexical-Scoping
===============

Programming assignment 2 of the "R programming" course from Coursera

## Content

* `cachematrix.R` : a set of wo functions enabling to cache matrix inversion computation

## Description

`cachematrix.R` contains the definition of two R functions named `makeCacheMatrix()` and `cacheSolve()`. When used together, these functions enable to cache matrix inversion computation which is potentially time-consuming :

1.  `makeCacheMatrix`  creates a special "matrix"-object that can cache its inverse.
2.  `cacheSolve` computes the inverse of a "matrix"-object returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then
`cacheSolve` retrieves the inverse from the cache. Otherwise, it calculates the inverse of
the data and sets the value of the inverse in the cache.