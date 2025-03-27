

### introducing tribble()


band = tribble(
  ~name, ~band,
  "Mick", "Stones",
  "John", "Beatles",
  "Paul", "Beatles"
)


instrument <- tribble(
  ~name, ~plays,
  "John", "guitar",
  "Paul", "bass",
  "Keith", "guitar"
)

##you can enstablish relationship accross different databases (you need at least 1 joint info)
### the effect of different joins
##unsamble is a genome database + biologic things

### LEFT JOIN, only rows from this data set

band %>% 
  left_join(instrument, by = "name" #this one is the variable you use to gìjoin the 2 datasets)


### RIGHT JOIN

band %>% 
  right_join(instrument, by = "name")


### FULL JOIN, combination of both data sets

band %>% 
  full_join(instrument, by = "name")


### INNER JOIN, it only takes overlapping rows 

band %>% 
  inner_join(instrument, by = "name")
