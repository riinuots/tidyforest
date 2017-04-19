
library(tidyforest)

mydata = data_melanoma()

dependent = 'status.factor'
explanatory = c('sex.factor', 'ulcer.factor', 'stage.factor')
explanatory_names = c('Gender', 'Ulceration', 'Stage (thickness)')

or_forest(mydata, dependent, explanatory, explanatory_names)
