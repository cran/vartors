# -*- encoding:ASCII -*-

####### Methods import_vardef #########
# Methods to import definition of variables
# Created the 2014-06-09 by Joris Muller

###### Generic #######

#' Import definition of variables
#' 
#' Import definition of several variables and create a \code{\link[=DatabaseDef-class]{DatabaseDef}} object.
#' 
#' @param vardf A \code{data.frame} that represents a \link[=variable_definition_table]{definition of variables table}.
#' @param col_replacement Replacement for the columns
#' @return Return a \code{\link[=DatabaseDef-class]{DatabaseDef}} object.
#' @details The \code{col_replacement} parameter by default are : 
#' \code{c(rname = "rname", 
#'         varlabel = "varlabel",
#'         description = "description", 
#'         type = "type", 
#'         commentary = "commentary", 
#'         flevel = "flevel", 
#'         flabel = "flabel")}. 
#' It is possible to overwrite by passing \code{c(key = "value")} in the \code{colnames} parameter.
#' @seealso To create a \link[=variable_definition_table]{definition of variables table} from a database, use \code{/link{descvars_skeleton}}.
#' @export
#' @examples
#' # create a simple definition of variables table in a data.frame
#' testdf <- read.table(header = TRUE, stringsAsFactors=FALSE, 
#'   text="
#'   rname  varlabel  description  type  flevel1  name1  flevel2  name2  flevel3  name3
#'   id        Identification  'Unique ID'  integer NA NA NA NA NA NA
#'   age       'Age of patient' NA integer NA NA NA NA NA NA
#'   city      'City'  'City where live actually' factor 1 Strasbourg 2 Paris 3 London
#'   weight    'Weight' 'Weight at the beginning of the study' numeric NA NA NA NA NA NA
#'   ")
#' # create the DatabaseDef object
#' import_vardef(testdf)
#' 
#' # When the headers are not standard, it's possible to pass a 
#' # replacement dictionnary
#' names(testdf) <- c("variable", "etiquette", "description", 
#'                    "type",  "code1",  "modalite1",  "code2",  "modalite2",  
#'                    "code3",  "modalite3")
#' head(testdf)
#' import_vardef(testdf, 
#'               col_replacement =  c("rname" = "variable",
#'                                    "varlabel"    = "etiquette",
#'                                    "flevel"    = "code",
#'                                    "flabel"     = "modalite")
#' )

setGeneric(name = "import_vardef",
           def = function(vardf, col_replacement) {
             standardGeneric("import_vardef")
           }
)

# Helper function
# Parse levels and labels
parse_factor <- function(defvector, parsesymbol = "^flevel"){
  
  # find the good names
  # select labels column
  param_position <- grep(pattern=parsesymbol, names(defvector))
  
  # get the param
  params <- defvector[param_position]
  
  # erase the NA
  without_na <- params[!is.na(params)]
  
  return(as.character(without_na))
}

# Helper : change the colnames
change_colnames <- function(actual_colnames, colname_dictionnary){
  
  new_colnames <- actual_colnames
  
  for(a_name in actual_colnames){
    if (a_name %in% colname_dictionnary) {
      new_colnames[new_colnames==a_name] <- names(colname_dictionnary[colname_dictionnary==a_name])
    } else {}
  }
  
  # A little bit more complicated for levels and labels, because have a indice
  new_colnames <- gsub(pattern=colname_dictionnary["flevel"], replacement="flevel",x=new_colnames)
  new_colnames <- gsub(pattern=colname_dictionnary["flabel"], replacement="flabel",x=new_colnames)
  
  return(new_colnames)
}

# Helper : complete colname_dict
complete_colname_dictionnary <- function(
  given_dictionnary, 
  default_dictionnary = c(
    rname       = "rname", 
    varlabel    = "varlabel", 
    description = "description", 
    type        = "type", 
    commentary  = "commentary", 
    flevel      = "flevel", 
    flabel      = "flabel"
  )) {
  
  complete_dict <- given_dictionnary
  
  for(one_name in names(default_dictionnary)) {
    if (! (one_name %in% names(given_dictionnary)) ){
      complete_dict <- c(complete_dict, default_dictionnary[one_name] )
    } else {}
  }
  
  return(complete_dict)
}

# Helper : check if the data.frame is purely character, else transform it

as.character.data.frame <- function(x, ...){
            as.data.frame(lapply(x, as.character), stringsAsFactors=F)
            
          }

# Helper : clean up a VariableDef data.frame. Transform all cell with space or NA as NA

clean_up_df <- function(dataframe) {
  
  matrixversion<-as.matrix(dataframe)
  # erase leading spaces
  matrixversion <- gsub(pattern="^ *", replacement="", matrixversion)
  # erase ending spaces
  matrixversion <- gsub(pattern="( *)$", replacement="", matrixversion)
  
  # empty cells
  matrixversion[matrixversion == ""] <- NA
  matrixversion[matrixversion == "NA"] <- NA
  
  return(as.data.frame(matrixversion, stringsAsFactors = FALSE))
}

###### Method for data.frame class ######

#' @export
#' @describeIn import_vardef


setMethod( 
  f="import_vardef", 
  signature="data.frame",
  definition=function(vardf, col_replacement){
    
    # Convert the data.frame classes to character. Avoid crash with factors.
    vardf <- as.character.data.frame(vardf)
    
    # Clean up
    vardf <- clean_up_df(vardf)
    
    # Replace the colnames of vardef if they are not standard
    if (!missing(col_replacement)) {
      
      # Create a dictionnary of replacement. Must be complete for change_colnames()
      complete_replacement_names <- complete_colname_dictionnary(col_replacement)
      
      # Change the colnames of vardf according to the equivalent given by user
      names(vardf) <- change_colnames(actual_colnames=names(vardf), 
                                      colname_dictionnary=complete_replacement_names)
    }
    
    # Read each line of the the data.frame
    lines <- seq_len(nrow(vardf))
    # Initialize a list to store the VariableDef
    list_descvar <- list()
    
    for (i in lines){
      
      a_line <- vardf[i,,drop=T]
      
#       if (a_line$type %in% c("factor","ordered")){
        # parse the levels and labels
        factor_levels <- parse_factor(defvector=a_line, parsesymbol="^flevel")
        
        factor_names <- parse_factor(defvector=a_line, parsesymbol="^flabel")
#       }
      
      list_descvar <- append(list_descvar, 
                             vardef( rname  = a_line$rname, 
                                      type   = a_line$type, 
                                      varlabel  = a_line$varlabel, 
                                      comment= a_line$description, 
                                      levels = factor_levels, 
                                      names  = factor_names
                                      )
                             )
    }
  
  
  return(database_def(list_descvar))

}
)

