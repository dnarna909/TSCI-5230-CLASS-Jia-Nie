#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'
debug <- 0;
knitr::opts_chunk$set(echo=debug>0, warning=debug>0, message=debug>0);


#' Load libraries
library(GGally);
library(rio);
library(dplyr);
library(pander);
library(synthpop)
#' 
#' 

#' You coding start from here
#' Here are the libraries R surrently sees:
search();
search() %>% pander();
#' Load data
library(rio)
dat0 <- survival::veteran; 
#' export(dat0, 'example_file.xlsx')
dat0 <- import('example_file.xlsx')
#' Make a scatter plot matrix
ggpairs(dat0)
unique(dat0$status)
class(dat0$status)

dat0$status != 1 
unique(dat0$prior)

dat0$prior > 0

which(dat0$prior == 1) == TRUE

dat0$new <- dat0$status == 1
dat0$status <- dat0$status == 1
ggpairs(dat0)

#' ? dplyr

#' set all the two value colums to be TRUE/FALSE
dat1 <- mutate(dat0, across(where(function(xx) length(unique(xx)) == 2), as.logical))


