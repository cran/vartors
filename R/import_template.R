# -*- Encoding:ASCII -*-

######### functions to import a template ###############
# Created by Joris Muller the 2014-06-03

# Helper : bloc_lines 
# Detect lines with open and closure for each type name
bloc_lines <- function(type_name, text, start_pattern, stop_pattern){
  
  # Create regex to find the starts and the ends
  start_name <- paste(start_pattern,  type_name)
  stop_name <- paste(stop_pattern, type_name)
  
  # Find the start lines and end lines
  starts <- grep(pattern=start_name, x=text)
  ends <-  grep(pattern=stop_name, x=text)
  
  # Check if for each start line there is an end line >
  if (length(starts) != length(ends)) 
    #TODO: print where there is a mis-match and for wich type
    stop("There must be an end tag for each start tag")
  # Check if each start is before each end
  if (!all(starts < ends))
    stop("Ends tag must be after start tags")
  
  limits <- data.frame("starts"=starts, "ends"=ends)
  
  # Extend the lines numbers
  lines <- apply(X=limits, MARGIN=1, FUN=function(x){seq(x[1], x[2])})
  
  return(unlist(lines))
}

# Helper : create_bloc
# For lines with closure and open, detect wich type
# Put all in a data frame
# To create a bloc for a type, just aggregate the lines

create_bloc <- function(type_name, text, start_pattern="^#<", stop_pattern="^#>"){
  
  lines <- bloc_lines(type_name, text, start_pattern=start_pattern, stop_pattern=stop_pattern)
  text_type <- text[lines]
  # erase lines for start and stop patterns
  limits_pattern <- paste0("(" ,start_pattern,")|(",stop_pattern,")")
  to_erase <- grep(pattern=limits_pattern ,text_type)
  return(type_name = text_type[-to_erase])
}

#  Helper : Detect language
# Detect the language of the template based on a file extension
detect_language <- function(filepath){
  if (grepl(pattern=".[R|r]$",x=filepath))
    return("R")
  else if (grepl(pattern=".Rnw$",x=filepath) )
    return("Rnw")
  else if (grepl(pattern=".Rmd$",x=filepath))
    return("Rmd")
  else {
    warning("Unknow extension for file '",filepath,"'. Will ese '.R' as default.")
    return("R")
  }
}

#' @title Import a script template
#' 
#' @description Import a script template and transform it as an \code{\link{ScriptTemplate-class}}
#' object.
#' @param path Path to the template file 
#' @param builtin The name of a built-in template. See details for available built-in template. Override \code{language} and \code{idiom} parameters if given.
#' @param language The name of one language of the built-in template, could be \code{en} or \code{fr}. If a path or a built-in is provided, this argument is ignored.
#' @param idiom The idiom of the built-in template, could be \code{en} or \code{fr}. If a path or a built-in is provided, this argument is ignored.
#' @param encoding Encoding of the script template. Should be "ASCII", "latin-1" or "UTF-8" (default value) 
#' @details Actually, built-in templates are : \Sexpr{library(vartors);paste0(list_templates(), collapse = ", ")}
#' @return Return a ScriptTemplate object.
#' @seealso \code{\link{ScriptTemplate-class}}, \code{\link{script_template}}
#' @export
#' @author Joris Muller
#' @keywords main template
#' @examples
#' # import the default built-in template
#' import_template()
#' 
#' # import a specific built-in template
#' import_template(builtin = "anothertemplate.R")

import_template <- function(path, builtin, language="R", idiom="en", encoding="UTF-8"){
  
  #Define the patterns to parse the blocs
  patterns <- c("startbloc" = "^#<",
                "endbloc" = "^#>",
                "var_replacement" = "rep_"
  )
  
  # Define possible blocs names
  blocs_names <- c("header", 
                   "footer", 
                   "integer", 
                   "numeric", 
                   "factor", 
                   "ordered", 
                   "character",
                   "date", 
                   "not_used")
  
  # Define the filepath of the file, depending if a path was given
  if (missing(path)) {
    
    builtin_directory_path <- paste0(path.package("vartors"),"/templates/")
    
    if(missing(builtin)) {
    template_file_path <- paste0(
      builtin_directory_path, "template_", idiom, ".", language
      )
    } else {
      template_file_path <- paste0(builtin_directory_path, builtin)
    }
  } else {
    template_file_path <- path
  }
  
  # Open the file
  # Open the connection with the file
  con_template <- file(description=template_file_path, 
                       open="r", 
                       encoding=encoding)
  
  # Read all the lines
  raw_template <- readLines(con=con_template)

  # Close and destroy the connection
  close(con_template)
  rm(con_template)
  
  # Create the blocs
  code_blocs <- lapply(X=blocs_names, create_bloc, raw_template)
  names(code_blocs) <- blocs_names
  
  # Create the ScriptTemplate object
  code_bloc_object <- script_template(
    language = detect_language(template_file_path),
    blocs = code_blocs,
    raw_template = raw_template
  )
  
  return(code_bloc_object)
}