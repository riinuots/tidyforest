or_forest = function(mydata = data_melanoma(),
                     dependent = 'status.factor',
                     explanatory = c('sex.factor', 'ulcer.factor', 'stage.factor'),
                     explanatory_names = c('Gender', 'Ulceration', 'Stage (thickness)')){

  devtools::use_package("gridExtra")

  # mydata = data_melanoma()
  # dependent = 'status.factor'
  # explanatory = c('sex.factor', 'ulcer.factor', 'stage.factor')

  glm_result = glm_tidyresult(mydata, dependent, explanatory)

  my_orplot = or_plot(glm_result)

  my_ortable = or_table_plot(glm_result, explanatory_names)


  combined_plot = gridExtra::grid.arrange(my_ortable, my_orplot, ncol=2, widths=c(2,1))
  combined_plot

}
