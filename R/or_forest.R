
#' Create a logistic regression forest plot with a table on the left.
#'
#' @param mydata
#' @param dependent
#' @param explanatory
#' @param explanatory_names
#'
#' @return
#' @export
#'
#' @examples
#' mydata = data_melanoma()
#' dependent = 'status.factor'
#' explanatory = c('sex.factor', 'ulcer.factor', 'stage.factor')
#' explanatory_names = c('Gender', 'Ulceration', 'Stage (thickness)')
#'
#' or_forest(mydata, dependent, explanatory, explanatory_names)

or_forest = function(mydata,
                     dependent,
                     explanatory,
                     explanatory_names){

  #devtools::use_package("gridExtra")

   #mydata = data_melanoma()
   #dependent = 'status.factor'
   #explanatory = c('sex.factor', 'ulcer.factor', 'stage.factor')
   #explanatory_names = c('Gender', 'Ulceration', 'Stage (thickness)')

  glm_result = glm_tidyresult(mydata, dependent, explanatory)

  my_orplot = or_plot(glm_result)

  my_ortable = or_table_plot(glm_result, explanatory_names)


  combined_plot = gridExtra::grid.arrange(my_ortable, my_orplot, ncol=2, widths=c(2,1))
  combined_plot

}
