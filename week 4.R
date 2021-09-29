#'---
#' title: "[TRIPOD 1] Identify the study as developing and/or validating a multivariable prediction model, the target population, and the outcome to be predicted."
#' author: 'Jia Nie ^1, Author Two ^1^'
#' abstract: |
#'  | [TRIPOD 2] Provide a summary of objectives, study design, setting, participants, sample size, predictors, outcome, statistical analysis, results, and conclusions.
#' documentclass: articl'"
#' date: " `r Sys.Date()``
#' description: 'Manuscript'
#' clean: false
#' self_contained: true
#' number_sections: false
#' keep_md: true
#' fig_caption: true#' 
#' css: "`r library(here); here('production.css')`"
#' #' css: `production.css`
#' output: # To include in the header of your script
#'   html_document:
#'    code_folding: hide
#'    toc: true
#'    toc_float: true
#' ---
#'
#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'

debug <- 0; # set 1: showing warning, or informations; set -1: only results, no coding;
knitr::opts_chunk$set(echo=debug>-1, warning=debug>0, message=debug>0);
#' Load libraries
library(GGally);
library(rio);
library(dplyr);
library(pander);
library(broom);
#library(synthpop);
#' Here are the libraries R currently sees:
search() %>% pander();
#' Load data
inputdata <- c(dat0='sim_data.csv');
if(file.exists('local.config.R')) source('local.config.R',local=TRUE,echo=FALSE);
dat0 <- import(inputdata['dat0']);
#' Make a scatterplot matrix
ggpairs(dat0);

#' # Using `pander`
#'
#' The `pander()` command helps show tabular (and other) data in a more readable
#' manner. It's optional if you're working in the R console, but if you are also
#' preparing reports from those same scripts (which we are in this class) then
#' it makes a big difference. In most of the examples here we will use `pander`
#' with the following syntax:
#+ panderexample, eval=FALSE

# Standalone
pander(dat0,split.tables=Inf, split.cells=Inf);

# As part of a pipeline of data transformation commands
head(dat0) %>% pander(split.tables=Inf, split.cells=Inf);

#' # Using `dplyr` to transform data
#'
#' ## Row Operations
#'
#' ### `filter`
#'
#' `filter()` selects rows that meet a set of criteria you specify.
#+ filter01
filter(dat0, time > 70 & celltype=='adeno') %>% pander(split.tables=Inf, split.cells=Inf);
#' ### `slice`
#'
#' The following two statements return the same result:
#+ slice01
# Show rows 2 through 6
slice(dat0, 2:6) %>% pander(split.tables=Inf, split.cells=Inf);
dat0[2:16,] %>% pander(split.tables=Inf, split.cells=Inf);
dat0 %>% slice(2:6) %>% pander(split.tables=Inf, split.cells=Inf);
#' Show the top 6 or the bottom 6 rows, respectively. These are equivalent to
#' base R's `head()` and `tail()` commands when used with the `n` argument.
#+ slice02
dat0 %>% slice_head(n=6) %>% pander(split.tables=Inf, split.cells=Inf);
dat0 %>% slice_tail(n=6) %>% pander(split.tables=Inf, split.cells=Inf);
#' The `slice` family of functions can take a `prop` argument instead of an `n`.
#' This specified a proportion of the total rows rather than a fixed number.
#' For example, the top and bottom 10% of the data:
#+ slice03
dat0 %>% slice_head(prop = 0.1)  %>% pander(split.tables=Inf, split.cells=Inf);
dat0 %>% slice_tail(prop = 0.1)  %>% pander(split.tables=Inf, split.cells=Inf);
#' A _very_ useful function is `slice_sample`. It selects a random sample of `n`
#' or `prop` rows from your data.
#+ slice04
slice_sample(dat0, n = 5, replace = TRUE) %>% pander(split.tables=Inf, split.cells=Inf);
slice_sample(dat0, n = 5, replace = TRUE) %>% pander(split.tables=Inf, split.cells=Inf);
#' ### `arrange`
#'
#' `arrange` returns the same data frame but sorted on the columns you specify
#' in the arguments. For example, by `trt` and `celltype`:
#+ arrange01
arrange(dat0, trt,celltype) %>% slice_head(n=20) %>% pander(split.tables=Inf, split.cells=Inf);
#' You can wrap any of the arguments in `desc()` to make it sort from largest to
#' smallest instead of the default smallest to largest.
#+
arrange(dat0, trt,age,celltype) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
arrange(dat0, trt,desc(age),celltype) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);

#' ## Column Operations
#'
#' ### `select` and `where`
#'
#' Select extracts the columns of your choosing. The simplest way to do it is
#' by giving the unquoted, quoted, or back-quoted (` `` `) names of the columns
#' you want, each as a separate un-named argument. If your columns contain
#' spaces or punctuation marks, you have to quote or back-quote them. Here we
#' select three columns, one quoted, one unquoted, one back-quoted.
#+ select01
select(dat0,'karno',age,`prior`) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
#' You can also select by the _type_ of column by using the `where()` helper
#' function. That function, in turn, should be wrapped around the _un_quoted
#' name of a function that can take a vector as its first argument and returns a
#' _single_ `TRUE` or `FALSE`. For example, `is.numeric()` and `is.character()`.
#' But you have to use them without the parentheses because you're referencing
#' the functions themselves, not their result (which is what the parentheses
#' would mean).
#+ select02
select(dat0,where(is.numeric)) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
select(dat0,where(is.character)) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
#' You can also select columns whose names match a particular pattern by using
#' `start_with()`, `ends_with()`, or `matches()` helper functions.
#+ select03
select(dat0,starts_with('t')) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
select(dat0,ends_with('time')) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
select(dat0,matches('ag')) %>% slice_head(n=5) %>% pander(split.tables=Inf, split.cells=Inf);
#'
#' ### `mutate`
#'
#' ### `rename`
#'
#' ### `relocate`
#'
#' ## Groups of Rows
#'
#' ### `group_by` and `summarise`

#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0
               , across(where( function(xx) length(unique(xx))<3), as.factor));
#' Now try the scatterplot matrix again
ggpairs(dat1);
#' 
#' ## Aggreates data
#' 
#' ### `summarize`
#' summarize(dat0, mean) # ERROR
#' use args to identify details of function for syntax
args(summarize)
?summarize
summarize(dat0, mean = mean(WT)) # for one column mean
summarize(dat0, across(.cols = everything(), mean)) # for all the columns mean
dat0 %>% summarize(across(.cols = everything(), mean))

dat0$WT %>% round() %>% head()
dat0$WT %>% round() %>% hist()
dat0$WT %>% round() %>% hist(breaks = 100)
dat0$WT %>% round() %>% hist(breaks = 100, xlim = c(70, 100))
dat0$WT %>% round() %>% ifelse()

# 
#' Parallel minimum: pmin()
?pmin
#' parallel maximum: pmax()
dat0$WT %>% round() %>% pmin(10) %>% table
dat0$WT %>% round() %>% pmin(20) %>% table
dat0$new_WT <- dat0$WT %>% round() %>% pmin(20) %>% table

#' ### To group your data for aggregation
#' `group_by()`
group_by(dat0, Gender) %>% summarize(across(.cols = everything(), mean)) 
group_by(dat0, Gender) %>% summarize(across(.cols = everything(), sd)) 
group_by(dat0, Gender) %>% summarize(across(.cols = everything(), list(mean=mean, sd=sd))) 
#'
#'
#' # ggplot2
#' `ggplot()`
#' `ggplot(data,aes(...))`
dat0$HT <- as.numeric(dat0$HT)
ggplot(dat0,aes(y=HT) ) + geom_bar() # histogram plotting
ggplot(dat0,aes(x=WT) ) + geom_bar()
ggplot(dat0,aes(x=WT, y=HT) ) + geom_point()
ggplot(dat0,aes(x=WT, y=HT, color = Gender) ) + geom_point()
ggplot(dat0,aes(x=WT, y=HT, color = Gender) ) + geom_line()

#' grouping two ways
ggplot(dat0,aes(x=WT, y=HT, color = Gender, group = Age) ) + geom_line() 
ggplot(dat0,aes(x=WT, y=HT, color = Gender, group = Age) ) + geom_line() + geom_point()
ggplot(dat0,aes(x=WT, y=HT, color = Gender, group = Age) ) + geom_line(aes(group = Gender)) + geom_point()
ggplot(dat0,aes(x=WT, y=HT, color = Gender, group = Age) ) + geom_line(aes(group = Gender)) + geom_point(aes(group = Age))
ggplot(dat0,aes(x=WT, y=HT, color = Gender, group = Age) ) + geom_line(aes(group = Gender)) + geom_point(aes(color = STUDY))
ggplot(dat0,aes(x=WT, y=HT) ) + geom_line(aes(group = Gender)) + geom_point(aes(color = STUDY))

ggplot(dat0,aes(x=WT, y=BMI, color = Gender, group = Age) ) + 
  geom_line(aes(group = Gender)) + 
  geom_line(aes(y = Age)) + 
  geom_point(aes(color = STUDY))

ggplot(dat0,aes(x=WT, y=BMI, color = Gender, group = Age) ) + 
  geom_line(aes(group = Gender)) + 
  geom_line(aes(y = Age), color = "red") + 
  geom_point(aes(color = STUDY))

ggplot(dat0,aes(x=WT, y=BMI, color = Gender, group = Age) ) + 
  geom_line(aes(group = Gender)) + 
  geom_line(aes(y = Age), alpha =  0.5) + 
  geom_point(aes(color = STUDY))

ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth(method = "lm") + geom_point()
ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth(method = "glm") + geom_point()
ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth() + geom_smooth(method = "lm") + geom_point()
ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth(color = "red") + geom_smooth(method = "lm", color = "blue") + geom_point(aes(color = Gender))
ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth(fill = "pink", color = "red") + geom_smooth(method = "lm",fill = "lightblue", color = "blue") + geom_point(aes(color = Gender))

#' plot from two dataset
layers <- list( geom_smooth(fill = "pink", color = "red"), geom_smooth(method = "lm",fill = "lightblue", color = "blue"),  geom_point(aes(color = Gender)) )
ggplot(dat0, aes(x=WT, y=HT) ) + layers
ggplot(dat1, aes(x=WT, y=HT) ) + layers


#' To exclude the second item from a list:
foo <- list(a=1,b=2:10,c=runif(5))
foo[-2]

# to change one layer
ggplot(dat0, aes(x=WT, y=HT) ) + layers[-2]
ggplot(dat0, aes(x=WT, y=HT) ) + layers[c(1,3)]

ggplot(dat0, aes(x=WT, y=HT) ) + layers[-2] + geom_smooth(method = "lm",fill = "lightblue", color = "green")

#' change variable in data
#' 
#' 
#' For adding layers in ggplot:
#' `+` 
#' For adding layers that use a different data source than the starting ggplot object:
#'  `%+%`
#' To override the data, you must use %+%
base <- ggplot(dat0,aes(x=WT, y=HT) ) + geom_smooth(color = "red") + geom_smooth(method = "lm", color = "blue") + geom_point(aes(color = Gender))
base %+% dat1
#'
#' To override the data for just one layer without changing the others, you can specify the data=... argument for just that one.
base %+% geom_point(aes(color=Gender), data=dat1)
#' 
#' 
#' 
#' 2021-09-22 class
#' `facet_grid`
#' 
ggplot(dat0, aes(x=WT, y=HT) ) + layers + facet_grid(STUDY ~ . )
ggplot(dat0, aes(x=WT, y=HT) ) + layers + coord_cartesian(xlim=c(50,100))
#'
#'
#'packages upgrading while upgrade R:
packageStatus()
packageStatus()$inst %>% subset(Status=='upgrade') %>% rownames() # list the packages that needs upgrade
packageStatus()$inst %>% subset(Status=='upgrade') %>% rownames %>% gsub('\\.1','',.)
packs <- packageStatus()$inst %>% subset(Status=='upgrade') %>% rownames %>% gsub('\\.1','',.)
install.packages(packs[1])
#'
#'
#'
#' Python in R
library(reticulate)
repl_python() # click Y for install python
#' Reticulate 1.20 REPL -- A Python interpreter in R.
#' 
#' switch between python and R
#' leave python: press `esc`
#' enter python: 
repl_python() 
#' 
#' 
#' 

#' ## model fitting/ variable selection
sample(1:10)
?browser()

#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0, across(where( function(xx) length(unique(xx))<3), as.factor), group = {1}); # {} run everything in the brackets, then put in R
dat1 <- mutate(dat0, across(where( function(xx) length(unique(xx))<3), as.factor), group = {browser(); 1}); # ; seperate two functions 
head(dat1$group)
sample(c("test", "train"), size = 10, replace = TRUE)
sample(c("test", "train"), size = n(), replace = TRUE) # generate arbitarial number of values
dat1$group %>% table

set.seed(10)
dat1 <- mutate(dat0, across(where( function(xx) length(unique(xx))<3), as.factor), group = sample(c("test", "train"), size = n(), replace = TRUE)); # ; seperate two functions 
dat1$group %>% table

# subset to create training and test data
?subset
data1train <- subset(dat1, subset = group=="train") # creates a subset for train
data1test <- subset(dat1, subset = group=="test") # creates a subset for test

# or generate new training data
data1train <- dat1[sample(1:nrow(dat1), nrow(dat1), replace = TRUE), ] # creates a training data
fit <- lm(FatMassPercentage ~ BMI, data = data1train)
summary(fit)
summary(fit) %>% tidy # tidy function is in the library(broom)
fit %>% tidy # tidy function is in the library(broom)
glance(fit)# in broom package, show a quick look at all of the summary statictics

#' create a null model
fit.null <- lm(FatMassPercentage ~ 1, data = data1train) # generate a null model
summary(fit.null)

anova(fit.null, fit) # comparing two models

#' create an all encompassing model
fit.all <- lm(FatMassPercentage ~ Gender + WT + HT + LBM + Age + BMI + SA + bk, data = data1train) # method 1
colnames(data1train) %>% paste0(collapse=' + ')
fit.all <- update(fit, .~ Gender + WT + HT + LBM + Age + BMI + SA + bk ) # method 2# To keep the original outcome: .~ # To keep original predictors: ~.
summary(fit.all)
anova(fit, fit.all)
anova(fit.null, fit, fit.all) # 

#' stepwizer regression: step()
#' args(step)
fitAIC <- step(fit, scope = list(lower = fit.null, upper = fit.all), scale = 0, direction = "both")
summary(fitAIC) 
summary(fitAIC) %>% tidy

#' Additive model: OUTCOME ~ PRED1 + PRED2 + PRED3 + ...
#' Interaction model: OUTCOME ~ PRED1*PRED2*PRED3 ...
#' A*B means: A + B + A:B
#' A*B*C means: A + B + C + A:B + A:C + B:C + A:B:C
#' All possible three-way interactions: ~ (A+B+C)^3
#' All possible two way interactions: ~ (A+B+C)^2

fit.all2way <- lm(FatMassPercentage ~ (Gender + WT + HT + LBM + Age + BMI + SA + bk)^2, data = data1train) # method 1
fitAIC <- step(fit, scope = list(lower = fit.null, upper = fit.all2way), scale = 0, direction = "both")
summary(fitAIC) 
summary(fitAIC) %>% tidy


fit.all3way <- lm(FatMassPercentage ~ (Gender + WT + HT + LBM + Age + BMI + SA + bk)^3, data = data1train) # method 1
fitAIC <- step(fit, scope = list(lower = fit.null, upper = fit.all3way), scale = 0, direction = "both")
summary(fitAIC) 
summary(fitAIC) %>% tidy


sample(1:10)# return random number

project_seed <- 17589005
set.seed(project_seed)
sample(1:10) # after set.seed, you get the same number each time.
sample(1:10) # create a second different new number each time.



#' ## diagnostics
plot(fit.all2way)
anova(fit.all2way,  fit.all3way) # 

plot(predict(fit.all3way,data1test)~data1test$Age)

plot(predict(fit.all2way,data1test)~data1test$Age)

plot(data1test$Age, predict(fit.all2way,data1test)-data1test$Age)

plot(data1test$Age, predict(fit.all3way,data1test)-data1test$Age)

plot(data1test$Age, predict(fit.all,data1test)-data1test$Age)

plot(data1test$Age, predict(fit,data1test)-data1test$Age)

plot(data1train$Age, predict(fit,data1train)-data1train$Age)
