# -*- encoding:ASCII -*-

##################
# Class VariableDef. A class which define a variable
# Created the 2014-06-03 by Joris Muller
##################

############Class Definition###########
#' @title Class VariableDef
#' @description The \code{VariableDef} class is used to store properly the definition of the variable.
#' @slot varlabel A length-one character vector. Should be with a max of 40 letters. All characters are allowed. Will be used to varlabel properly the plots and tables in output.
#' @slot description A length-one character vector. Description of the variable.
#' @slot rname A length-one character vector. Should be with a max of 16 letters. It's the name of the variable used in R. It could only use [a-z], [0-9] and "_" and must start with [a-z].
#' @slot comment A length-one character vector with a max of 1000 letters. It's a commentary that will appear when describing each variable and give some advices to the statistician to how to analyze this variable.
#' @slot type A length-one character vector. Must be one of the following : numeric, integer, factor, ordered, character, date or not_used. It's used to dispatch the script blocs regarding the type of the variable.
#' @slot unit A length-one character vector of max size 20. Should be the unit of a variable which will be showed in some graphs or the format of a date (by default \code{\%d/\%m/\%Y}).
#' @slot levels A character vector. Only used if type is factor or ordered. Describe the levels used. The same levels must be in the database, otherwise NA will be generated.
#' @slot labels A character vector of the same size than levels or empty. If empty, the labels will be the levels.
#' @seealso The constructor is \link{vardef}. For several variables, see \code{\link{DatabaseDef-class}}
#' @author Joris Muller
#' @keywords classes

setClass(Class = "VariableDef", 
         slots = c(
           varlabel    = "character",
           description = "character",
           comment     = "character",
           unit        = "character",
           type        = "character",
           rname       = "character",
           levels      = "character", 
           names       = "character"
         )
)

#########Class checker###########
setValidity("VariableDef",function(object){
  
  # Define variables
  # Character vector where the finale message will be incremented
  final_message <- character(0)
  # Names of the types possible for the moment in this object
  types_possible <- c("numeric", "integer", "factor", 
                      "ordered", "character", "date", "not_used")
  
  # Create a function to cumulate the messages
  add_message <- function(message, char_vector = "final_message"){
    # Function to add a message to the finale_message
    
    # Create the cumulated message
    cumulated_message <- c(get(x=char_vector), message)
    # Assign to the char_vector
    assign(x=char_vector, value=cumulated_message, envir=parent.frame())
    # Return invisibly nothing
    return(invisible(NULL))
  } 
  
  # Test rname
  if (length(object@rname) != 1) {
    add_message("'rname' must be of length one") 
  } else {
    if (nchar(object@rname)>16) 
      warning(object@rname,": 'rname' should have less than 17 characters")
    
    if (!grepl("^[a-z]", object@rname)) 
      warning(object@rname,": 'rname' should start with a lower case character from a to z")
    
    if (grepl("[^a-z|_|0-9]", object@rname))
      warning(object@rname,": 'rname' should contain only character [a-z], \"_\" or [0-9]")
    
    if(grepl("[^a-z|_|0-9|A-Z|.]", object@rname))
      add_message("'rname' ist not valid. Must contain only [a-z], [A-Z], [0-9], [_] or [.]")
    
    if (!grepl("^[a-z|A-Z]", object@rname)) 
      add_message("'rname' must start with an character from a to z (upper or lower case)")
  }
  
  ## varlabel
  
  if (length(object@varlabel) > 1)
    add_message("'varlabel' must be of length one or 0")
  else if (length(object@varlabel) == 1)
    if (nchar(object@varlabel) > 41)
      warning(object@rname, ": 'varlabel' must have less than 40 characters")
  
  # type
  if (length(object@type) != 1) {
    add_message("'type' must be of length one")
    
  } else if (!(object@type %in% types_possible))
    add_message(
      paste("'type' could only have one of the following values:",
            paste(types_possible, collapse=", ")
      )
    )
  
  # comment
  if (length(object@comment) > 1)
    add_message("'comment' must be of length one or 0")
  else if (length(object@comment) == 1)
    if (nchar(object@comment)>1000)
      warning(object@rname, ": 'comment' must have less than 1000 characters")
  
  # description
  if (length(object@description) > 1)
    add_message("'description' must be of length one or 0")
  else if (length(object@description) == 1)
    if (nchar(object@description)>1000)
      warning(object@rname, ": 'description' must have less than 1000 characters")
  
  # levels
  if (length(object@levels) > 0) {
    ### levels can be set only for 'factor' and 'ordered' type
    if ( !(object@type %in% c("factor","ordered"))) {
      add_message(
        paste0("'levels' could be only set for 'ordered' or 'factor' type",
               ", not for this type (",object@type,")")
      )   
    }
  }
  # names
  # Test if there is names
  if (length(object@names) > 0) {
    ### Labels can be set only for 'factor' and 'ordered' type
    if ( !(object@type %in% c("factor","ordered"))) {
      add_message(
        paste0("'name' could be only set for 'ordered' or 'factor' type",
               ", not for this type (",object@type,")")
      )   
      
    } else if (length(object@names)!=length(object@levels)){
      add_message("'name' there must be the same number of names and levels (or no names)")
    }
  }
  
  # Create the error message if needed
  if (length(final_message)==0) return_value <- TRUE
  else return_value <- paste0(
    "\nFor the variable '", object@varlabel, "' :\n- ",
    paste(final_message, collapse="\n- ")
    )
  
  return(return_value)
})

############Class initialize###########

# Not needed for the moment

# setMethod( f="initialize", 
#            signature="VariableDef", 
#            definition=function(.Object, rname, type="not_used", varlabel, comment,
#                                unit, levels, names, raw_values){
#              
#              .Object$rname <- rname
#              
#              if (length(type) == 0) .Object$type <- 
#              else .Object$type <- type
#              
#              
#              if (length(varlabel) == 0) .Object$varlabel <- rname
#              else .Object$varlabel <- varlabel
#              
#              .Object$comment <- comment
#              
#              #default unit for date
#              if (length(unit) > 0) .Object$unit <- unit
#              else if (type == "date") .Object$unit <- "%d/%m/%Y"
#              
#              
#              .Object$levels <- levels
#              # Check validity
#              .Object$levels <- names
#              
#              return(.Object)
#            }
# )

############Class constructor###########

#' Create a VariableDef object
#' 
#' Constructor of the \code{\link[=VariableDef-class]{VariableDef}} class. A \code{\link[=VariableDef-class]{VariableDef}} object stores all the data needed to process a variable in the package.
#' 
#' @param varlabel A character. Used to label properly the plots and tables in output.
#' @param description A character. A description of the variable
#' @param rname A character. It's the name of the variable used in R.
#' @param comment A character.
#' @param type A character. Must be one of the following : numeric, integer, factor, ordered, character, date or not_used.
#' @param unit A character. Could be used for the format of a date (by default aa/mm/yyyy).
#' @param levels A character vector. Describe the levels used for a vector.
#' @param names A character vector of the same size than number of levels or empty.
#' @seealso \link{VariableDef-class} and \link{DatabaseDef-class}
#' @export
#' @author Joris Muller

vardef <- function(varlabel, description, rname, type = "not_used",  
                    comment, unit, levels = NULL, names = NULL) {
  
  # Warning : this constructor is central in this package
  # Any change here change (almost) everything
  
  # If there is no name, create one according to the varlabel
  
  # To deal with NA in variable description data frames
  if (missing(rname))  rname <- NA
  
  if (is.na(rname)) {
   
    if (missing(varlabel)) 
      stop("You must provide at last a varlabel or a rname")
    else 
      rname <- make.names(varlabel)
  } else {}
  
  # Deal with missing values. 
  # Just to not see character() as default value in documentation
  
  # If varlabel is missing, use the rname
  if (missing(varlabel)){
    
    if ((!missing(unit)) & (type != "date")) 
      varlabel <- paste0(rname," (",unit,")")
    else 
      varlabel <- rname
    
  } else {}
  
  if (missing(comment)) comment <- character()
  else if(is.na(comment)) comment <- character()
  
  if (missing(description)) description <- character()
  else if(is.na(description)) description <- character()
  
  if (is.na(type)) type <- "not_used"
  
  # Deal with NA
  if(!is.null(levels))
    if(length(levels) == 1 & is.na(levels[1])) levels <- NULL
  # If type is not a factor or ordered factor, then there levels
  # and lables must be empty
  if (!(type %in% c("factor","ordered"))) {
      if(!is.null(levels))
        warning(varlabel, ": 'levels' could be only set for 'ordered' or 'factor' type",
    ", not for this type (",type,")")

      if(!is.null(names))
        warning(varlabel, ": 'names' could be only set for 'ordered' or 'factor' type",", not for this type (",type,")")
    levels <- character()
    names <- character()
  } else {
    if(is.null(levels)){
      levels <- character()
      names <- character()
    } else if(is.null(names)) names <- levels
  }
  
  
  if (missing(unit)) {
    if (type == "date") unit <- "%d/%m/%Y"
    else unit <- character()
  }
  
  if (!is.character(levels)) levels <- as.character(levels)
  
  return(new("VariableDef",rname=rname, description=description, type=type, varlabel=varlabel, comment=comment, unit=unit, levels=as.character(levels), names=as.character(names)))
}

### show methods #######################
setMethod(
  f="show",
  signature="VariableDef",
  definition=function(object)
  {
    available_slots <- slotNames("VariableDef")
    for(a_slot in available_slots){
      value <- slot(object, a_slot)
      if (length(value) > 0)
        cat(a_slot, "=",paste(value,collapse=", "),"\n")
    }
  }
)
### Getteurs methods #######################

#' Get value for VariableDef object
#' 
#' @rdname extract-methods

setMethod( 
  f = "$",
  signature = "VariableDef",
  definition = function(x, name){
    
    # List the available slots
    available_slots <- slotNames("VariableDef")
    
    # If the slot exists, return the value
    if (name %in% available_slots) return(slot(x, name))
    else stop(paste0(name," is not a valid slot for VariableDef"))
  } 
)
