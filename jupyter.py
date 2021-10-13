#!/usr/bin/env python
# coding: utf-8

# # Learing Jupter
# 
# This is our notebook for today!
# 
# 
# # Headings
# # Header
# ## Subheader
# ### Sub-Subheader
# 
# 
# # Alternate Syntax
# Heading level 1
# ===============
# 
# Heading level 2
# ---------------
# 
# 
# # Paragraphs
# I really like using Markdown.
# 
# I think I'll use it to format all of my documents from now on.
# 
# 
# # Line Breaks
# This is the first line.  
# And this is the second line.
# 
# 
# 
# # Emphasis
# 
# **bold text**
# 
# __bold text__
# 
# *Italic*
# 
# _Italic_
# 
# ***Bold and Italic***
# 
# ___Bold and Italic___
# 
# __*Bold and Italic*__
# 
# **_Bold and Italic_**
# 
# > Blockquotes
# 
# > Blockquotes with Multiple Paragraphs
# >
# > Blockquotes with Multiple Paragraphs
# >> Nested Blockquotes
# 
# > #### Blockquotes with Other Elements
# > - Blockquotes with Other Elements
# > *Blockquotes* with Other **Elements**
# 
# 
# # Lists
# 1. First item
# 2. Second item
# 3. Third item
# 4. Fourth item
# 
# - First item
# - Second item
# - Third item
# - Fourth item
# 
# * First item
# * Second item
# * Third item
# * Fourth item
# 
# + First item
# + Second item
# + Third item
# + Fourth item
# 
# - First item
# - Second item
# - Third item
#     - Indented item
#     - Indented item
# - Fourth item
# 
# - 1968\. A great year!
# 
# 
# # Adding Elements in Lists
# 1. Open the file.
# 2. Find the following code block on line 21:
#         
#         <html>
#           <head>
#             <title>Test</title>
#           </head>
#         
# 3. Update the title to match the name of your website.
# 
# 
# # Code
# `denote`
# 
# ``Escaping Backticks``
# 
# ``Escaping Backticks `denote` Escaping Backticks``
# 
# 
# ***
# 
# ---
# 
# _________________
# 
# # Links
# 
# [duckduck](https://duckduckgo.com)
#  
#  favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").
#  
# <https://www.markdownguide.org>
#  
# <fake@example.com>
# 
# I love supporting the **[EFF](https://eff.org)**.
# This is the *[Markdown Guide](https://www.markdownguide.org)*.
# See the section on [`code`](#code).
# 
# 
# 

# In[9]:


import pandas as pd
import matplotlib.pyplot as plt


# In[11]:


dat0 = pd.read_csv('sim_data.csv')
AP1=dat0[dat0.Gender == "F"].plot.scatter('BMI', 'bk', c="Green", label="F")
AP2=dat0[dat0.Gender == "M"].plot.scatter('BMI', 'bk', c="Red", label="M", ax=AP1)


# In[ ]:




