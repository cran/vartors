# Roxygen2 documentation for sample_vardef dataset

#' @title Sample definition of variables table
#' 
#' @description A dataset containing definition of various variable linked to the database "bad_database". It's generated from a .CSV
#' 
#' \itemize{
#'  \item column The column name in the spreadsheet (A, B, C...)
#'  \item rname Short name of the variable to be use in R
#'  \item varlabel Long name of the variable used in graphs and tables
#'  \item description Description of the variable
#'  \item type Type of variable
#'  \item unit Unit of the variable or date format
#'  \item flevel One level of a qualitative variable. One for each level.
#'  \item fname One name of a level of a qualitative variable. One for each label.
#'  }
#' @format A data.frame with 6 rows and 18 variables
#' @docType data
#' @keywords datasets
#' @seealso The documentation about \link[=variable_definition_table]{definition of variables tables}. To import it, use \code{\link{import_vardef}}.
#' @name variables_description_bad_database
NULL