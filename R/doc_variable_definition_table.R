
#' @title Definition of variables table
#'
#' @description The definition of variables table is a way to describe each variable from a database in a table where each line represent a variable, and each column one of its characteristic.
#'  The idea is to be explicit about each variable by describing these characteristics :
#'    \describe{
#'        \item{varlabel}{An explicit name of the variable, but short enough to be displayed on figures and tables. Example : \emph{Date of birth} or \emph{Creatinine Clearance}}
#'        \item{description}{An explicit description of the variable, if the varlabel is not explicit enough. It helps the statistician to understand the meaning of the variable. Example : \emph{The Creatinine Clearance measured at the entry of the patient in the hospital}}
#'        \item{comment}{An commentary to help the statistician. Example : \emph{This quantitative variable can't have value superior to 20.}}
#'        \item{unit}{The unit of the variable, when applicable. For dates, put the format like in R. Example : for the Creatinine Clearance, \emph{ml/min}, for the Date of birth, \emph{\%d\%m\%Y}}
#'        \item{flevel}{A level of a factor or ordered variable. Each level must be placed in a separated column. Then there are as much \emph{flevel} as levels of the variable}
#'        \item{flabel}{A label of a factor or ordered variable. Each level must be placed in a separated column. Then there are as much \emph{flevel} as levels of the variable}
#'        \item{type}{Class of the variable. Could be \emph{numeric}, \emph{integer}, \emph{factor}, \emph{ordered}, \emph{date}, \emph{character} or \emph{not_used}}
#'        \item{rname}{The name of the variable in R. If not given, the \code{varlabel} will be used and transformed to a compatible name}
#'    }
#' 
#' @seealso To create a \emph{definition of variables table} skeleton from a existing data.frame, use the \code{\link{descvars_skeleton}} function. To read a \emph{definition of variables table} from a data.frame to a DatabaseDef object, use the \code{\link{import_vardef}}. \emph{Variable definition table} could be used directly as a \code{data.frame} by \code{\link{create_script}}. A built-in example of a complete \emph{definition of variables table} is the \code{\link{variables_description_bad_database}} that describes the \code{\link{bad_database}}.
#' @name variable_definition_table
#' @keywords documentation
#' @concept Variables definition table
NULL
