# -*- encoding:ASCII -*-

##################
# Class ScriptTemplate. A class which store the script template
# Created the 2014-06-06 by Joris Muller
##################


############Class Definition###########
#' @title Class ScriptTemplate
#' @description The \code{ScriptTemplate} class is used to store properly the script template. It consists of various blocs, each for each type (numeric, factor...)
#' @slot language A length-one character vector. The extension of the language used in the template. Should be \code{R}, \code{Rmd} or \code{Rnw}
#' @slot original_script The original script
#' @slot blocs A list. Each element of the list is a character vector with the lines for a type.
#' @seealso The main function to construct a \code{ScriptTemplate} object is \code{\link{import_template}}. The constructor is \code{\link{script_template}}. More information about template in the \link[=ScriptTemplate]{dedicated documentation}.
#' @author Joris Muller
#' @keywords classes template
setClass(Class="ScriptTemplate", 
                       slots=c(
                        language = "character",
                        blocs = "list",
                        raw_template = "character"
                        )
                       )

#########Class checker###########
setValidity(Class="ScriptTemplate",
            method = function(object){

              # Check language slot
              if (length(object@language) != 1)
                "'language' must be of length 1"
              else if (!(object@language %in% c("R","Rmd","Rnw")))
                paste(object@language, "is not supported. Only supported languages are 'R', 'Rmd' and 'Rnw'")
              else
                TRUE

              # TODO: Add checking for list

            })

############Class constructor###########

#' Create a \code{ScriptTemplate} object
#' 
#' @param blocs A list. Each element of the list is a character vector with the lines for a type.
#' @param language A length-one character vector. The extension of the language used in the template. Should be \code{R}, \code{Rmd} or \code{Rnw}
#' @param raw_template A character vector with the raw template 

#' @seealso \code{\link{ScriptTemplate-class}}. More information about template in the \link[=ScriptTemplate]{dedicated documentation}.
#' @keywords template internal
#' @export
#' @author Joris Muller

script_template <- function( blocs, language = "R", raw_template ){
  return(new("ScriptTemplate", blocs = blocs, language = language , raw_template = raw_template))
}

### show methods #######################
setMethod(f="show", 
          signature=c("object" = "ScriptTemplate"),
          definition=function(object){
            
            # Print gently the language and the idiom
            cat("Template coded in",object@language,"language.\n")
            
            # Print the bloc of each type
            for(i in seq_along(object@blocs)){
              cat("\n--- start bloc vartype =",names(object@blocs[i]),"---\n")
              cat(object@blocs[[i]],sep="\n")
              cat("--- end bloc vartype =",names(object@blocs[i]),"---\n")
            }
            
            return(invisible(NULL))
          }
)

### Getteurs methods #######################
setGeneric("get_bloc_type",
           function(ScriptTemplate, type)
             standardGeneric("get_bloc_type")
)


setMethod(f="get_bloc_type", signature="ScriptTemplate", definition=function(ScriptTemplate, type){
  return(ScriptTemplate@blocs[[type]])
} 
)
