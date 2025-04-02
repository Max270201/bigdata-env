

library(tidyverse)
library(tidymodels)
tidymodels_prefer()


enzyme_process_data = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L14_modelling_supervised_regression/L14_dataset_enzyme_process_data.rds"))


## FIRST WE SPLIT the dataset into training and testing
set.seed(358)

enzyme_split = initial_split(enzyme_process_data, prop = 0.75)
enzyme_training = training(enzyme_split)
enzyme_testing = testing(enzyme_split)


########################
# LINEAR REGRESSION ####you don t need mode cause it is a regression by default
########################

### define the mathematical structure

lm_model <-
  linear_reg() %>% 
  set_engine("lm")


## fit the model, by defining the relationship
## between the variables

enzyme_lm_formula_fit <- #fit accepts the product as ???
  lm_model %>% 
  fit(product ~ ., data = enzyme_training)


## now there's several ways to inspect the model
## simplest is just

enzyme_lm_formula_fit

## what has been printed is the fit of the model
## which can also be extracted with

enzyme_lm_formula_fit %>% extract_fit_engine()


## ths function allows to apply further methods to the fitted model
## such as

## best way to summarise is using a coherent tidymodels function

tidy(enzyme_lm_formula_fit)


enzyme_lm_prediction = enzyme_lm_formula_fit %>% #bind prediction to testing dataset
  predict(enzyme_testing) %>%
  bind_cols(enzyme_testing)


enzyme_lm_prediction %>%
  ggplot(aes(x=product, y=.pred))+
  geom_point(alpha = 0.4, colour = "blue")+ #alpha is transparency of your colour
  geom_abline(colour = "red", alpha = 0.9) 

#prediction doen t work well, you see how at low concs you get shitty predc, even at high values
########################
# NEAREST NEIGHBOURS ###
########################


knn_reg_model <-
  nearest_neighbor(neighbors = 5, weight_func = "triangular") %>%
  # This model can be used for classification or regression, so set mode
  set_mode("regression") %>% #cause it can work with both regression and classification
  set_engine("kknn")

knn_reg_model



enzyme_knn_formula_fit <-
  knn_reg_model %>% 
  fit(formula = product ~ temperature + substrateA + substrateB + enzymeA + enzymeB + enzymeC + eA_rate + eB_rate + eC_rate, 
      data = enzyme_training) #doesn t do well with the tilde and dot as a shortcut


enzyme_knn_prediction = enzyme_knn_formula_fit %>%
  predict(enzyme_testing) %>%
  bind_cols(enzyme_testing)



enzyme_knn_prediction %>%
  ggplot(aes(x=product, y=.pred))+
  geom_point(alpha = 0.4, colour = "blue")+
  geom_abline(colour = "red", alpha = 0.9)



#########################
## RANDOM FOREST ########
#########################


rf_model_reg <- rand_forest() %>% 
  set_mode("regression") %>% 
  set_engine("ranger")


enzyme_rf_formula_fit <-
  rf_model_reg %>% 
  fit(formula = product ~ temperature + substrateA + substrateB + enzymeA + enzymeB + enzymeC + eA_rate + eB_rate + eC_rate, 
      data = enzyme_training)


enzyme_rf_prediction = enzyme_rf_formula_fit %>%
  predict(enzyme_testing) %>%
  bind_cols(enzyme_testing)




enzyme_rf_prediction %>%
  ggplot(aes(x=product, y=.pred))+
  geom_point(alpha = 0.4, colour = "blue")+
  geom_abline(colour = "red", alpha = 0.9)
#random forest is more complex, takes more time than a linear regr
