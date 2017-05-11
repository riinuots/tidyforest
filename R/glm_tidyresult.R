glm_tidyresult = function(mydata, dependent, explanatory){

  #devtools::use_package("tidyverse")
  #devtools::use_package("forcats")
  #devtools::use_package("broom")
  library(tidyverse)
  library(forcats)


  myformula = as.formula(paste(dependent, "~", paste(explanatory, collapse="+")))
  # for the example dataset, this creates this:
  # status.factor ~ sex.factor + ulcer.factor + stage.factor
  # (which is the input formula for logistic regression)

  # create nice glm() output -------------

  # this is the fit
  myfit = glm(myformula, mydata , family='binomial')


  #extracting ORs and p values
  my_result = myfit %>%
    broom::tidy(conf.int = T, exponentiate = T) %>%
    mutate(p.label = ifelse(p.value<0.001, '<0.001', round(p.value, 3) %>% formatC(3, format='f')) ) %>%
    dplyr::select(variable = term, or = estimate, p.label, p.value, conf.low, conf.high) %>%
    filter(variable != '(Intercept)')


  # unfortunately, the extractions above don't include reference levels (i.e. OR=1.0)
  # so need to extract all levels and paste them into the dataframes
  all_levels = myfit$xlevels %>%
    enframe() %>%
    unnest() %>%
    dplyr::mutate(variable = paste0(name, value))

  #thing long mutate rounds the odds ratios up to 2 decimal places and puts them together into a range in brackets
  my_result = full_join(all_levels, my_result, by='variable') %>%
    dplyr::mutate(or.label = ifelse(is.na(or),
                                    '1.0 (Reference)',
                                    paste0(or %>% round(2) %>% formatC(2, format='f') , #else
                                           ' (',
                                           conf.low %>% round(2) %>% formatC(2, format='f'),
                                           ' to ',
                                           conf.high %>% round(2) %>% formatC(2, format='f'),
                                           ')'
                                    )),
                  p.label = ifelse(is.na(p.label), '-     ', p.label))

  my_result

}
