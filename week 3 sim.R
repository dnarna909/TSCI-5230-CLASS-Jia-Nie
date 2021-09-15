
library(synthpop);
library(rio);
# install_formats() # install for the first time
library(dplyr);

# simulate
inputdata <- "E:/2021-03-26 Bulk Fat RNAseq/Subjects with Clamp Infor and All Infor.RDS"
dat0 <- import(inputdata) %>% select(!"DATE") %>% select(1:15);
dat0s <- syn(dat0)
#View(dat0s$syn)
#class(dat0s$syn)
compare(dat0s, dat0)
export(dat0s$syn,"sim_data.RDS")
