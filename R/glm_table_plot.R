or_table_plot = function(my_result , explanatory_names){

  hjust_table = data_frame(my_table = c('name', 'value', 'or.label', 'p.label'),
                           my_hjust = c(1,0,0.5,1),
                           my_xloc = c(1, 2, 3, 4))

  varname_table = data_frame(group = explanatory,
                             name.label = explanatory_names)

  table_data = my_result %>%
    mutate(variable = forcats::fct_inorder(variable)) %>% #make variable into factor (otherwise ggplot will make alphabetically)
    select(variable, name, group = name, value, or.label, p.label) %>%
    gather('my_table', 'my_label', -variable, -group) %>%
    left_join(hjust_table, by='my_table') %>%
    left_join(varname_table, by='group') %>%
    mutate(my_table = forcats::fct_inorder(my_table)) %>%
    mutate(group = ifelse(!duplicated(group), paste0('                          ', group, '                           '), NA),
           group_location=1)



  or_table =   table_data %>%
    mutate(name.label = ifelse(is.na(group), NA, name.label)) %>%
    ggplot(aes(y=forcats::fct_rev(variable),
               x = my_xloc))+
    geom_text(aes(label = my_label, hjust = my_hjust))+
    geom_text(aes(label = name.label, x = group_location), position = position_nudge(x = 0.8, y= -0.7), angle=90)+
    theme_bw()  +
    theme(axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          axis.text.x = element_text(size=12, colour='white'),
          panel.border = element_blank()
          #,panel.grid.major.y = element_blank() #optinally only remove horizontal grid lines (keeping odds ratio ones)
          ,panel.grid.major = element_blank() #these remove all grid lines
          ,panel.grid.minor = element_blank()
    )

  or_table

}
