# -*- encoding:ASCII -*-

##################
# function list_templates()
# Created the 2014-07-23 by Joris Muller
##################

#' @title List available vartors templates in a folder
#' @description List the file in the specified directory and check if these files are \pkg{vartors} templates. To detect, a file as \pkg{vartors} templates, the file must have one of the supported extension (`.R` or `.Rmd` for the moment) and have the tag \code{<vartors template>} in the first lines.
#' 
#' @param dirpath path to the directory. If missing, the directory of the \pkg{vartors} package with built-in templates.
#' @return Return a character vector with the names of the files which are \pkg{vartors} templates.
#' @seealso \link[=ScriptTemplate]{Script templates} could be imported with \code{\link{import_template}}. This function use \code{\link{is_vartors_template}} to check if a file is a vartors template.
#' @author Joris Muller
#' @seealso \code{\link{is_vartors_template}}
#' @export
#' @examples
#' # Get the list of built-in template
#' list_templates()

list_templates <- function(dirpath) {
  
  if (missing(dirpath)) dirpath <- paste0(path.package("vartors"),"/templates/")
  # list all files
  all_files <- dir(dirpath)
  
  template_list <- character()
  
  for (a_file in all_files) {
    
    a_file_path <- paste0(dirpath, a_file)
    
    if (is_vartors_template(a_file_path)) 
      template_list <- c(template_list, a_file)
  }
  return(template_list)
}

#' @title Detect if a specified file is a vartors template
#' @param filepath Path to the file
#' @param lines_to_read How many first lines to read to find the tag <vartors template>
#' @seealso \code{\link{list_templates}}
#' @export
#' @keywords internal template
is_vartors_template <- function(filepath, lines_to_read = 5) {
  
  # To be a vartors template, the file must have the tag `<vartors template>` 
  # somewhere in the first 5 line
  con <- file(description = filepath, open = "r")
  
  first_lines <- readLines(con = con, n = lines_to_read)
  close(con)
  return(any(grepl("<vartors template>", x = first_lines)))
}