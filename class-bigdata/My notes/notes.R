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
  
Hypo rejection
pvalue region is where H0 is true (you accept it), the blue one

multiple tests:
  cause you re doing multiple hypotheses

family wise error rate:
  chance of getting a false positive out of your multiple hypo
(1-alpha)^m0 is the chance that you don t reject any H0   m0=total sample

i.e you re looking for a relative, you have a database of 800k people and an error of 1e6
you get a 55% chance of getting at least one wrong match

m0 is our total true H0s, m is total hypotheses

CORRECTING REJECTION LEVEL

Bonferroni: divide alpha/m= you get rejection level per each H0 (you divide the family error by every test)
worst possible scenario, way too harsh as a correction

Benjamini_Hochberg:estimates what the family error rate could be

Q-Q plot:visual inspection of tests results
order p values from smallest to highest, I think you expect to have one pvalue per quantile
it shows you how much you differ from the normal distr, you either have a lot of significance values (many false pos)
or too few (less than what is expected)

you geta  straight line that comrpises all your expected values


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








