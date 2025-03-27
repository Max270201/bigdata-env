
## we can create a factor with the function factor()
## the argument x represents the data
## the levels argument defines the attribute

eyes <- factor(x = c("blue", "green", "green"),
               levels = c("blue", "brown", "green")#specified levels
               )

## when we inspect the object
eyes #gets prionted as the original data set

## however its internal representation can be visualise with
unclass(eyes) #see the internal representation of it, you get a vector of a certain amount of elements with the elements below
#you always have the level represented but they can also not be expressed mby 


## import a dataset
factorData = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L11_data_import-export/L11_dataset_factors.rds"))

## inspect the dataset
factorData

## we can already see the class in the tibble
## but let's run this
factorData %>% pull(base) %>% class()

## we use the function levels() to access a factor's levels

levels(factorData$base)

## by default they are ordered alphabetically

## REORDER levels, you plot it, aes for mapping the variable into the x or y of your plot

ggplot(factorData, aes(x=base, y=counts))+
  geom_bar(stat = "identity")#geom is independent from your aesthetic, like scatter plot, histogram

## to help visualising trends and relationships, the factors 
## should follow the order of data

factorData %>%
  mutate(
    base = fct_reorder(base, counts)#fct reorders the levels of the vector based on the values of another variable (which in this case is counts)
  ) %>%#passing it to ggplot so you don t have to specify shit
  ggplot(aes(x=base, y=counts))+
  geom_bar(stat = "identity")

## or in a decreasing order

factorData %>%
  mutate(
    base = fct_reorder(base, counts, .desc = TRUE) #.descending = true to get the opposite order
  ) %>%
  ggplot(aes(x=base, y=counts))+
  geom_bar(stat = "identity")


## changing levels can be tricky, you will just change them, NOT the vectors, which will have the new level integrated
## reconding can be done safely with fct_recode()
## new level = old level


factorData %>%
  mutate(
    base = fct_recode(base, #fct_recode as the function that let s you do it
                      "Adenine" = "A",
                      "Guanine" = "G",
                      "Thymine" = "T",
                      "Cytosine" = "C"
                      )
  )


### sometimes we need to collapse groups, you assign original values to new ones, that can be then grouped

factorData %>% 
  mutate(
    base = fct_collapse(base,
                        purines = c("A", "G"),
                        pyrimidines = c("T", "C")
                        )
  )

## this allows us to group

factorData %>% 
  mutate(
    base = fct_collapse(base,
                        weak-bond = c("A", "T"),
                        strong-bond = c("G", "C")
    )
  ) %>% 
  group_by(base) %>% 
  summarise(
    base_cat_count = sum(counts)
  )
