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



