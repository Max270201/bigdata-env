
library(tidyverse)
library(tidymodels)
library(tidyclust)
library(dbscan)
library(GGally)



cytofluorimeter_data = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L16_modelling_unsupervised/L16_dataset_cytofluorimeter.rds"))



k_means_model <- k_means( #same tidymodel structure, k means clustering (k assumed)
  num_clusters = 5
) %>% 
  set_engine("stats") %>% 
  set_mode("partition")


k_means_fit <- k_means_model %>% #no split betw training and testing cause no outcome
  fit(
    formula = ~.,
    data = cytofluorimeter_data
  )


k_means_fit %>% summary()

k_means_fit_summary = k_means_fit %>% extract_fit_summary()
str(k_means_fit_summary)


## combine individuals with cluster assignments

clustered_cyto = bind_cols(
  cytofluorimeter_data,
  k_means_fit %>% extract_cluster_assignment()
)

clustered_cyto %>% 
  ggplot(aes(x=CD12, y=CD45, colour = .cluster))+
  geom_point()

## 
## however, now we have a framework to calculate
## performance metrices

##### within cluster sum-of-squared error (WSS)

k_means_fit_summary$sse_within_total_total

## or 

k_means_fit %>% sse_within_total()

## by cluster

k_means_fit %>% sse_within() ## which is identical as the summary

#### total sum-of-squared error (TSS)

k_means_fit_summary$sse_total

# or 

k_means_fit %>% sse_total()

#### WSS / TSS ratio as summary

k_means_fit %>% sse_ratio()

## small values of the WSS/TSS ratio suggest that 
# the observations within clusters are closer (more similar) 
# to each other than they are to the other clusters.


##################################
##### more complex data
##################################

dataCellCulture = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L16_modelling_unsupervised/L16_dataset_cellculture_advanced.rds"))
# 6 variables
# To explore the dataset and identify any correlations 
# between the variables, you can use the GGally::ggpairs() function:

ggpairs(dataCellCulture)


####################################
### K-MEANS CLUSTERING #############
####################################

## we prepare a k-means clustering
## this time we don't know how many clusters
## if we look at metabolite 1 versus all the other metabolite
## it looks like there are 8 groups but we don't have much support for this
## check plot and learn how to read it

k_means_model <- k_means(
  num_clusters = 8
) %>% 
  set_engine("stats") %>% 
  set_mode("partition")


culture_k_means_fit <- k_means_model %>% 
  fit(
    formula = ~.,
    data = dataCellCulture
  )

## let's look at the overall score
#### WSS / TSS ratio as summary

culture_k_means_fit %>% sse_ratio()


### let's put the assignments together with the data
### but instead of using bind cols, we can use a more
### convenient function called "augment"

clustered_culture = culture_k_means_fit %>%
  augment(dataCellCulture) #is identical to bind cols and extract something, it can be heavy on you pc

### let's inspect how it looks like
clustered_culture

## and use this to plot again our ggpairs

ggpairs(clustered_culture, columns = 1:6, aes(colour = .pred_cluster)) #colour according the variable

#remind you that  you have 6 variables and you are representing them in a 2d plot, you could lose a few clusters
####################################
### HIERARCHICAL CLUSTERING ########
####################################

hc_model <- hier_clust(
  num_clusters = 8,
  linkage_method = "ward.D2" #distance betweent he first groups that you observed
  ) %>% 
  set_engine("stats") %>% 
  set_mode("partition")


culture_hc_fit <- hc_model %>% 
  fit(
    formula = ~.,
    data = dataCellCulture
  )

## let's look at the overall score
#### WSS / TSS ratio as summary

culture_hc_fit %>% sse_ratio()

## this is higher than the k-means clustering

## the dendrogram can be plotted

culture_hc_fit$fit %>% plot()

## not particularly informative

hc_clustered_culture = bind_cols( #no augmeting function, you extract the cluster assign
  dataCellCulture,
  culture_hc_fit %>% extract_cluster_assignment()
)

### let's inspect

hc_clustered_culture

## and use this to plot again our ggpairs

ggpairs(hc_clustered_culture, columns = 1:6, aes(colour = .cluster))


# it s even worse
####################################################
### feature engineering approach with PCA #########
###################################################

#transform data in a 2dimensional and preserve the similarities of clusters
culture_feature_eng_recipe <- recipe(~., data = dataCellCulture) %>% 
  step_normalize(all_numeric()) %>% 
  step_pca(all_numeric(), num_comp = 2) ## we are reducing the number of dimension to less than half


culture_feature_eng_wf <- workflow() %>% #no prep and baking, just recipe to the workflow
  add_model(k_means_model) %>% 
  add_recipe(culture_feature_eng_recipe)


culture_engineered_fit <- culture_feature_eng_wf %>% 
  fit(dataCellCulture) 


## let's look at the overall score
#### WSS / TSS ratio as summary

culture_engineered_fit %>% sse_ratio()

### the score is improved significantly


k_eng_clustered_culture = culture_engineered_fit %>%
  augment(dataCellCulture)


### let's inspect

k_eng_clustered_culture

## and use this to plot again our ggpairs

ggpairs(k_eng_clustered_culture, columns = 1:6, aes(colour = .pred_cluster))

#people plot the pca and see the number of clusters, and then assume the k. don t do that because you just project thed ata based on the highest variance
#even though you had a good 0.08 ssr ratio