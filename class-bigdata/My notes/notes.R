STATISTICAL INFERENCE
making deductions, population is the whole package, you use samples to get info on the pop

Estimation: estimating the population mean through the sample mean (with an error), statistic info taken from the sample
- point est <- single number to use a population parameter
- interval est <- 2 values to estimate, a pop parameter is within that interval (with a level of confidence)

standard error:the smaller the sample you work with, the higher the error (standard dev/squared root of sample)
also, 1,96StandError gives you the confidence interval

HYpo testing: first, you need to define a few things
H0 <- null hypo, what would happen if your alternative hypo was FALSE
Ha <- alternative hypo, what you are testing for
test statistics <- es. p value
significance level <- what is the value from which I draw the threshold for the rejection on null hypo (usually 0,05)
it is your personal decision to put it this value

P-VALUE:
the percentage of risk you are willing to take in order to reject H0 (the lower, the less error you are willing to accept)

having a given distribution, everything that lies below the curve represents possible values for your z score.
In this way, given a certain z-score value you have  all the possible values that are above or below (??)

in the normal distribution in the slides: p-value is the proportion of values that are above my z-score 
probability because it is referring to the frequency in the whole population
so, you can say that it is a probability because it represents how much it is probable that I find
higher values than my z-score (if H0 was true, which is the risl that i prepare to accept)

R DEMO (see from z score to p value file)

HOW YOU GO FROM ZSCORE TO P-VALUE?

  how to make hypothesis:
  1-decide what you are testing and the test statistics you use (i.e zscore)
  2- Null hypo (H0)
  3-significance level
  4-collect and sort theme
  5-decision
  
TYPES OF ERROR 
when you compare your test with reality:
  type 1 or false positive: reject H0 (cause your result is in line with the Ha but the H0 is still true, and you reject it)
  type 2 or false negative: accept H0 (for your test) but it is infact false (you lack some things for the whole picture)
  

MULTIPLE TESTS:
cause you re doing multiple hypotheses for multiple tests ran 
total hypo <- m
total true H0 <- m0
total false H0 <- m-m0

family wise error rate:
  chance of getting a false positive out of your multiple hypo
(1-alpha)^m0 is the chance that you don t reject any H0   

i.e you re looking for a relative, you have a database of 800k people and an error of 1e6
you get a 55% chance of getting at least one wrong match

m0 is our total true H0s, m is total hypotheses

CORRECTING REJECTION LEVEL

Bonferroni: divide alpha/m= you get rejection level per each H0 (you divide the family error by every test)
worst possible scenario, way too harsh as a correction

Benjamini_Hochberg:estimates what the family error rate could be

Q-Q plot:visual inspection of tests results
quantile divides the data into equal groups, in a normal distr it means that each group has elements that have the same probability of observing a value
start plotting
y axis: your data set quantile
x axis: your normal distr quantile (they are different)

a straight line would be the ideal distribution for your quantiles (in said disttribution), the more your actual values differ from it, 
the more likely it is that your data isn t normally distributed

for the normal distr quantile: you divide each sample quantile by the number of p values for the normal distr

in a normal distribution your slope should be linear, if you use a q-q plot you can see how much your data fits into it
above the line: too much or too few significance values (false positives in the former and no good test for the latter)


SIMULATION DESIGN
5020 variants (genetical, not statistics), where 5000 thousand were neutral, 20 were related to the disease
simulate 1000 controls and 1000 cases (each one with 5020 variants tested)
10,038,000 data points
calculated the p value for each value (for the association disease)

always test for multiple tests, but be careful when applying correction methods (Bonf and BH)


INFER WORKFLOW
every time you take a sample out of your pop you will always have different estimates

RESAMPLING PROCEDURES: 

Bootstrapping: taking, out of a single population, multiple samples and for each of them you take the statistics that you want and distribute them
to get the confidence interval (resampling from a larger pop)
you can use the same samples over and over
i.e enrichment analysis, general pop = all genes in genome, each time you get a sample that can contain similar elememts (good for p-value)

Permutation: random shaffling of your sample and each time you get a randomic sample, plot them + you original sample and get the 
p-vakue out of that (resampling from the same sample, just shaffling the labels.
here you can t resample the same sample over and over again, good fro qhen you don t have a large pop to work with
you re not estimating shit out of the general population, you can just estimate things out of that sample
each time you have the SAME ELEMENTS, you just changes the gìthings they are associated to (no replacement)

remember: frequency is out of your sample (can be measured) distribution is osmething of the general population
that you try to obtain 


empirical distribution: is when you create your own distr out of your data, you create a null distr that represents the characteristics 
of your own data, so you don t have to choose a theoretical distr that could fit your data

SEE HOW YOU CREATE A NULL DISTRIBUTION
you started with a starting test statistics and you created your own null distribution out of it 


WORKFLOW
infer is a tidyverse package
take data, specify() to descibe relationship with your hypothesis, generate null hypothesis (H0), generate() the empirical distr
calculate() to use the test statistics (out of sample or out of each of the permutations), visualize and get p-value

infer has an easier language. response = dependent variable, outcome  explanatory = independent, generates the responde variable



26/03
wooclap for all the stastistical tests

fisher tests is useful for large numbers, it is pretty much like chi square

DATA CYCLE

Importing data in a prgramming env
shape your data to represent the phenomen you ve been measuring (tidydataset, in the right form)
visualization to represent your data
transformation of data to have it in the right form (changing scale, making variable comparable)


IMPORTING DATA (tidyverse package)
functions like "read_data-type(this one changes according to what you want to visualize")


NIMBUS DATA SET
see code


EXPORT
the functions are all like write_data-type
write_csv,nimbus,file = "nimbus_copy.csv" (check what it does)

shows all packages that can let you export files from other programs
arrow package and duckdde (check them through library)

DATA TRANSF
Factors:representation of categorical data, that is not just a vector of characters, it specifies
a set of values among an ordered listof all possible values the vector can take

you get a list of unique names and associate them with numbers?? less space memory
levels= the ordered list of unique values the categories can have (you can choose your own order, otherwise you get alphabetic default)


SEE CODES:
  
  
DPLYR pack
see some functions


27/03
how to create tibbles with another way -> tribble
and how to join tables

TIDY DATA AND EXPLORATIVE DATA ANALYSIS

tidy if each variable has its own column and each case/record has its own row, each value its own cell
i.e diameter of the cell measured, entity is always diameter so only need 1 column
never put blank spaces in names, cause it refers to separation of 2 objects

WHAT IS EDA?
exploratory data analysis, it usually sparks more questions than anything

-varaitions within the variable, like spread, differences in groups, causse a variable HAS to be different accross multiple samplings
-covariation, if 2 variables are highly correlated then you could use either of them to describe the same thing

so when do you decide to remove one or another? if you re doing an extremely fine analysis then you could consider using them both

1/04
DATAMODELING

a model is a tool tha describes something, a system with variables. Inferential statistics (alr done)is based on models
through package infer
predictive model uses your data to make predictions on it, package tidymodels.

you can use tests to check how your model predicts things based on your data (anova)

SUPERVISED: outcome variable (means that guides you, gives you instructions ecc). In this case the outcome is the supervisor
they describe how the model generates outcomes, according to the nature of the out. i.e linear regression

-regression: predict a numeric outcome. regression as i... you will see
- classificarion: categorical outcome (ordered or not)




UNSUPERVISED: no outcome, no supervisor. They don t predict much, they just realaborate what you already have 
i.e PCA, means clustering



back to data life cycle, now we are at the modeling part

modeling process follow these steps:
EDA exploratory data analysis -> feature engineering (anything you do to tranform your data)
model tuning (polishes parameters of the model in a systematic way)
evaluation that check how good the model is in predicting.

OVERFITTING: means that your model is way too good on just the data you are working with, and does shit with other data, there are ways to check it
by tuning it on random sets of data


DATA SPENDING
treat it like a budget, with a training + validation, also tests the model on unseen data (), but you validate the performance in testing
(builds the model) and keep aside some of it to test it
the more you train the more you overfit, that s why you have the testing data, and it has to be done ONLY AT THE VERY END
cause your model will be finished 

STRUCTURE OF THE MODEL
type, then engine (the mathematical methods you use to solve the equations), mode (the purpose of the model, like classification or regression)
model fitting (done with training data) and use it to make predictions on the testing data, then you can have evaulation scores to
see how your model does with your data (thanks to the testing data)


FITTING MODEL

linear regression on data, the fitting is finding the line that best gets close to the data you have
(general equation -> fit into an equation with numerical parameters that try to fit your data, with num parameters)
give me an examle of a model: use an equation and substitute the numbers, predictors are like the independent variables

why is it a supervised model? you want to get a certain x value, and you already have both the REAL y (the actual value from your sample)
and the predicted Y (the one that should lay on the fitting model). You can also chek the residual, which is the difference between the real and fitted Y)

DECISION TREE: splits data according to every decision you make, random cause you have randomly set up predictors according to how many you have (and make a final classification prediction)


DATA SPENDING: initial split to set the criteria with which you will split your data and then trainign and testing
verbs:
  type(of your data), it means one function that correspond to the type of model you are choosing, you substitute the type with your function
  set_engine
  set_mode
  

  check R
  
2/04

  
LINEAR MODEL: (predictor can generate an effect on the outcome by summing) because it s additive (straight line with multiple dimensional systems, with multiple coordinates), can be summarised with 
NON-LINEAR: non additive terms, cause they are positioned as exponential, logaritmic.
Interaction betweeen multiple elements (a:b means all possible combinations of these 2 values) + you could have the combined effects of summation and more complex predictors
like when you have a good fit for the most part with a linear model but you get non linear relation towards the extreme values

K-NEAREST NEIGHBOURS (KNN)
multiple modes. you have data and want to classify it, you could classify it by relating to the closest neighbours and assume that it is the same class as the majority of its neighbours
k= how many neigh you consider, you often don t know ehich k you have to use

used for both regression and classification, it s a non parametric method because you can t rely on a distr, you just look at the closest datapoints


RANDOM FOREST reccap
how you get a numerical outcome when you have discrete, the more your data is split and the smoother the outcome, better with non linear data
you need a confidence interval 
check code


HOW TO EVALUATE YOUR PERFORMANCE (for plot)
mentioned the residual (loss function), your objective is to minimize it, used to calculat e performance


MAE: mean absolute error, calculate the absolute value of the error and divide by the number of your samples
RMSE: root mean squared error root of your squared error, divide by sample, why do you need both? here you square to give higher weight to higher residuals, extreme errors are highlighted
RSQ: r squared score, 1 - dividing the squared error by the squared variance (i-prediction)

ideal values: 0, 0, 1(cause means that your model error is the same as your sample)



see reaction scheme: 3 enzymes with 3 reaction rates,2 intermediate products and 1 final product

FEATURE ENGINEERING
transforming the predictor values so is esasier to predict the relation (through the model). keep variances

transformation: compute values, numerical calculations (normalisation= scaling and centering), calculate new features (done with mutate())
Encoding: representing data, if you have 3 genotypes you could represent them through 0,1,2 (from categorical to numerical)


NORMALIZATION (scale and center)
a variable will have mean=0 and sd=1, not every variable is identical, you just don t compare the predictors based on THESE two aspects, so you just comoare the effct of that predictor on the outcome
like having x (0:1) and x2 (0:1000), 

centering: subtract the mean 
scaling: center divided by sd



SPLINES AND NON LINEARITY
transform data to model the predictor with a model equation, so a variable is converted into a polynomial term
just use the flexi and of course they won t be a perfectly linear model, you just get a good interval in which you can work with that model
fit simpler regression model into complex data



FEATURE SELECTION

select which predictors to used based on your model. two variables that identically covary they will summate their effect, one of them doesn t add any additional information, you could exclude that


REVISE LECTURE 3/04
SUPERVISED MODEL

8/04
UNSUPERVISED MODELING: PCA and custering

dimensionality reduction: number of variables used to describe data, high dimensional space -> many variables
each variable is a dimension, you use dimensionality redcuction to visualise data on plot 
you have to find the variables that vary the most,to understand the direction of your data

PRINCIPAL COMPONENT ANALYSIS (PCA) a redcuction method

is still a data transformation, through simple mathematical operations
principal components are linear transformation of your data, cause you project your data on a different space

find the center of your data and find a line where the projection of you data better describe the variation of the data themselves (like how they vary according to the center)

this is not a linear regression, cause you are not using a method of list squared, you are maximizing the variance
in the linear you want to minimize the difference between the outcome and the predicted value. in PCA you maximize because ???
multiplying your vector by a scalar vector, cause you don t change its direction, just scale 
the Eigen vector is orthogonal to all other Heigen vectors (they have correlation 0, so you capture completely different variances along these 2 lines)


the new predictors are obtained through their original value multiplied by their weight, adn you get the new PRINCIPLE COMPONENT

you start eith your original dataset, you have p predictors and n observations, you take out of p only a few of them (k), see the matrix that you get

each eigen vector has a lambda that shows how mucht of the original values is represented


CLUSTERING
finding common properties between observations (in cases when you don t know the similarities)

it adds a new categorical variable, finds something that you don t see in your data, explaining how some observations are correlated with each other

-partitional: separetes the data to some axis of variation
-hierarchical: bottom up
-model-based: based on some kind of description of your data

similarity -> distance 


GEOMETRIC DISTANCE:
the one that is plotted

Euclidean distance -> distanza tra due punti, the more similar 2 values (points) are, the more similar they will be

you have many types of distance, like Pearson that gives you how similar teh variation of the trend is


HIERARCHICAL DISTANCE
the closer the more similar (no shit). you form some pairs of proximity and check which pair is the most similar and add the next more similar
single linkage: distance between 2 groups is the distance between the 2 most close elements
complete linkage: between the 2 most distant values
ward method: center of each group and measuring the distance between each group

example. heat map


K-MEAN CLUSTERING (remin k nearest neighbors) k for clustering, the initial k is not relevant for the final clusters

from a scatter plot, place randomly some center point (centroids),you assume that in your data you have k nymber of clusters (assumption)

you clusters will be formed with data points being assigned to the nearest centroid. These new clusters will have new centers and then recompute the data again and again,
until these centroids will be closer and closer

MEASURING PERFORMANCE
within cluster sum-of-squared error (WSS) how spread the cluster is compared to its cluster
total sum of squared errors (TSS) distance of all obs from the global centroid
ratio wss/tss the smaller the more the data in these clusters are near each other




9/04
prediction model
It could be a supervised model, correlation
feature engineering: kinase inhibitor and gene expr in correrlation rank order
they worked with missing concentrations and filled some gaps to join data 
they used static datasets, no continous values for gene concentrations, so not the effect of the inhibitor to the gene expression

model benchmarking, compare models with each other

XGBoost and gradient:
training is done by minimizing the loss
learning: how much a model fits the data, how quickly it fits to the data (could lead to overfitting, too much fitting for that data, doesn t perform well with other data)
gradient is the multidimensional complex, you get its minimum by getting a vector of all partial derivatives of all the parameters of that..
XGBoost is a sequence of decision tree that is used to minimize the loss, used in a sequential way, optimizes and sends to another optimization tree (gradient XBoost)




