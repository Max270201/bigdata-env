
variant_analysis = readRDS##function to read R native data
(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L06_hypothesis_testing/L06_multiple_testing_dataset_variants.rds"))

##you have 4 columns:
## 1 is the variant
## ran a chisquare test



variant_analysis = variant_analysis %>%
  mutate(
    false_discovery = case_when(
      annotation == "associated" & pvalue < 0.05 ~ "true_positive",
      annotation == "associated" & pvalue >= 0.05 ~ "false_negative",##cause you set the variant as associated but your test said it wasn true
      annotation == "neutral" & pvalue < 0.05 ~ "false_positive",##cause you got a significant result even though you set it as neutral
      annotation == "neutral" & pvalue >= 0.05 ~ "true_negative",
      TRUE ~ NA
    )
  )
## adding a variable called false discovery, case_when() means that you create a variable based on a condition 
##everything before the ~ is the condition, after that you use the value if the condition is true
##if none of them is true than set the value as NA



### how many p values significant now? 
length(variant_analysis$pvalue[variant_analysis$pvalue < 0.05])##to check how many of them are below pvalue
##you got 281, even though you associate 20 associated values

qqplot <- ggplot(variant_analysis, aes(sample = -log10(pvalue))) +
  stat_qq() +
  stat_qq_line() +
  xlab("Theoretical Quantiles") +
  ylab("Sample Quantiles") +
  ggtitle("Q-Q Plot of P-Values")

qqplot

##out of this qq plot you get way too many significant values at the right extreme end, those extremely detached values
##is where your significant values are, but those before that slightly deviate from the line are false positives


### we want to colour the variants but
### we do not want to separate the groups 


variant_qq_data = cbind(
  variant_analysis, 
  setNames(qqnorm(-log10(variant_analysis$pvalue), plot.it=FALSE), c("Theoretical", "Sample"))
  )

ggplot(variant_qq_data) + 
  geom_point(aes(x=Theoretical, y=Sample, colour=false_discovery))+
  scale_color_manual(
    values = c(
      "true_positive" = "#E31A1C",
      "false_negative" = "#FB9A99",
      "false_positive" = "#A6CEE3",
      "true_negative" = "#1F78B4"
    )
  )


table(variant_analysis$false_discovery) ##this one makes a table based on the counts of certain values

######################################
## CORRECTING PVALUE WITH BONFERRONI
######################################

variant_analysis = variant_analysis %>%
  mutate(
    pvalue_corrected = p.adjust(pvalue, method = "bonferroni")
  ) %>%
  mutate(
    false_discovery_corrected = case_when(
      annotation == "associated" & pvalue_corrected < 0.05 ~ "true_positive",
      annotation == "associated" & pvalue_corrected >= 0.05 ~ "false_negative",
      annotation == "neutral" & pvalue_corrected < 0.05 ~ "false_positive",
      annotation == "neutral" & pvalue_corrected >= 0.05 ~ "true_negative",
      TRUE ~ NA
    )
  )
  


## how many significant now?
length(variant_analysis$pvalue_corrected[variant_analysis$pvalue_corrected < 0.5])

##you got 15 significant variants, similar to your 19 

qqplot_corrected <- ggplot(variant_analysis, aes(sample = -log10(pvalue_corrected))) +
  stat_qq() +
  stat_qq_line() +
  xlab("Theoretical Quantiles") +
  ylab("Sample Quantiles") +
  ggtitle("Q-Q Plot of Corrected P-Values")

qqplot_corrected


variant_qq_data_corrected = cbind(
  variant_analysis, 
  setNames(qqnorm(-log10(variant_analysis$pvalue_corrected), plot.it=FALSE), c("Theoretical", "Sample"))
)

ggplot(variant_qq_data_corrected) + 
  geom_point(aes(x=Theoretical, y=Sample, colour=false_discovery_corrected))+
  scale_color_manual(
    values = c(
      "true_positive" = "#E31A1C",
      "false_negative" = "#FB9A99",
      "false_positive" = "#A6CEE3",
      "true_negative" = "#1F78B4"
    )
  )

table(variant_analysis$false_discovery_corrected)



################################################
### CORRECTING WITH BENJAMINI HOCHBERG #########
################################################


variant_analysis = variant_analysis %>%
  mutate(
    pvalue_corrected = p.adjust(pvalue, method = "BH")
  ) %>%
  mutate(
    false_discovery_corrected = case_when(
      annotation == "associated" & pvalue_corrected < 0.05 ~ "true_positive",
      annotation == "associated" & pvalue_corrected >= 0.05 ~ "false_negative",
      annotation == "neutral" & pvalue_corrected < 0.05 ~ "false_positive",
      annotation == "neutral" & pvalue_corrected >= 0.05 ~ "true_negative",
      TRUE ~ NA
    )
  )



## how many significant now?
length(variant_analysis$pvalue_corrected[variant_analysis$pvalue_corrected < 0.5])

##you got 37 out of your original 19

qqplot_corrected <- ggplot(variant_analysis, aes(sample = -log10(pvalue_corrected))) +
  stat_qq() +
  stat_qq_line() +
  xlab("Theoretical Quantiles") +
  ylab("Sample Quantiles") +
  ggtitle("Q-Q Plot of Corrected P-Values")

qqplot_corrected


variant_qq_data_corrected = cbind(
  variant_analysis, 
  setNames(qqnorm(-log10(variant_analysis$pvalue_corrected), plot.it=FALSE), c("Theoretical", "Sample"))
)

ggplot(variant_qq_data_corrected) + 
  geom_point(aes(x=Theoretical, y=Sample, colour=false_discovery_corrected))+
  scale_color_manual(
    values = c(
      "true_positive" = "#E31A1C",
      "false_negative" = "#FB9A99",
      "false_positive" = "#A6CEE3",
      "true_negative" = "#1F78B4"
    )
  )

table(variant_analysis$false_discovery_corrected)
