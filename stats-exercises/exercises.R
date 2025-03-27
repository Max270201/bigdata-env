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



ggplot(dataHappyness, aes(y=serotonin_level, fill=happyness))+
  geom_boxplot()+
  coord_flip()

ggplot(dataHappyness, aes(y=endorphin_level, fill=happyness))+
  geom_boxplot()+
  coord_flip()




serotonin_happyness_observed = dataHappyness %>%
  specify(serotonin_level ~ happyness) %>%
  calculate(stat = "diff in means", order = c("rarely_happy", "usually_happy"))

serotonin_happyness_null_empirical = dataHappyness %>%
  specify(serotonin_level ~ happyness) %>%
  hypothesise(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in means", order = c("rarely_happy", "usually_happy"))

serotonin_happyness_null_empirical %>%
  visualise()+
  shade_p_value(serotonin_happyness_observed,
                direction = "two-sided")

serotonin_p_value_happyness = serotonin_happyness_null_empirical %>%
  get_p_value(obs_stat = serotonin_happyness_observed,
              direction = "two-sided")
serotonin_p_value_happyness

t_test(x = dataHappyness, 
       formula = serotonin_level ~ happyness, 
       order = c("rarely_happy", "usually_happy"),
       alternative = "two-sided")



##EXERCISE 3
dataCytofluorimeter = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L10_stats_exercises/exercise_03/L10_dataset_exercise03.rds"))




























##EXERCISE 4
dataReactor = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L10_stats_exercises/exercise_04/L10_dataset_exercise04.rds"))


