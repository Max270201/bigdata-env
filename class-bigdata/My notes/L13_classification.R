
heart_disease_data = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L13_modelling_intro/L13_dataset_heart_disease_data.rds"))


## first let's split

heart_disease_split = initial_split(heart_disease_data, prop = 0.8) 

## then training and testing

heart_disease_training = training(heart_disease_split)
heart_disease_testing = testing(heart_disease_split)

### now we prepare the model

rf_model <- rand_forest() %>% 
  set_mode("classification") %>% #you need to set the mode fir this one
  set_engine("ranger") #diocane


heart_disease_fit = rf_model %>% #pass the model to the function and a shortcut ~ ., means any other predictor/variable that is not the dependent one
  fit(heart_disease_risk ~ ., data = heart_disease_training) #it depends on ALL other variables


## let's make a prediction and check it, bind the prediction of the category to the testing data

heart_disease_predictions = heart_disease_testing %>% 
  bind_cols(
    predict(heart_disease_fit, heart_disease_testing), #pass it row by row
    predict(heart_disease_fit, heart_disease_testing, type = "prob")
  )


## let's quickly check how our predictions go
table(heart_disease_predictions$heart_disease_risk, heart_disease_predictions$.pred_class)#assing one category per outcome
#shoes actual outcome against predicted outcome, only the diagonal is good (low/low, medium/medium)
#confusion matrix shows the prediction numbers related to the real numbers
## we will discuss in the next class how we can improve this