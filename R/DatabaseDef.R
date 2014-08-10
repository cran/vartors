# -*- encoding:ASCII -*-

##################
# Class DatabaseDef A class which define multiple variables
# Created the 2014-06-08 by Joris Muller
##################

############Class Definition###########
#' @title Class DatabaseDef
#' @description The \code{DatabaseDef} class is used to store properly the definition of several variables. It is created by \link{import_vardef}.
#' @slot DatabaseDef A list containing \code{VariableDef} objects.
#' @seealso \code{DatabaseDef} objects are created by \link{import_vardef} function for the moment. It store \code{link[=VariableDef-class]{VariableDef}} objects in a list. To create a single definition of variable, use \code{\link{vardef}}.
#' @note For the moment, this class is only a convenient way to store a list of \code{\link{VariableDef-class}} objects. This class will be extended in a future version of \pkg{vartors} to add the pathfile, a global description and others informations about the database.
#' @author Joris Muller
#' @examples
#' # Create a DatabaseDef from a definition of variable table
#' suppressWarnings(
#' a_DatabaseDef_object <- import_vardef(sample_descvar)
#' )
#' 
#' # Show the list of the definition of variable
#' a_DatabaseDef_object
#' 
#' # Check the class
#' class(a_DatabaseDef_object)
#' @keywords classes

setClass(Class="DatabaseDef", 
         slots=c(variables_definitions="list"
         )
)

#########Class checker###########
setValidity("DatabaseDef", function(object){
  
  # The slots VariableDef must contain only object of class 'VariableDef'
  classes_in_descvars <- sapply(X=object@variables_definitions, FUN=class)
  
  if (any(classes_in_descvars != "VariableDef") )
    return("All the objects of the decvars list must be of VariableDef class")
  
  return(TRUE)
}
)

############Class constructor###########
#' Create a DatabaseDef object
#' 
#' Constructor of the class DatabaseDef. Used only internaly for the moment.
#' 
#' @param DatabaseDef A list containing \code{VariableDef} objects
#' @keywords internal
#' @export

database_def <- function(DatabaseDef){
  return(new("DatabaseDef","variables_definitions"=DatabaseDef))
}

### get all rnames method

setGeneric(name = "get_all_rnames",
           def = function(object){
             standardGeneric("get_all_rnames")})

setMethod(
  f = "get_all_rnames",
  signature = "DatabaseDef",
  definition = function(object)
  {
    
    rnames_vector <- character()
    
    for (a_variabledef in object@variables_definitions){
      rnames_vector <- c(rnames_vector, a_variabledef$rname)
    }
    
    return(rnames_vector)
  }
)

