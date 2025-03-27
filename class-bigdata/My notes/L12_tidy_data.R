
## load simple data
table_colvars = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L12_tidy_eda/L12_dataset_table-colvars.rds"))
table_diffvars = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L12_tidy_eda/L12_dataset_table-diffvars.rds"))

## inspect the dataset, there s some shit about it
table_colvars

# use pivot_longer() to compress the tibble
table_colvars %>%
  pivot_longer(
    cols = c(`2020`:`2022`),#columns that you want to transform, if you put numbers as name of variable you have top use diagonal codes
    names_to = "year",
    values_to = "cases"
  )


## inspect a different dataset, the problem here is that count has to stay in a single column
table_diffvars

## use pivot_wider()
table_diffvars %>%
  pivot_wider(#where you take the names from
    names_from = type,#from ehich column you take values
    values_from = count
  )
#

###########################
## more complex example


## load genotype data and samples metadata
genotypes = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L12_tidy_eda/L12_dataset_genotypes.rds"))
samples_metadata = readRDS(url("https://raw.githubusercontent.com/lescai-teaching/class-bigdata-2023/main/L12_tidy_eda/L12_dataset_sample_metadata.rds"))


## inspect them both, untransformed dataset. is the variable the variant or the individual? the individual is
## the guy you are whose variant you are recording
genotypes

## and metadata
samples_metadata

## to make data tidy we have 2 variables here, one is spread in columns
## genotype and individuals
## then we want to join this with the samples metadata to know who is our case, so you combine the 2 datasets

genotypes_long = genotypes %>%
  pivot_longer(
    !variant, #means you select every column except the one after the escl point
    names_to = "individual",
    values_to = "genotype"
  ) %>%
  left_join(
    samples_metadata %>% dplyr::select(individual, PHENO),
    by = "individual"
  )
#if you get

## to calculate a chi-square in a traditional way though we need the counts
## and we need them by each genotype which becomes our categorical predictor
## to use a chi square you would need a table, you have a tidy dataset
genotypes_count = genotypes_long %>%
  group_by(variant, genotype, PHENO) %>% 
  summarise(
    count = n()
  ) %>%
  pivot_wider(
    names_from = genotype,
    values_from = count
  )

### we can't have NA so we just set it to 0, if you don t have data you can t put 0, it means not counting any
genotypes_count[is.na(genotypes_count)] <- 0


genotypes_count

## this way we can calculate using the base R chisq.test:see why you need to remove groups

chisq.test(
  genotypes_count %>% filter(variant == "dis_0") %>% ungroup() %>% select(`0/0`,`0/1`,`1/1`)
)
