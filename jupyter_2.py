#!/usr/bin/env python
# coding: utf-8

# In[ ]:


dat0 = pd.read_csv('sim_data.csv')
AP1=dat0[dat0.Gender == "F"].plot.scatter('BMI', 'bk', c="Green", label="F")
AP2=dat0[dat0.Gender == "M"].plot.scatter('BMI', 'bk', c="Red", label="M", ax=AP1)


# In[19]:


var_list = ['a', 1, 'x']
var_list
list2 = ['4', 5, var_list, 6]


# In[5]:


dict1.get("a")
dict1["f"]
res= dict1.get("f")
res
type(res)
print(type(res))
print(type(dict1))


# In[ ]:





# In[12]:


mynames = ['jan','feb','mar','apr'] # R: setNames(VALUE.VECTOR,NAME.VECTOR)
values = [42,13,-8,3.5]
zip(mynames, values)
dict(zip(mynames, values))


# In[13]:


dict2 = dict(zip(mynames, values))
dict2.update({'may': 89})
print(dict2)


# In[20]:


list2.append(6) # R eqvuialent: list2 <- c(list2,6)
print(list2)


# In[21]:


list3 = list2 # list3 is linking to list2, which is different from R.
print(list2)
print(list3)


# In[23]:


list3[0] = 7
print(list2)
print(list3)


# In[27]:


list4 = list2.copy()
list4[0] = 111
print(list2)
print(list3)
print(list4)


# In[28]:


'''loops in python'''
for xx in list2: print(xx)


# In[31]:


for xx in mynames: 
    print(xx.upper())    


# In[ ]:


'mar'.upper() # R eqvuialent: upper case: toupper(...) , likewise, tolower(...)


# In[41]:


listemt = []
for xx in mynames: 
    listemt.append(xx.upper())   
    print(listemt)


# In[38]:


[xx.upper() for xx in mynames] # without loop


# In[39]:


[xx + 5 for xx in [2,3,45]]


# In[44]:


[2,3,45] + [2,3,45] 


# In[46]:


addme = lambda xx,yy: xx+yy # eqvuialent to the function part in here: sapply(FOO,function(xx) xx+3)
map(addme,[2,3,45],[1,8,-8])
list(map(addme,[2,3,45],[1,8,-8])) # R equivalent: c(2,3,45) + c(1,8,-8)


# In[47]:


addme = lambda xx,yy,zz: xx+yy+zz # eqvuialent to the function part in here: sapply(FOO,function(xx) xx+3)
map(addme,[2,3,45],[1,8,-8],[1,2,3])
list(map(addme,[2,3,45],[1,8,-8],[1,2,3])) # R equivalnet: c(2,3,45) + c(1,8,-8)


# In[51]:


addme = lambda xx,yy: xx+yy # eqvuialent to the function part in here: sapply(FOO,function(xx) xx+3)
list(map(addme, list(map(addme,[2,3,45],[1,8,-8])), [1,2,3]))


# In[52]:


list(map(lambda xx,yy: xx+yy,[1,2,3],[8,8,1]))


# In[53]:


[xx + 5 for xx in [1,2,3,4,5,6,7] if xx > 3] # R equivalent: aa <- 1:7 + 5; aa[aa>3] 
# More concise equivalent: aa <- 1:7 + 5 %>% `[`(.,.>3)


# In[ ]:




