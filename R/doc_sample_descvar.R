# Roxygen2 documentation for sample_vardef dataset

#' @title Sample definition of variables table
#' 
#' @description A dataset containing definition of various variable with some errors. It's generated from a .CSV
#' 
#' \itemize{
#'  \item rname Short name of the variable to be use in R
#'  \item varlabel Long name of the variable used in graphs and tables
#'  \item description Description of the variable
#'  \item type Type of variable
#'  \item unit Unit of the variable or date format
#'  \item level One level of a qualitative variable
#'  \item name One name of a level of a qualitative variable
#'  }
#' @format A .csv with 6 rows and 13 variables
#' @docType data
#' @keywords datasets
#' @seealso The documentation about \link[=variable_definition_table]{definition of variables tables}. To import it, use \code{\link{import_vardef}}.
#' @name sample_descvar
NULL