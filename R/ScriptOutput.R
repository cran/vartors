# -*- encoding:ASCII -*-

######### Description of the file ########
# Class ScriptOutput. A class which contain the script 
# created by create_script()
# Created the 2014-06-06 by Joris Muller

############Class Definition###########
#' @title Class ScriptOutput
#' 
#' @description Class to store the script output
#' 
#' @slot output body of the script
#' @slot language Language of the script. Is "R", "Rmd" or "Rnw"
#' @slot header Header of the script
#' @slot footer Footer of the script
#' @seealso The constructor method is \code{\link{create_script}}. \code{ScriptOutput} objects have also a write method to create easily a file
#' @import methods
#' @keywords classes

#' @author Joris Muller

setClass(
  Class="ScriptOutput", 
  slots=c(
    header   = "character",
    output   = "character",
    footer   = "character",
    language = "character"
  )
)

setMethod(
  f = "show", 
  signature = "ScriptOutput", 
  definition = function(object) {
    
    cat("#- Start of the script in",object@language,"-#\n")
    cat(object@header, sep="\n")
    cat(object@output, sep="\n")
    cat(object@footer, sep="\n")
    cat("#- End of the script in",object@language,"-#\n")
    
    return(invisible(NULL))
  }
)

##### write_file method ---------

#' Write file method
#' 
#' @description Write a file for the specified object
#' 
#' @details If the object is a \code{\link[=ScriptOutput-class]{ScriptOutput}} object, it will write a script skeleton file .
#' 
#' @param object Object to be written as a \code{\link[=ScriptOutput-class]{ScriptOutput}} object.
#' @param filepath Where to write the file. No need to add the extension, it will be put following the language of ScriptOutput. If an extension is given, then it will be used
#' @param append Append Append the file. \code{FALSE} by default.
#' @param encoding Character encoding to use. Use the default encoding if not specified.
#' @param ... other options for specific methods
#' @note Will be extended to others \pkg{vartors} objects in future releases. I don't use the \code{\link{write}} function because it is not a S3 or a S4 method and it's hard to promote in a good way.
#' @seealso \code{\link{ScriptOutput-class}}
#' @return Return invisibly the file path of the new file
#' @export
#' @author Joris Muller
#' @keywords main
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

setGeneric(name="write_file",
           def = function(
             object,
             filepath, 
             append = FALSE, 
             encoding = getOption("encoding"),
             ...
           ) {
             standardGeneric("write_file")
           }
)

#' @describeIn write_file
#' @export

setMethod(
  f = "write_file",
  signature = "ScriptOutput",
  definition = function (object, filepath = "dmscript", append = FALSE, 
                         encoding = getOption("encoding"), ...) {
    
    if(length(filepath) != 1) stop("filepath must be a character of lenght one")
    
    # Add a message in the first line to debug the version
    message <- paste("This file was produced by the vartors Package version", utils::packageVersion("vartors"))
    if (object@language == "R")        disclaimer <- paste("#", message, "#")
    else if (object@language == "Rmd") disclaimer <- paste("<!--", message, "-->")
    else if (object@language == "Rnw") disclaimer <- paste("%", message)
   
    # The script contain the disclaimer, the header, 
    # the body and the footer
    # Append the different parts
    script <- c(object@header, disclaimer, object@output, object@footer)
    
    # Find if there is already an extension
    has_extension <- grepl(pattern = paste0("\\.",object@language,"$"), x = filepath, perl = TRUE)
    if(has_extension) {
      filepath2 <- filepath
    } else {
      filepath2 <- paste0(filepath,".",object@language)
    }
    # The file name is the filename + the language extension
    
    
    # Write the file
    cat(script, file=filepath2, sep="\n", append=append)
    
    return(invisible(filepath2))
  }
)

###### Method c (concatenate) ---------------------------------------

#' @title Concatenate ScriptOutput objects together.
#' 
#' @description Concatenate ScriptOutput objects together.
#' 
#' @details This is a \code{\link{c}} method specific for \code{\link[=ScriptOutput-class]{ScriptOutput}} objects. All \code{\link[=ScriptOutput-class]{ScriptOutput}} objects must use the same language (\code{.R} or \code{.Rmd}). The header and the footer of the first object will be used for all. It is used in \pkg{vartors} by \code{\link{create_script}} to create a script for more than one variable.
#' @param x The first \code{\link[=ScriptOutput-class]{ScriptOutput}} object.
#' @param ... Others \code{\link[=ScriptOutput-class]{ScriptOutput}} object to be concatened.
#' @seealso The \code{\link{c}} function and the \code{\link[=ScriptOutput-class]{ScriptOutput class}}.
#' @aliases c
#' @author Joris Muller
#' @examples
#' # Create a script output from a description table
#' myscript <- create_script(variables_description_bad_database)
#' 
#' # But you forget a variable.
#' # Create it as a VariableDef object
#' forgoten_var <- vardef(varlabel = "A forgotten variable", rname = "forget", type = "integer")
#' forgoten_var
#' 
#' # Create a script for it
#' forgoten_script <- create_script(forgoten_var)
#' forgoten_script
#' 
#' # Add it to the initial script
#' my_complete_script <- c(myscript, forgoten_script)
#' 
#' # Watch the result
#' \dontrun{
#' my_complete_script
#' 
#' # Write the script in a file
#' write_file(my_complete_script, "my_import_script.R")
#' }


setMethod(
  f = "c",
  signature = "ScriptOutput",
  definition = function (x, ..., recursive = FALSE) 
  {
    # Get the elements from the ... argument
    elements <- list(...)
    
    # Start a "cumulate" object where we will add each element
    # This way, the final object will have the header and the footer of x
    cumulate <- x
    
    # Add each element, one by one, checking if it could be added.
    for (one in elements) {
      
      if (class(one) != "ScriptOutput")
        stop("All objects must be of ScriptOutput class")
      
      else if (one@language != x@language)
        stop("All ScriptOutput objects must use the same language (e.g. R or Rmd)")
      
      else
        cumulate@output <- c(cumulate@output, one@output)
    }
    
    return(cumulate)
  }
)

##### Setteurs and Getteurs #####

#' Get value of a ScriptOutput object
#' 
#' @rdname extract-methods
#' @keywords internal

setMethod(
  f="$",signature="ScriptOutput",definition=function(x, name){
  # Check if the i slot exist
  available_slots <- slotNames("ScriptOutput")
  
  if (name %in% available_slots){
    return(slot(x, name))
  } else {
    stop(paste0(name," is not a valid slot for VariableDef"))
  }
} 
)

#' Replace names of ScriptOutput
#'
#' @rdname extract-methods
#' @keywords internal

setMethod( f="$<-", signature="ScriptOutput", definition=function(x, name, value){
  ### TODO
  available_slots <- slotNames("ScriptOutput")
  
  if (name %in% available_slots){
    slot(x, name) <- value
  } else {
    stop(paste0(name," is not a valid slot for VariableDef"))
  }
  
  if (!validObject(x)) stop("Not a valid object")
  
  return(x)
  
})