
#'---
#' title: "[TRIPOD 1] Identify the study as developing and/or validating a multivariable prediction model, the target population, and the outcome to be predicted."
#' author: 'Author One ^1,✉^, Author Two ^1^'
#' abstract: |
#'  | [TRIPOD 2] Provide a summary of objectives, study design, setting, participants, sample size, predictors, outcome, statistical analysis, results, and conclusions.
#' documentclass: article
#' description: 'Manuscript'
#' clean: false
#' self_contained: true
#' number_sections: false
#' keep_md: true
#' fig_caption: true
#' ---
#' 
#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'
debug <- 0;
knitr::opts_chunk$set(echo=debug>0, warning=debug>0, message=debug>0);

library(rio);
library(dplyr);
library(pander);

inputdata <- c(dat0='sim_data.RDS');
if(file.exists('local.config.R')) source('local.config.R',local=TRUE,echo=FALSE);
dat0 <- import(inputdata['dat0']);


# vignette('dplyr')
#' This will be interpreted as text
#' 
#' # Rows 
#' 
#' ## filter
filter(dat0, STUDY == "ERIT 2")
#' Using pander to format table, special show in compile file
filter(dat0, STUDY == "ERIT 2") %>% pander
#' pander with additional options
filter(dat0, STUDY == "ERIT 2") %>% pander(split.tables=Inf, split.cells=Inf) # or set to number for the column splitting
#' ## slice
slice(dat0, 1:15)
dat0[1:15,]
dat0 %>% slice(1:15) # show 1:15 rows
dat0 %>% slice_head(n=15) # show top 15 rows of the data
dat0 %>% slice_tail(n=15) # show bottom 15 rows of the data
dat0 %>% slice_head(prop = 0.1) # show top 10% of the data
#' Using pander to format table
dat0 %>% slice(1:15) %>% pander(split.tables=Inf, split.cells=Inf)
dat0 %>% slice_head(n=15) %>% pander(split.tables=Inf, split.cells=Inf)
dat0 %>% slice_head(prop = 0.1) %>% pander(split.tables=Inf, split.cells=Inf)

slice_sample(dat0, n = 5, replace = TRUE)
?slice

#' ## arrange
arrange(dat0, Gender, STUDY, desc(WT))
arrange(dat0, Gender, STUDY, desc(WT)) # desc() descending order
class(dat0$WT)
summary(dat0)
dat0$WT <- as.numeric(dat0$WT)
arrange(dat0, Gender, STUDY, desc(WT)) 
#' 
#' 
#' 