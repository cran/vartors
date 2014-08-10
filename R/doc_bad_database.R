# Doc for database baddatabase

#' @title Bad database to test vartors
#' 
#' @description A small dataset randomly generated to simulate an hypothetical survey and test \pkg{vartors}. 
#' 
#' @details Include multiple definitions for NA's and not meaningful variables. It's a typical example of database we have to process. This database is close to \link{example_df} but more realistic because includes more typing errors. It is used in the vignette tutorial. This dataset was generated with the function \code{simulate_dataframe} from the package \code{dfexplore}, wrote in a \code{csv} file, altered to add errors and imported in R with \code{\link{read.csv}}.
#' 
#' The columns are :
#' 
#' \describe{
#'     \item{\code{subject}}{ An integer. Unique number of the subject.} 
#'     \item{\code{initial}}{ A factor. Initials of the subject. Recognised as a factor by \code{read.csv} instead of a character vector.} 
#' \item{\code{birth}}{ A factor. Birthdate. Recognized as a factor by \code{read.csv} instead of a date.} 
#' \item{\code{sex}}{ A factor with levels \code{male} \code{female}}
#' \item{\code{study_level}}{ A factor with levels \code{primary} < \code{secondary} < \code{superior} but recognized as a simple factor instead of a oredered factor.}
#' \item{\code{heigh}}{ A factor. Recognized as a factor by \code{read.csv} instead of a numeric because there are multiple definitions for NA}
#' \item{\code{weight}}{ A factor. Recognized as a factor by \code{read.csv} instead of a numeric because there are multiple definitions for NA}
#' \item{\code{siblings}}{ A factor. Recognized as a factor by \code{read.csv} instead of a an integer because there are multiple definitions for NA}
#' \item{\code{Q1}}{ An integer. Question 1. Without further description, we can't guess what's the meaning of this variable.}
#' \item{\code{Q2}}{ An integer. Question 2. Without further description, we can't guess what's the meaning of this variable.}
#' }
#' 
#' @docType data
#' @keywords datasets
#' @format A \code{data.frame} with 100 rows and 10 variables
#' @name bad_database
#' @seealso \code{\link{variables_description_bad_database}} is an example of variable description table for this database.
#' @examples
#' # See the class of each variable
#' str(bad_database)
#' 
#' # Create a variable description table skeleton
#' descvar_baddb <- descvars_skeleton(bad_database)
#' 
#' # Edit the variable description table
#' \dontrun{
#' variables_description_bad_database <- edit(descvar_baddb)
#' }
#' 
#' # Watch the variable description table after editing
#' variables_description_bad_database
#' 
#' # Use it to create a script to import bad_database
#' myscript <- create_script(variables_description_bad_database)
#' \dontrun{
#' # Show the script
#' myscript
#' 
#' # Write the script in a file
#' write_file(myscript, "my_import_script.R")
#' }
NULL