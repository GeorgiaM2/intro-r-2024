#### R Basics ####
# "A foolish consistency is the hobgoblin of 
#   little minds"   -Ralph Waldo Emerson 

# Literals ----
"this is a string literal" # double quotes preferred in R but not required 
42
T
F

# Operators ----
2 + 3 # note the spacing
2 - 3
2 * 3 # multiplication
2 / 3

2 ** 3 # but be careful; this is an exponent
2 ^ 3 # that's better

# comparison 
2 == 2 # tests for equality
"Joe" == "joe" # case-semsitive
2 == 1 + 1 # 0k
2 == (1 + 1) # better

2 != 1 # test inequality
2 < 3
2 > 3
2 >= 3
2 <= 2



# some what of a cruel joke
TRUE == 1 # 
FALSE == 0 
isTRUE(1)
isTRUE(TRUE) # function testing if the argument is literally TURE
?isTRUE # queries built-in help

2 < 3 & 2 > 3 # both have to pass to return true 
2 < 3 | 2 > 3 # either one TRUE, all true 
2 < 3 & (2 == 1 | 2 == 2) # grouping statements for ordering
  


# type matter (sometimes)
"joe" # string or character type 
typeof("joe")
42 # numeric type (double precision, floating point)
typeof(42)
TRUE
typeof(TRUE) # logical or boolean tye
42 == "42" # equality can cross types
identical(42, "42") # type matters for identity 



# variables ----
x <- "this is a tring" # in R, read as assigning the string to variale x
x
typeof(x)
x <- 10
x
x ^ 2 # always refers to the assigned value
pizza <- "x" # variable names can be most anything
pizza
#my var <- 42 # not everything though
my_var <- 42 # that's better
#my_var = 42 # works, but not standard in R
# my_var.pdx <- 42 # works, but don't
x <- my_var # helps reader follow assignment direction
x




# data structures ----
# vectors have a single dimension, like a column or row of data

# data frames - the key structure for data science, multi-dimensional
#   collections of vectors


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


