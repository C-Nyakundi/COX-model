

## Installing the required packages 
pacman::p_load(ggplot2, tidyverse, forcats, dplyr, readxl, knitr, ggpubr, nortest, patchwork)
library(survival)
library(survminer) # plotting functions for survival analysis

# Importing the dataset
g <- read.csv(file = "dataset.csv", header = T, sep = ',')


# Running the model 
cox <- coxph(Surv(fu_time, death) ~ ethnicgroup, data = g) # take variables straight from g
##( We used ethnic group as a continous variables)

# The code creates a survival object using the `Surv` function, which combines the follow-up time (`fu_time`) and the event indicator (`death`). 
# It specifies `ethnicgroup` as the predictor variable, examining its effect on the hazard of death. 
# The `coxph` function fits a Cox proportional hazards regression model to explore the relationship between survival time and `ethnic group` using data from the dataframe `g`.

summary(cox)


## (Running ethnic as a factor variable)

### Creating vectors of (Ethnic group, death, follow up time)
ethnic_group <- as.factor(g[, "ethnicgroup"])
death <- g[, "death"]
fu_time <- g[, "fu_time"]

### Re-running the model 
cox <- coxph(Surv(fu_time, death) ~ ethnic_group)
summary(cox)


# Running descriptive analyses for these variables:(Age, Gender, Prior OPD appointments missed (“prior_dnas”), Ethnic group, COPD (chronic obstructive pulmonary disease))

## Age
hist(g$age)
summary(g$age)
shapiro.test(g$age)

## Gender 
kable(table(g$gender, useNA = "always"))
prop.table(g$gender)
gender<- as.factor(g[, "gender"])
prop.table(gender)
