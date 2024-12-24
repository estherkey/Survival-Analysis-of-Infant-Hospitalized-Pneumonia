## Abstract
Pneumonia remains a significant cause of childhood mortality globally. This project investigates the impact of various factors on the risk of hospitalized pneumonia in young children, focusing particularly on the influence of the number of siblings. Data from the National Longitudinal Survey of Youth (1979-1986) were utilized, comprising 3470 observations, with 3397 censored and 73 uncensored cases. Kaplan-Meier estimation and Cox regression modeling were employed to analyze the survival time to hospitalized pneumonia, with 'nsibs' (number of siblings), 'wmonth' (breastfeeding duration), and 'smoke' (maternal smoking during pregnancy) identified as significant factors. The findings indicate that for each additional sibling, the risk of hospitalized pneumonia increases by approximately 37.8%. Moreover, each additional month of breastfeeding was linked to a reduction in risk by about 20.2%, whereas maternal smoking during pregnancy was associated with an increased risk of pneumonia in children by approximately 47.3%. These findings underscore the importance of public health interventions focused on hygiene promotion, indoor pollution reduction, encouraging breastfeeding and discouraging maternal smoking during pregnancy, which may play a vital role in mitigating the burden of pneumonia in children.

## Data Description
The data was collected from annual personal interviews conducted as part of the National Longitudinal Survey of youth from 1979 to 1986 and has variables that can be used to analyze time to hospitalized pneumonia in young children. There are 3470 observations and 15 variables. Out of 3470, 3397 are censored and 73 are uncensored.

## Research Objective
In this project, time to hospitalized pneumonia in young children was analyzed to see whether the number of siblings affects infants to have hospitalized pneumonia in the first year of life. The effects of any additional significant factors discovered during the analysis were also studied.
The observed survival time is from birth to age the child is in the hospital for pneumonia; hence, the variable ‘agepn’ was used as survival time. The variable ‘hospital’, which is an indicator for hospitalization for pneumonia was used as a status variable.
Nonparametric tests were used to identify significant covariates for survival time. Semiparametric model was built to describe the relationship between the variable of interest ‘nsibs’, other covariates, and survival time, and a final fitted equation to predict the survival time was provided.



## Overview
In this project, time to hospitalized pneumonia in young children was analyzed to see whether the number of siblings affects infants to have hospitalized pneumonia in the first year of life. The effects of any additional significant factors discovered during the analysis were also studied.

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
  


