or_plot = function(my_result){

  #devtools::use_package("tidyverse")
  #devtools::use_package("forcats")
  library(tidyverse)
  library(forcats)

  #or_plot =
  my_result %>%
    mutate(variable = forcats::fct_inorder(variable)) %>% #make variable into factor (otherwise ggplot will make alphabetically)
    ##start ggplot()
    ggplot(aes(x = forcats::fct_rev(variable),
               y = or))+
    geom_hline(yintercept = 1,
               colour = 'grey')+ #1.0 reference line
    geom_errorbar(aes(ymin = conf.low, ymax = conf.high),
                  width  = 0.2,
                  colour = '#41ae76',
                  size   = 0.9) + #OR lower-upper errorbars
    ##geom_linerange(aes(ymin=or_lower, ymax=or_upper), width=0.2, colour='#41ae76', size=0.9) + #alternative to errorbars
    geom_point(shape  = 18,
               size   = 2.5,
               colour = '#41ae76') +
    ##explanatory labels
    geom_text(aes(label = value),
              vjust = -0.5) +
    ##reference level labels
    geom_text(data = my_result %>%
                filter(is.na(or)) %>%
                mutate(or_reference = 1.0),
              aes(label = value, x = variable, y = or_reference), angle = 90, vjust = -0.2, colour = '#737373') +
    coord_flip() +
    scale_y_log10() + #log scale breaks=c(0.2, 0.5, 1, 1.5, 2.0, 3.0), breaks=c(0.01, 0.1, 0.5, 1, 2.0)
    theme_bw() +                          #theme
    theme(axis.text.y  = element_blank(),
          axis.ticks.y = element_blank(),
          axis.title   = element_blank(),
          #panel.border = element_blank(),
          axis.text.x  = element_text(size=12, colour='black')
          #,panel.grid.major.y = element_blank() #optinally only remove horizontal grid lines (keeping odds ratio ones)
          ,panel.grid.major = element_blank() #these remove all grid lines
          ,panel.grid.minor = element_blank()
    )

  #or_plot

}
