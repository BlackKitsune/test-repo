#Caching the Mean of a Vector##################################################

#In this example we introduce the <<- operator which can be used to assign a 
#value to an object in an environment that is different from the current 
#environment. 

#Below are two functions that are used to create a special object that stores 
#a numeric vector and cache's its mean.

#The first function, "makeVector" creates a special "vector", which is really 
#a list containing a function to

        # 1. set the value of the vector --> set <- function(y)
        # 2. get the value of the vector --> get <- function() x
        # 3. set the value of the mean --> setmean
        # 4. get the value of the mean --> getmean

makeVector <- function(x = numeric()) {
        
        #Initialize objects x(as numeric function argument)
        #Initialize m inside the function
        m <- NULL
        
        #setter and getter object oriented programm (accessor and mutator)
        
        #setter=program modules that mutate data values within an object
        set <- function(y) {
                
                #Assign input argument to x object in the parent environment
                x <<- y
                
                #Assign NULL to m object in the parent environment 
                #To clear any m value cached by a prior execution cachemean()
                m <<- NULL
        }
        
        #Defines getter for the vector x
        #R retrieves x from the parent environment of makeVector()
        get <- function() x
        
        #Defines setter for the mean since m is defined in parent environment 
        #and we need to access it after setmean() completes, 
        #we use <<- to assign input argument to m in the parent environment
        setmean <- function(mean) m <<- mean
        
        #Defines getter for the mean m
        getmean <- function() m
        
        #Create a new object by returning a list()
        #Each element in list is named: created with a elementName = value
        list(set = set,
             get = get,
             setmean = setmean,
             getmean = getmean)
        #Naming elements allows to use $ to access the functions by name 
        
        #list(set = set,          # gives name 'set' to set() func defined
        #     get = get,          # gives name 'get' to get() func defined
        #     setmean = setmean,  # gives name 'setmean' to setmean() func
        #     getmean = getmean)  # gives name 'getmean' to getmean() func
}

#The following function calculates the mean of the special "vector" created 
#with the above function. 
#However, it first checks to see if the mean has already been calculated. 
#If so, it gets the mean from the cache and skips the computation. 
#Otherwise, it calculates the mean of the data and sets the value of the 
#mean in the cache via the setmean function.

#cachemean() func REQUIRES an input argument of type makeVector(). 
#If one passes a regular vector to the function it will display and error.

#Without cachemean(), makeVector() func is incomplete. 
#Why? As designed, cachemean() is required to populate or retrieve the mean 
#from an object of type makeVector().

#It starts with a single argument x, and an ... ellipsis that allows the 
#caller to pass additional arguments into the function.

cachemean <- function(x, ...) {
        
        #Retrieve a mean from the object passed in as the argument
        m <- x$getmean()
        
        #Check if result is NULL. 
        #Since makeVector() sets cached mean to NULL whenever a new vector 
        #is set into the object, if m is not equal to NULL, we have a valid, 
        #cached mean and can return it to the parent environment
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        
        #If result FALSE, cachemean() gets the vector from the input object...
        data <- x$get()
        
        #calculates mean()...
        m <- mean(data, ...)
        
        #uses setmean() func on input object to set mean in input object...
        x$setmean(m)
        
        #and returns the mean value to the parent environment by printing 
        #the mean object.
        m
}

#How the functions work at runtime

aVector <- makeVector(1:10)
aVector$get()               # retrieve the value of x
aVector$getmean()           # retrieve the value of m, which should be NULL
aVector$set(30:50)          # reset value with a new vector
cachemean(aVector)          # notice mean calculated is mean of 30:50, not 1:10
aVector$getmean()           # retrieve it directly, now that it has been cached

#Conclusion: what makes cachemean() work?

#The lexical scoping assignment in R Programming takes advantage of lexical 
#scoping and the fact that functions that return objects of type list() also 
#allow access to any other objects defined in the environment of the original 
#function. 

#In the specific instance of makeVector() this means that subsequent code can 
#access the values of x or m through the use of getters and setters. 

#This is how cachemean() is able to calculate and store the mean for the input 
#argument if it is of type makeVector(). 

#Because list elements in makeVector() are defined with names, we can access 
#these functions with the $ form of the extract operator.

#Extra information from:
#https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-breakingDownMakeVector.md
