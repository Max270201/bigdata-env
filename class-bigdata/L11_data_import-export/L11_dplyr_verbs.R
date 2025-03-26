
## we load the dataset
babynames = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L11_data_import-export/L11_dataset_babynames.rds"))

## have a look at the data
babynames


select(babynames, name, prop) #used to select columns by name, in this case 2 


###################
# SELECT HELPERS
###################


### select range of columns, when you have many of them and don t want to type all of em

select(babynames, name:prop) #from column name to column prop

select(babynames, year:n)


### select except

select(babynames, -c(sex,n)) #removes a column


### select with match

select(babynames, starts_with("n")) 



###################
## FILTER is used to filter rows depending on the values of one or more variables, after it you only get those rows
###################

filter(babynames, name == "Garrett") #double equal is a boulean condition, more like a question

filter(babynames, prop >= 0.08) #same condition

## filter extracts rows that meet every logical criteria

filter(babynames, name == "Garrett", year == 1880)


###################
## ARRANGE reorders rows according to one o rmore variables
###################


babynames %>% 
  arrange(n)


## inverting the order, through descending

babynames %>% 
  arrange(desc(n))


###################
## MAGIC FUNCTIONS
###################

## number of rows in a dataset or group
babynames %>% 
  summarise(n = n())

# number of DISTINCT values in a variable

babynames %>% 
  summarise(
    n = n(), 
    nname = n_distinct(name)
    )

?summarise()



babynames 
