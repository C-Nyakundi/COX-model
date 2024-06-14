# COX-model
# Survival Analysis Project

This project demonstrates the use of survival analysis techniques, specifically Cox proportional hazards regression, to investigate the effect of various predictors on survival times. The analysis is performed using R, with a focus on examining the impact of ethnic group on the hazard of death.

## Table of Contents

1. [Installation](#installation)
2. [Data Preparation](#data-preparation)
3. [Running the Model](#running-the-model)
4. [Descriptive Analyses](#descriptive-analyses)
5. [Model Interpretation](#model-interpretation)
6. [Contributing](#contributing)
7. [License](#license)

## Installation

To run the analyses in this project, you need to install the required R packages. You can install them using the following command:

```R
pacman::p_load(ggplot2, tidyverse, forcats, dplyr, readxl, knitr, ggpubr, nortest, patchwork)
install.packages("survival")
install.packages("survminer")
```

## Data Preparation

First, import the dataset:

```R
g <- read.csv(file = "dataset.csv", header = TRUE, sep = ',')
```

## Running the Model

### Model 1: Ethnic Group as a Continuous Variable

```R
cox <- coxph(Surv(fu_time, death) ~ ethnicgroup, data = g)
summary(cox)
```

### Model 2: Ethnic Group as a Factor Variable

```R
ethnic_group <- as.factor(g[, "ethnicgroup"])
death <- g[, "death"]
fu_time <- g[, "fu_time"]

cox <- coxph(Surv(fu_time, death) ~ ethnic_group)
summary(cox)
```

## Descriptive Analyses

The following code performs descriptive analyses for key variables:

### Age

```R
hist(g$age)
summary(g$age)
shapiro.test(g$age)
```

### Gender

```R
library(knitr)
kable(table(g$gender, useNA = "always"))
prop.table(table(g$gender))
gender <- as.factor(g[, "gender"])
prop.table(table(gender))
```

## Model Interpretation

### Model 1 Interpretation

```R
cox <- coxph(Surv(fu_time, death) ~ ethnicgroup, data = g)
summary(cox)
```

- **Effect of Ethnic Group**: The coefficient for `ethnicgroup` is -0.04555, with an exp(coef) (hazard ratio) of 0.95547. This indicates that being in a different ethnic group slightly decreases the hazard of death, but this effect is not statistically significant (p=0.369).
- **Confidence Interval**: The 95% confidence interval for the hazard ratio (exp(coef)) ranges from 0.8651 to 1.055, which includes 1, suggesting no significant effect of `ethnicgroup` on survival.
- **Model Fit Statistics**: The concordance index is 0.514, indicating that the model's predictive accuracy is slightly better than random guessing. The likelihood ratio test, Wald test, and score (logrank) test all have p-values greater than 0.05, indicating that `ethnicgroup` is not a significant predictor of survival in this model.

### Model 2 Interpretation

```R
cox <- coxph(Surv(fu_time, death) ~ ethnic_group)
summary(cox)
```

- **Effect of Ethnic Groups**:
  - **ethnic_group2**: Slight decrease in the hazard of death (not statistically significant).
  - **ethnic_group3**: Significant decrease in the hazard of death (p=0.00362).
  - **ethnic_group9**: Slight increase in the hazard of death (not statistically significant).
- **Model Fit Statistics**:
  - **Concordance**: 0.516
  - **Likelihood Ratio Test**: p=0.005
  - **Wald Test**: p=0.04
  - **Score (Logrank) Test**: p=0.02
