# -*- Encoding:ASCII -*-

######### functions to export built-in template ###############
# Created by Joris Muller the 2014-07-15

#' @title Export a built-in script template
#' 
#' @description Export to a file a built-in script template. This way it's possible to adapt it to user's needs. Basically, it's a wrapper for the \code{\link{file.copy}} function.
#' @param builtin name of the built-in template. See details.
#' @param to path where the file have to be written
#' @details Actually, built-in templates are : \Sexpr{library(vartors);paste0(list_templates(), collapse = ", ")}
#' @return Return the path where the file template was written. If there is an error, return FALSE.
#' @seealso \code{\link{import_template}}
#' @export
#' @author Joris Muller
#' @keywords template
#' @examples
#' # export the default built-in template
#' \dontrun{
#' export_template("template_to_edit.R", "en.R")
#' }
#' 

export_template <- function(builtin = "template_en.R", to ="./template_en.R") {
  
  # Get the filepath of the built-in template
  templates_path <- paste0(path.package("vartors"),"/templates/")
  template_file_path <- paste0(
    templates_path ,builtin
  )
  
  if(file.exists(template_file_path)) 
    copy_ok <- file.copy(from = template_file_path, to = to)
  else
    stop(builtin, "does not exist. Please choose one of the following :", 
         paste(dir(templates_path), collapse = ", "))
  
  # Evaluate if the target path is a directory
  filepath_is_dir <- grepl(pattern = "\\/$", x = to)
  
  # Prepare a nice return message
  if (copy_ok) {
    if(filepath_is_dir) return_value <- paste0(to,builtin)
    else return_value <- to
  } else return_value <- FALSE
  
  return(return_value)
}