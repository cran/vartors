# -*- encoding:ASCII -*-

##################
# Package documentation for template concept
# Created the 2014-06-20 by Joris Muller
##################

#' @title Script template
#' 
#' @description Script templates are a powerful concept in the \pkg{vartors} package. They are script skeletons which will be used to produce usable script thanks to definition of variables.
#' 
#' @details
#' Script templates should be written in different languages known by R :
#' \describe{
#'   \item{R}{The classical R language, using file extension \code{.R}}
#'   \item{R markdown}{Used to mix markdown syntax with R code. Use file extension \code{.Rmd}. Process these files with \pkg{knitr}}
#'   \item{R sweave}{Used to mix LaTeX syntax with R code. Process these files with \pkg{knitr} too. No test where done with this format for the moment, because R markdown does almost everything in an easier way.}
#' }
#' 
#' To be valid, a script template must contain \code{<vartors template>} in a comment somewhere in his 5 first lines.
#' 
#' To understand how to read and write a script template, there are two main concepts : \emph{blocs} and \emph{remplacements words}
#' 
#' \subsection{blocs}{
#' Blocs are code lines between an opener delimiter and a closer delimiter. Openers are lines starting with \code{#<} and closers with \code{#>}. These delimiters must have a name recognized by \code{\link{import_template}} (actually, should be header, footer, integer, numeric, factor, ordered, date or not_used). Only one name by delimiter is allowed.
#' For example, to create a new bloc for factor type, just write :
#' \preformatted{#< factor
#' # factors must use hist to make nice plots
#' plot(rep_cleandata$rname)
#' #> factor}
#' 
#' This will add theses lines to the bloc of lines for the factor type
#' }
#' \subsection{remplacement words}{
#' These words will be replaced when  \code{\link{create_script}} will be used. They have a prefix \code{rep_}. For example, \code{rep_rname} will be replaced by the name of the variable in R from the definition of variables. Actually, usable replacement names are rep_rname, rep_type, rep_description and others ones...
#' }
#' @seealso The main methods are \code{\link{import_template}} and \code{\link{export_template}}. They are always used in \code{\link{create_script}}. To be usable in \pkg{vartors}, a script template must be transformed in a \code{\link[=ScriptTemplate-class]{ScriptTemplate}} object by \code{\link{create_script}}.
#' @name ScriptTemplate
#' @aliases script skeleton template
#' @keywords documentation template

NULL