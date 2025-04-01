

library(tidymodels)
tidymodels_prefer()

## read the data in
photosynthesis_data = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L13_modelling_intro/L13_dataset_photosynthesis_data.rds"))


## split in training and testing
set.seed(502)#to set a certain pathway inside your algorithm
photosynthesis_split = initial_split(photosynthesis_data, prop = 0.8) #prop as in  proportion, usually more on training

## inspect the results, you might want to preserve the proportions by which your data are initially represented (stratas)
photosynthesis_split


## create training data
photosynthesis_training = training(photosynthesis_split)

## create testing data
photosynthesis_testing = testing(photosynthesis_split)

## reflect on the need to split with strata

### define the mathematical structure, general and doesn t depend on your data

lm_model <- 
  linear_reg() %>% #type of data with only one mode
  set_engine("lm") #engine, based on this you have things that you can do and things that you can t, like something that doesn t give you p values


## fit the model, by defining the relationship
## between the variables

lm_formula_fit <-
  lm_model %>% 
  fit(rate ~#dependency
        light + temperature + co2, data = photosynthesis_training)#means that the first part of the fit is the description of the dependency that your data will have



## now there's several ways to inspect the model
## simplest is just

lm_formula_fit

## what has been printed is the fit of the model
## which can also be extracted with

lm_formula_fit %>% extract_fit_engine() #gives you the coeficients associated to your predictors


## ths function allows to apply further methods to the fitted model
## such as

## best way to summarise is using a coherent tidymodels function

tidy(lm_formula_fit)#works due to this specific engine that can produce p-values

## all variables are clearly associated with the photosynthesis rate

## now we're ready to make a prediction

predicted_photosynthesis_rate = predict(lm_formula_fit, photosynthesis_testing) #predict as a verb, pass the fitted model and pass it to the testing dataset

## let's inspect this object

predicted_photosynthesis_rate #a tibble with one column, the predicted outcome of your model, you could bind them to the original dataset to compare

## we can also add a confidence interval to the prediction

predicted_photosynthesis_rate = predicted_photosynthesis_rate %>% 
  bind_cols(
    predict(lm_formula_fit, photosynthesis_testing, type = "pred_int") ## note addition of "type", generates a tibble with 3 columns with also the upper and lower limit of the confidence interval
)


### now we can verify what our model predicts, binding + plot

photosynthesis_testing %>% #original split, same order of rows
  bind_cols( #bind by columns
    predicted_photosynthesis_rate
  ) %>% #passing to ggplot where you put x=real outcome and y= predicted outcome, scatter plot and add line with those values of a prefect prediction (x=Y)
  ggplot(aes(x=rate, y=.pred))+
  geom_point()+
  geom_abline(intercept = 0, slope = 1, colour = "blue") 

#the performance is not well at extreme values, prediction lower at those values (lower enzyme rate),more precise towards central values
#the linearity is between the prediction and the outcome


### we can observe that the relationship is not exactly linear
### something we might have guessed in the initial plots
