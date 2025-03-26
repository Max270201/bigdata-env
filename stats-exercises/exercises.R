dataExposure = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L10_stats_exercises/exercise_01/L10_dataset_exercise01.rds"))
you might thinks that the variables are what you want to test for (??)
  
##EXERCISE 1

  observed_statistics_drinking = dataExposure %>%
  specify(formula = condition ~ drinking, success = "healthy") %>%
  hypothesise(null = "independence") %>%
  calculate(stat = "Chisq", order = c("drinker", "not drinker"))

observed_statistics_drinking = dataExposure %>%
  specify(formula = condition ~ drinking, success = "healthy") %>%
  hypothesise(null = "independence") %>%
  calculate(stat = "Chisq")



 ##our variables are categoricals, need chi square. You need ti specify the success. You also need
 ##you also need to specify your threshold for results (done through p-value)



##EXERCISE 2
dataHappyness = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L10_stats_exercises/exercise_02/L10_dataset_exercise_02.rds"))
##you can t say that the NT is the cause and the health state (group) is the outcome, conversely
##the groups will be the cause and the NTs the outcome



t_test(x = dataHappyness, 
       formula = sugar ~ individual_group, 
       order = c("case", "control"),
       alternative = "two-sided")+6









