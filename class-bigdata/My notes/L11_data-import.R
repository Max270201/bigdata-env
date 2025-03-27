### READR functions
### how to look at a function's options

formals(read_tsv)

names(formals(read_tsv))
names(formals(read_csv))

### one can compare options of different functions, it could look like they are the same

intersect(names(formals(read_tsv)), names(formals(read_csv)))

identical(names(formals(read_tsv)), names(formals(read_csv)))

## why this is false? cause they could have the same elements but not in the same position
## let's order the options, intersect to see if 2 vector overlapp, identical to check if 2 things are the same at
## each position, you can order the vectors through order

identical(
  names(formals(read_tsv))[order(names(formals(read_tsv)))], 
  names(formals(read_csv))[order(names(formals(read_csv)))]
  )


check <- c("george", "mary", "lukas")
order(check) #gives position number, if you do another thing
check[order(check)]#creates another vector where you can reorder your shit

##################################################
## READING DATA 
##################################################

### NIMBUS DATASET 

data = url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L11_data_import-export/L11_dataset_babynames.rds")

## one can read from the web
nimbus = read_csv("L11_dataset_nimbus.csv")
## or alternatively reaad it locally


## what do you observe? Why do you get a number as a character
nimbus

## inspect one single element
## observe the role of the function pull()let s you take 1 variable of the tibble out of the data set, as a vector
nimbus %>% pull(ozone) %>% class()#class shows you what you get

## one can obtain a similar result with the function pluck()
## observe the difference between the two
nimbus %>% pluck("ozone") %>% class()

## what is the conclusion of the vector type
## compare it with visual inspection of the above dataset
## why is that?

nimbus %>% pluck("ozone") %>% unique()#shows all possible unique elements of a vector

## observe better, there's a dot in your data, so if you get a character in your data everything will be converted into a character

## let's add an option

nimbus = read_csv("L11_dataset_nimbus.csv", na = ".") #na means not assigned

nimbus

## see what's changed
nimbus %>% pluck("ozone") %>% class()

## we can manually specify the column types

nimbus = read_csv(data, 
					na = ".",
					col_types = list(
                    ozone = col_double()#this part let s you soecify which column can be forced into a type
					)
					)

### let's see the result
nimbus

## look at all possible col types
?cols()
## and choose readr package

