''' start python script '''

'''
My first Python script.
 
(this is a multi-line comment)
'''

import random # import library
random.normalvariate()  # rnorm(), use library function
random.normalvariate(mu=3, sigma=0.3)  # assign values in function, mu: mean, sigma: sd
test0 = random.normalvariate(mu=3, sigma=0.3) # assign to a variable
test0 # show the variable
'vector <- c(2:8) # in R
range(2,8) # Python equivalent of 2:8: Arguably, range(2,8)
vector = range(2,8)
test02 = [2,3,4,5,6,7,8] # Manually create a python list, equivalent of c(...)

'TO print each number in a range:
for ii in range(2,8): ii # press enter, interactive version

[ii for ii in range(2,8)] # creat a list. And by putting [ and ] around that, you get a Python list of those values.


x = test02
test03 = 'x' # creat a character value
test03
print('x') 
'x'

for ii in range(2,8): ii # equivalent to R: for (ii in c(2:8)) {'x'}

['x' for ii in range(2,8)] # equivalent to R: FOO <- c(); for(ii in 2:8) {FOO <- c(FOO,'x')} or rep_len('x',7)

[random.normalvariate(mu=3, sigma=0.3) for ii in range(2,8)] # equivalent to R: rnorm(7,3,0.3)

'''week 7 python introduction 20211006'''
#' How to load a python library:
#' import FOO as BAR
#' In our specific case:
import pandas as pd
import matplotlib.pyplot as plt
# reticulate::repl_python() # for use a function without import in R
#' read excel
#' pd.read_excel('sim_data.xlsx')
dat0 = pd.read_csv('sim_data.csv')
dat0
dat0.info() # equivalent to R: summary(dat0)
dat0.head() # In R: head(dat0)

'''Select columns'''
dat0.describe()

'''Sort'''
dat0.sort_values('List') # sort one column
dat0.sort_values(['List', 'bk']) # sort two columns
dat0.sort_values(['List', 'bk'], ascending=True) 
dat0.sort_values(['List', 'bk'], ascending=False) 
dat0.sort_values(['List', 'bk'], ascending=[False,True]) 

'''Subsetting column'''
dat0.BMI     # in R: dat0$BMI
dat0['BMI']  # in R: dat0[["food"]]
dat0[['List','bk','BMI']] # in R: dat0[c('List','bk','BMI')]
dat0.BMI
dat0.BMI > 31 # set up True or False 
dat0[dat0.BMI > 31] # select rows based on condition

'''Subsetting row and column'''
# dat0.BMI[ROWSTUFF,COLUMNSTUFF]
#Python: FOO.isin(['BAR','BAZ','BAT']) # in R: R: FOO %in% c('BAR','BAZ','BAT')
dat0.BMI.between(29,31, inclusive=True)
dat0.loc[dat0.BMI.between(29,31, inclusive=True), 'bk']
dat0.loc[dat0.BMI.between(29,31, inclusive=True), ['bk', 'FatMassPercentage']]
dat0.iloc[10:30,2:5]
'''python indexs things starting from 0, so it skipped ro 30 because 0 coutned as a row, same with columns'''

'''assign value to column'''
dat0['bk'] = 10
dat0.head()
dat0['bk1'] = 11
dat0.head()

'''Operates on columns inside of a data frame'''
dat0.eval('BMI+bk')

'''plotting'''
#' py_install('matplotlib') # in R

dat0.plot.scatter('BMI', 'bk')

AP1=dat0.plot.scatter('BMI', 'bk')
plt.show()
AP1=dat0.plot.scatter('BMI', 'bk', c="Green")
AP1=dat0[dat0.Gender == "F"].plot.scatter('BMI', 'bk', c="Green", label="F")
AP2=dat0[dat0.Gender == "M"].plot.scatter('BMI', 'bk', c="Red", label="M", ax=AP1)
plt.show()
dat0.bk
