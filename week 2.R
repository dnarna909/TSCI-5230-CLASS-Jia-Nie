#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'
inputdata <- "E:/2021-03-26 Bulk Fat RNAseq/Subjects with Clamp Infor and All Infor.RDS"
debug <- 0;
knitr::opts_chunk$set(echo=debug>0, warning=debug>0, message=debug>0);

#' Load libraries
library(GGally);
library(rio);
library(dplyr);
library(pander);
library(synthpop);
#' Here are the libraries R currently sees:
search() %>% pander();
#' Load data
dat0 <- import(inputdata);
dat0 <- dat0 %>% select(1:15)
dat0 <- dat0[1:15,]
#' Make a scatterplot matrix
ggpairs(dat0);
#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0
               , across(where( function(xx) length(unique(xx))==2), as.logical));
#' Now try the scatterplot matrix again
ggpairs(dat1);
source('C:/Users/niej/Desktop/2021-08-23 Certificate in Biomedical Data Science/TSCI 5230 Analytical Programming/TSCI-5230-CLASS-Jia-Nie/data.R')

# If 
#' in CMD
# git config --global user.email "you@example.com"
# git config --global user.name "You name"


da0cb <- codebook.syn(dat0)

# Change Character to Numeric 
dat0[1:10, "HT"]
as.numeric(dat0[1:10, "HT"])
as.numeric("Jia")
subset(dat0, is.na(as.numeric(HT)))

# creat a synthetic version
dat0 <- dat0 %>% select(!"DATE")
dat0s <- syn(dat0)
View(dat0s$syn)
class(dat0s$syn)
compare(dat0s, dat0)
export(dat0s$syn,"sim_data.csv")
