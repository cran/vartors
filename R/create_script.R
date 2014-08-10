# -*- encoding:ASCII -*-

##################
# methods create_script
# Created the 2014-06-03 by Joris Muller
##################

## create_script documentation ------------------------------------------------

#' @title Create a script
#' 
#' @description Create a script according to the \link[=variable_definition_table]{definition of the variables} and a \link{template} .
#' 
#' 
#' @param var_desc An object which describes the variable. Could be a single \code{\link[=VariableDef-class]{VariableDef}}, a whole \code{\link[=DatabaseDef-class]{DatabaseDef}} or a simple \code{\link[=data.frame]{data.frame}}. In this last case, \code{\link[=import_vardef]{import_vardef}} function will be called to transform it to a \code{\link[=DatabaseDef-class]{DatabaseDef}}.
#' @param template Optional. An object which describes the template. Either a \code{\link[=ScriptTemplate-class]{ScriptTemplate}} object or a path to the template file. In this last case,  \code{\link[=import_template]{import_template}} function will be called to transform this filepath to a \code{\link[=ScriptTemplate-class]{ScriptTemplate}}. If missing, the default template is used.
#' @param rawdata_name Name used to replace rep_rawdata in the template
#' @param cleandata_name Name used to replace rep_cleandata in the template
#' @param header If \code{TRUE} produce the header bloc
#' @param footer If \code{TRUE} produce the footer bloc
#' @param columns_names rnames of the columns
#' @param ... others arguments for specifics methods
#' @details \code{create_script} is the central function of the \code{vartors} package. It will collate the two input objects created by the user (a \code{\link[=VariableDef-class]{VariableDef}} object or \code{\link[=DatabaseDef-class]{DatabaseDef}} object and a \code{\link[=ScriptTemplate-class]{ScriptTemplate}} object) and will produce the final product : the script skeleton represented by an \code{\link[=ScriptOutput-class]{ScriptOutput}} object.
#' @return A \code{\link[=ScriptOutput-class]{ScriptOutput}} object. This object could be written in a file with the \code{\link[=write_file]{write_file}} function.
#' @seealso \code{\link{import_template}}, \code{\link{import_vardef}} and the \link[=vartors]{general documentation of vartors}. 
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

## create_script Generic method -----------------------------------------------
setGeneric(
  name = "create_script",
  def = function(
    var_desc,
    template, 
    rawdata_name = "raw_data",
    cleandata_name="clean_data",
    header=TRUE,
    footer=TRUE,
    ...
  ) {
    standardGeneric("create_script")
  }
)


#' @describeIn create_script
#' @export 

# create_script Main Method (VariableDef, ScriptTemplate) ---------------------
setMethod(
  f = "create_script",
  signature(var_desc = "VariableDef", 
            template="ScriptTemplate"),
  
  definition=function(var_desc, 
                      template, 
                      rawdata_name = "raw_data", 
                      cleandata_name="clean_data",
                      header = FALSE,
                      footer = FALSE,
                      columns_names = var_desc$rname){
    
    format_charvector <- function(char_vector)
      paste0("c('",paste0(char_vector, collapse="', '"),"')")
    
    format_levels <- function(var_levels=character(), rawdata, rname) {
      if (length(var_levels) == 0)
        return(paste0("unique(", rawdata, "$", rname, ")"))
      else
        return(format_charvector(var_levels))
    }
    
    # Helper : if a slot is empty, then return a NA
    check_exist <- function(x){
      if(length(x) == 0) return("NA")
      else return(x)
    }
    # Check if ordered factor for the ordered argument in factor()
    if (var_desc$type == "ordered") {
      ordered_factor <- "TRUE"
    } else {
      ordered_factor <- "FALSE"
    }
    
    # Important : create a replacement dictionnary
    # The names are the keys and the value, the replacements
    replacement_dict <- c(
      # General elements
      "rep_cleandata"     = cleandata_name,
      "rep_rawdata"       = rawdata_name,
      
      # Variable elements
      "rep_varlabel"         = var_desc$varlabel,
      "rep_description"   = check_exist(var_desc$description),
      "rep_comment"    = check_exist(var_desc$comment),
      "rep_unit"          = check_exist(var_desc$unit),
      "rep_rname"      = var_desc$rname,
      "rep_type"          = check_exist(var_desc$type),
      "rep_levels"        = format_levels(var_desc$levels,rawdata_name,var_desc$rname),
      "rep_names"         = format_levels(var_desc$names,rawdata_name,var_desc$rname),
      "rep_orderedfactor" = ordered_factor,
      
      # Others, more general
      "rep_columns_names" = paste0("c('",paste(columns_names, collapse = "', '"), "')")
    )
    
  
    # Get the good type of template bloc
    bloc <- get_bloc_type(template, var_desc$type)
    
    parse_bloc <- function(bloc, dictionnary = replacement_dict){
      # For each element in the  replacement dictionnary
      for(i in seq_along(dictionnary)){
        
        # Get the key
        key_pattern <- names(dictionnary[i])
        
        # Get the replacement string
        replacement_pattern <- dictionnary[i]
        
        # replace it in the new bloc
        bloc <- gsub( pattern = key_pattern, 
                      replacement = replacement_pattern, 
                      x = bloc 
        )
      }
      return(bloc)
    }
    
    
    # Create header and footer
    if (header)  used_header <- parse_bloc(template@blocs$header)
    else used_header <- character()
    
    if (footer) used_footer <- parse_bloc(template@blocs$footer)
    else used_footer <- character()
    
    # TODO : avoid to access directly to object with @
    return(
      new("ScriptOutput",
          output=parse_bloc(bloc), 
          language=template@language, 
          header=used_header, 
          footer=used_footer
      )
    )
  }
)

## create_script for VariableDef, character -----------------
#' @describeIn create_script
#' @export

setMethod(
  f = "create_script",
  signature(var_desc="VariableDef", template="character"),
  
  definition = function(var_desc, 
                        template, 
                        rawdata_name   = "raw_data", 
                        cleandata_name = "clean_data") {
    
    #TODO: check if the file exist
    
    create_script(var_desc      = var_desc, 
              template      = import_template(path=template), 
              rawdata_name  = rawdata_name, 
              cleandata_name= cleandata_name)
  }
)

## create_script Method for VariableDef
#' @describeIn create_script
#' @export

setMethod(
  f = "create_script",
  signature(var_desc="VariableDef"),
  
  definition = function(var_desc, 
                        rawdata_name   = "raw_data", 
                        cleandata_name = "clean_data",
                        header = FALSE,
                        footer = FALSE) {
    
    #TODO: check if the file exist
    
    create_script(var_desc      = var_desc, 
              template      = import_template(), 
              rawdata_name  = rawdata_name, 
              cleandata_name= cleandata_name,
              header = header,
              footer = footer)
  }
)

## create_script Method for DatabaseDef
#' @describeIn create_script
#' @export

setMethod(
  f = "create_script",
  signature(var_desc = "DatabaseDef"),
  definition = function(var_desc, 
                        template, 
                        rawdata_name = "raw_data", 
                        cleandata_name = "clean_data",
                        header = TRUE,
                        footer = TRUE){
    
    # If there is no template, import the default built-in
    if (missing(template)) template <- import_template()
    
    # get the list of VariableDef
    descvar_list <- var_desc@variables_definitions
    
    # for each element, create an ScriptOutput object
    script_outputs <- lapply(X = descvar_list, FUN = create_script, 
                             template = template, 
                             header   = header,
                             footer   = footer,
                             rawdata_name   = rawdata_name , 
                             cleandata_name = cleandata_name,
                             columns_names  = get_all_rnames(var_desc)
                             )
    
    cumulate <- script_outputs[[1]]
    
    for ( one in script_outputs[-1]){
      
      if (one@language != script_outputs[[1]]@language)
        stop("All ScriptOutput objects must use the same language (e.g. R or Rmd)")
      cumulate@output <- c(cumulate@output, "\n", one@output)
    }
    
    return(cumulate)
  }
)

##### data.frame class ######
#' @describeIn create_script
#' @export

setMethod(
  f = "create_script",
  signature(var_desc = "data.frame"),
  definition = function(var_desc, 
                        template, 
                        rawdata_name = "raw_data", 
                        cleandata_name = "clean_data",
                        header = TRUE,
                        footer = TRUE){
    
    if (missing(template)) template <- import_template()
    
    descvars_object <- import_vardef(var_desc)
    
    return(create_script( var_desc=descvars_object, 
                      template=template,
                      rawdata_name=rawdata_name, 
                      cleandata_name=cleandata_name,
                      header = header,
                      footer = footer
    ))
  }
)