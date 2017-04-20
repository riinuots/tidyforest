data_melanoma = function(){

  library(tidyverse)
  library(forcats)


mydata = boot::melanoma

mydata$status %>%
  factor() %>%
  fct_recode('Died' = '1',
             'Alive' = '2',
             'Died - other causes' = '3') %>%
  fct_relevel('Alive') -> # move Alive to front (first factor level)
  mydata$status.factor    # so the odds ratios will be relative to that

mydata$sex %>%
  factor() %>%
  fct_recode('Female' = '0',
             'Male' = '1') ->
  mydata$sex.factor

mydata$ulcer %>%
  factor() %>%
  fct_recode('Present' = '1',
             'Absent' = '0') ->
  mydata$ulcer.factor

mydata$age %>%
  cut(breaks = c(4,40,60,95), include.lowest=TRUE) ->
  mydata$age.factor

mydata$thickness %>%
  cut(breaks = c(0,0.5,1,4, max(mydata$thickness, na.rm=T)),
      include.lowest = T) ->
  mydata$stage

mydata$stage.factor = as.factor(mydata$stage)

mydata$stage.factor %>%
  fct_recode('Stage I' = '[0,0.5]',
             'Stage II' = '(0.5,1]',
             'Stage III' = '(1,4]',
             'Stage IV' = '(4,17.4]'
  ) -> mydata$stage.factor

mydata
}
