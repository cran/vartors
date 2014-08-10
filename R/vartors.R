# -*- encoding:ASCII -*-

##################
# Package documentation for roxygen2
# Created the 2014-06-20 by Joris Muller
##################

#' @title Transform Definition of Variables to R Scripts
#' 
#' @description \pkg{vartors} is an R package that produces R script using \link[=variable_definition_table]{definition of variables} described by user. It could help to import, adapt to R classes and perform descriptive analysis on each variable according to its type.
#' 
#' @details
#' \subsection{Documentation}{
#' 
#' This page explain the main concepts in \code{vartors}. See also the vignettes. There is one with a tutorial :
#' 
#'   \code{vignette(topic = "usage", package = "vartors")} 
#'   
#'   and one with the complete workflow 
#'   
#'  \code{vignette(topic = "workflow", package = "vartors")}
#' }
#' 
#' \subsection{Motivation}{
#' 
#' The package \pkg{vartors} was created to speed-up the error-prone and important cleaning data phase in context of the statistical consultations. 
#' These methodology consultations are an important part of our daily work. The idea is to help physicians of our hospital to process their data and make accurate analysis. In our workflow, the physician must come with a database (mainly an Excel or .csv file), a description of the variables and a good question. For the moment, we spend too much time to clean up data and not enough to analyze it. That's where \pkg{vartors} may help.
#' }
#' \subsection{Workflow}{
#' 
#' We will describe here in a compact way the workflow. For more details, see the documentation of each function and the vignettes.
#' 
#' The global workflow is :
#' \enumerate{
#'    \item Create a \emph{\link[=variable_definition_table]{definition of variables table}}. The \code{\link{descvars_skeleton}} function could help you to initiate this. Fill all the characteristics of each variable, especially the \emph{type}.
#'    \item Import this \emph{\link[=variable_definition_table]{definition of variables table}} in R if it was created in a spreadsheet program, for example with \code{\link{read.csv}}, \code{\link{read.table}} or \code{read.xlsx}, to have it in \code{\link{data.frame}}.
#'    \item Use \code{\link{create_script}} to create a script according to the definition of each variable.
#'    \item Write this script in a file with \code{\link{write_file}}
#'    \item Adapt your new script to special cases, test it line by line, and produce a report, for example with \pkg{knitr}
#' }
#' 
#' It's possible to use various built-ins \link[=ScriptTemplate]{script templates} in \code{.R} or \code{.Rmd} with the function \code{\link{import_template}}. The user could also create his own \link[=ScriptTemplate]{script templates} by exporting a built-in one with \code{\link{export_template}}. It's a flexible way to allow each user to adapt and perform analysis on each variable as he want. 
#' }
#' 
#' @author Joris Muller
#' @note
#' For bugreports, features request, use the github issue tracking at \url{https://github.com/jomuller/vartors/issues}.
#' 
#' Special thanks to :
#' \itemize{
#' \item The GMRC (Groupe Méthode en Recherche Clinique) team of Service de Santé Public, Hôpitaux Universitaires de Strasbourg :
#'   \itemize{
#'     \item Dr Erik-André Sauleau to supervise me during this work
#'     \item Mickael Schaeffer for all these advices, bugtracking and coding-mate in another package
#'     \item Pr Nicolas Meyer to accept me to work on this package and all his advices
#'     \item Dr François Lefèbvre, Dr François Séverac, Maël Barthoulot, Pierre Collard Dutilleul for advices and bugtracking.
#'   }
#' \item Pr Bruno Falissard Master 2 courses and his contagious enthusiasm about R
#' \item My classmates in the Master 2 \emph{Méthodologie et Statistiques en Recherche Biomédicale} for nice debates and ideas.
#' \item Christophe Genollini for his free manuals: \href{http://cran.r-project.org/doc/contrib/Genolini-PetitManuelDeS4.pdf}{Petit Manuel de S4}, \href{http://cran.r-project.org/doc/contrib/Genolini-ConstruireUnPackage.pdf}{Construire un Package} and \href{http://cran.r-project.org/doc/contrib/Genolini-RBonnesPratiques.pdf}{R, Bonnes pratiques}
#' \item Hadley Wickham for his on-line book \href{http://adv-r.had.co.nz/}{Advanced R} and his helpful packages \pkg{roxygen2}, \pkg{devtools}, \pkg{testthat} and \pkg{ggplot2} used in this package.
#' \item The R Core Team and particularly Uwe Ligges for his reviews and his tips.
#' \item The peoples implicated in the free softwares and websites used to create this package : R, RStudio, Git, GitHub, StackOverflow.
#' }
#' 
#' @seealso The mains methods are \code{\link{create_script}}, \code{\link{import_template}} and  \code{\link{import_vardef}}. The main work to the user is to fill a \emph{\link[=variable_definition_table]{definition of variables table}}.
#' @docType package
#' @keywords main
#' @name vartors
#' @examples
#' # Import a data.frame containing the description of the variables
#' # Show the description of the variable
#' sample_descvar
#'
#' # Create the script skeleton simply with create_script()
#' script_skeleton <- create_script(sample_descvar)
#' # watch the result
#' script_skeleton
#' # Could be written in a file with the write() method
#' \dontrun{
#' write_file(script_skeleton)
#' }
#' 
#' # It's possible to create a simple script for a single variable
#' a_variable_definition <- vardef(varlabel = "Creatinine Clearance", rname ="creat", type="numeric" )
#' create_script(a_variable_definition)
NULL