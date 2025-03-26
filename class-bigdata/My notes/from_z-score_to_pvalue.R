library(tidyverse)

############################
### score of exams ########

s = 0:35 # possible scores of the exam
joe = 30 # score of our test student
pop_mean = 25 # mean score of most students at exam
pop_sd = 4 # standard deviation of exam results
alpha = 0.05 # we need to choose our significance level

## create a tibble with probability associated to each possible score
## from a normal distribution with these characteristics

normalDensity = tibble(
  score = s,
  probability = dnorm ##density probability out of normal distribution
  (s, mean = pop_mean, sd = pop_sd) ## probability of achieving that score with normal mean 25 & sd 4
)

## we can now order the values of the probability in order to compute
## the cumulative probability

normalDensity = normalDensity %>%
  arrange(probability) %>% ## to make sure data are ordered by probability first
  mutate(
    cumulative_p = cumsum ##cumulative sum to calculate the cumulative value of all previous value
    ##every prob is now the sum of everything that comez before that
    (probability), ## now they are ordered we can make a cumulative p
    reject = cumulative_p <= alpha
  )  ## boulean to say that if cump is equal or lower alpha then reject is true
## 

## now we can plot this

normalplot = ggplot(normalDensity)+
  ##first layer adds bars
  geom_bar(aes(x=score, y=probability, fill = reject##colour you want to fill the bar with, using the variable you created "reject"
               ), stat = "identity")+
  scale_fill_manual(
    values = c(
      `TRUE` = "red",
      `FALSE` = "darkgrey" ##this is how to change colours
    )
  )+
  geom_vline(xintercept = joe, col = "blue")+ ##adding vertical line, geoms stands for geometry
  theme(legend.position = "none")

plot(normalplot)
##you can see the normal distr of all possible values, with a certain mean and sdev, in red all cumulative prob
##that are below 0,05, or your specific significance level


## if we consider the sum of the probabilities of all the scores higher than
## our student, we obtain

sum(
  normalDensity$probability[normalDensity$score>=joe]
)
##which is 12 percent of your students that would perform better (in a normal distr)

### for a proper test statistic we compute a relative standing
### using a z-score, which in this case would be

z_score = (joe - pop_mean) / pop_sd


## the p-value is then calculated as the proportion of probability
## equal or above the z-score of our single measure
## on a default normal distribution (i.e. mean = 0 and sd = 1)
##pnorm gives you cumulative probability, in this case is related to the zscore

pnorm(z_score, lower.tail = FALSE)

##0,10 just based, means that the prob of having this event is 10%ish

##pnorm to get the cumulative distr of the standard distr, in this case of all values above 30


## roughly it still represents the proportion we have seen above



###############################################
## why z-score plotted on a normal dist?
##############################################

## our null hypothesis is NOT the distribution of scores
## but the distribution of z-scores
## we can compute it as below:

## pack z-score calculation in a function

zcalc <- function(x){
  z = (x-pop_mean)/pop_sd
  return(z)
}


## create a tibble with real scores (not their probability)
## drawn out of the same normal distribution, from a random sample and get the z score for each of these

exam_sample = tibble(
  scores = rnorm(2000, mean = pop_mean, sd = pop_sd)
) %>%
  mutate(
    zscore = zcalc(scores) ## then we calculate the z-score of each exam score (out of 2k)
  ) %>%
  arrange(zscore)

## we can plot it, and measure against our z-score

zplot = ggplot(exam_sample)+
  geom_bar(aes(x=zscore), stat = "density")+
  geom_vline(xintercept = z_score, col = "red")##on Joe's zscore

plot(zplot)

### if we plot the two one below the other we can see they're distributed in a pretty
### similar way

library(gridExtra)
grid.arrange(normalplot+xlim(10,38), zplot, nrow=2)

