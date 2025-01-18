## Overview
In this project, time to hospitalized pneumonia in young children was analyzed to see whether the number of siblings affects infants to have hospitalized pneumonia in the first year of life. The effects of any additional significant factors discovered during the analysis were also studied.

## Data Description
The data was collected from annual personal interviews conducted as part of the National Longitudinal Survey of youth from 1979 to 1986 and has variables that can be used to analyze time to hospitalized pneumonia in young children. There are 3470 observations and 15 variables. Out of 3470, 3397 are censored and 73 are uncensored.

## Steps
1. Data cleaning and preparation (R)
2. Exploratory Data Analysis (R)
3. Model Building and Evaluation (SAS)
   - Employed Kaplan-Meier Estimation to study the relationship between the survival time and predictors.
   - Built a Cox proportional hazards model that describes the effects of significant predictors on the hazard rates.
   - Computed Harrell’s C-statistic and time-dependent ROC curves to assess the predictive accuracy of the model.

## Files
- `pneumon_EDA.qmd`: R script for data processing and exploratory data analysis.
- `pneumon_Model.sas`: SAS code for model building and evaluation.
- `pneumon.csv`: Raw dataset used as input.
  


