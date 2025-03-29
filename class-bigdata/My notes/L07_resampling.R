library(tidyverse)
##simulated dataset
dataCellCulture = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L07_infer_workflow/L07_dataset_resampling_cellculture.rds"))

### let's save the plot with the proportions
original_proportions = ggplot(dataCellCulture, aes(x=culture, fill = diameter))+
  geom_bar(position = "fill")

## and display it
original_proportions

## we can also group by the two variables and use the function
## tally() to count the occurrences in each group
## if we then pivot_wider we have a 2x2 that's suitable for chi-square test
dataCellCulture %>%
  group_by(culture, diameter) %>%
  tally() %>%
  pivot_wider(
    names_from = diameter,
    values_from = n
  )


### let's see what a permutation looks like
### we use the function sample()

dataCellCulture = dataCellCulture %>%
  mutate(
    reshuffled = sample(diameter, length(diameter), replace = FALSE) 
  ) ##sample function used to create a permutation, use ?sample in the console to use the helper
    ##sampling from the variable diameter a sample of the same size of the variable diameter
    ##which means, out of the 400 measurements you take all of them and make a NEW SAMPLE out of them
    ##which is going to be different

## we prepare a plot with the permuted proportions
permuted_proportions = ggplot(dataCellCulture, aes(x=culture, fill = reshuffled))+
  geom_bar(position = "fill")

## and display it
permuted_proportions ##you get a slightly different proportion


dataCellCulture %>%
  select(culture, reshuffled) %>%
  group_by(culture, reshuffled) %>%
  tally() %>%
  pivot_wider(
    names_from = reshuffled,
    values_from = n
  )


library(cowplot) ## needs up to date container

plot_grid(
  original_proportions,
  permuted_proportions,
  labels = c('original', 'permuted'),
  ncol = 2,
  align = 'v'
)

#### H0 is that the two cell cultures have different diameter, you need a test statistics
#### let's define a test to evaluate the extent of the difference
#### i.e. the proportion between normal / large and the difference between
#### the two cell cultures

### in the original dataset it would be 

ratio = dataCellCulture %>%
  group_by(culture, diameter) %>%
  tally() %>%
  pivot_wider(
    names_from = diameter,
    values_from = n
  ) %>%
  mutate(
    ratio = large / normal
  ) %>%
  pull(ratio)

proportion = ratio[1]/ratio[2]

######## we can now replicate this procedure 100 times

proportions = replicate(100, { ##replicate is like rep, but the latter repeats a single value, replicate the whole procedure, after the curly you write what you want to replicate
  ratio = dataCellCulture %>%
    mutate(
      reshuffled = sample(diameter, length(diameter), replace = FALSE)
    ) %>%
    select(culture, reshuffled) %>%
    group_by(culture, reshuffled) %>%
    tally() %>%
    pivot_wider(
      names_from = reshuffled,
      values_from = n
    ) %>%
    mutate(
      ratio = large / normal
    ) %>%
    pull(ratio)
  proportion = ratio[1]/ratio[2]
  return(proportion)
})

hist(proportions)
abline(v = proportion, col='red', lwd=3, lty='dashed')
##