
library(tidyverse)
library(tidymodels)
tidymodels_prefer()



## model metrics, 3 binding things, piping to the function matrix and check that the truth outcome is the one coming from your data and the prediction in I don't know why


enzyme_lm_prediction %>%
  metrics(truth = product, estimate = .pred) #369

enzyme_knn_prediction %>%
  metrics(truth = product, estimate = .pred)

enzyme_rf_prediction  %>%
  metrics(truth = product, estimate = .pred)




## evaluate differences


compare_metrices = bind_rows( #binding rows
  bind_cols( #calculate predictions and only metric and estimate as columns
    enzyme_lm_prediction %>%
      metrics(truth = product, estimate = .pred) %>%
      select(.metric, .estimate),
    model = "lm"
  ),
  bind_cols(
    enzyme_knn_prediction %>%
      metrics(truth = product, estimate = .pred) %>%
      select(.metric, .estimate),
    model = "knn"
  ),
  bind_cols(
    enzyme_rf_prediction %>%
      metrics(truth = product, estimate = .pred) %>%
      select(.metric, .estimate),
    model = "rf"
  )
) %>%
  pivot_wider(
    names_from = .metric,
    values_from = .estimate
  )


compare_metrices

compare_predictions = bind_rows(
  bind_cols(
    enzyme_lm_prediction %>% select(product, .pred),
    model = "lm"
  ),
  bind_cols(
    enzyme_knn_prediction %>% select(product, .pred),
    model = "knn"
  ),
  bind_cols(
    enzyme_rf_prediction %>% select(product, .pred),
    model = "rf"
  )
)

ggplot(compare_predictions, aes(x = product, y = .pred, colour = model))+
  geom_point()+
  geom_abline()+
  facet_wrap(~model)

