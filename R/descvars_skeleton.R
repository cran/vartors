# -*- Encoding:ASCII -*-

#########################
# Title : Function definition create_descvars
# Created by Joris Muller the 2014-07-09
#########################

#' @title Skeleton of a definition of variables table 
#' @description Create a \emph{\link[=variable_definition_table]{definition of variables table}} skeleton in a data.frame from a database. Basically, this function gets the header of the database, puts it in the column "originalname", gets the type and put them in "type", adds column "spreadsheet column letter" and all the others columns to have a \emph{\link[=variable_definition_table]{definition of variables table}}.
#' @param database A data.frame with the data imported for example with \code{read.csv} or \code{read.xslx}.
#' @param factor_detect An integer. If the number of unique value in a variable is below this threshold, then it will be considered as a factor
#' @return Return a \code{data.frame}. This \code{data.frame} could be used as a skeleton of descvar, for example exporting it in a file with \code{write.csv} or \code{write.xlsx}
#' @export
#' @author Joris Muller
#' @examples
#' # Import a database
#' data(example_df)
#' head(example_df)
#' 
#' # Create a skeleton of DatabaseDef from this database
#' descvars_sk <- descvars_skeleton(example_df)
#' descvars_sk[,1:10]
#' 
#' # This skeleton could be written on the disk in csv
#' # to be completed later in a spreadsheet sofware
#' \dontrun{
#' write.csv(descvars_sk, file="Variables_description.csv")
#' }
#' # or in Excel
#' \dontrun{
#' libary(openxslx)
#' write.xlsx(descvars_sk, file="Variables_description.xlsx")
#' }

descvars_skeleton <- function(database, factor_detect = 6) {
  
  if(missing(database)) database <- example_df
  
  originalname <- varlabel <- colnames(database)
  
  type <- sapply(database, function(x) {
    if(is_maybe_factor(x, n_threshold = factor_detect)) return("factor")
    else class(x)[1]
  } )
  
  column <- spreadsheet_column_names(ncol(database))
  rname <- make.names(originalname)
  
  # TODO : add levels and labels for factor and ordered
  # If factor, put levels in a list with "flevel1", "flevel2"...
  # harder for the levels
  
  descvars_skeleton <- data.frame(column, originalname, varlabel, description = NA, comment = NA, unit = NA, type, rname )
  
  descvars_skeleton <- cbind(descvars_skeleton, list_level(database, factor_detect))
  rownames(descvars_skeleton) <- NULL
  return(descvars_skeleton )
}

spreadsheet_column_names <- function(n_column){
  
  return(sapply(1:n_column, colname_from_colnumber))

}



is_maybe_factor <- function(variable, n_threshold = 5) {
  possible_levels <- unique(variable)
  if(class(variable)[1] %in% c("factor","ordered")) return(TRUE)
  else if(length(possible_levels) <= n_threshold) return(TRUE)
  else return(FALSE)
}

# find unique levels and order them
find_levels <- function(variable, factor_threshold) {
  if( is_maybe_factor(variable, factor_threshold)){
    if(class(variable)[1] %in% c("factor","ordered"))
      return(levels(variable))
    else {
      raw_levels <- unique(variable)
      # order
      return(as.character(raw_levels[order(raw_levels)]))
    }
  } else {
    return(NA)
  }
}

list_level <- function(database, factor_threshold) {
# Pour chaque rechecher les levels
# Si pas factor ou ordered, mettre NA
list_level <- lapply(database, find_levels, factor_threshold)

# Trouver le nombre max de level
max_level <- max(sapply(list_level, length))

# Ajouter des NA à ceux qui n'ont pas le max
list_level2 <- lapply(list_level, function(x){
  nb_level <- length(x)
  x <- c(x, rep(NA, (max_level - nb_level)))
  return(x)
  
})

list_t <- as.list(as.data.frame(t(as.data.frame(list_level2))))

list_t2 <- rep(list_t, each=2)

names(list_t2) <- paste0(rep(c("flevel","flabel"), max_level), rep(1:max_level, each=2))

list_t2 <- as.data.frame(lapply(list_t2, as.character), stringsAsFactors = FALSE)
return(list_t2)
}

#' Write an Excel VariableDef skeleton
#' @param filepath path to the file to create
#' @export
excel_skeleton <- function(filepath ="variables_description.xlsx") {
  skeleton_file_path <- paste0(
    path.package("vartors"),
    "/descvars_skeletons/descvar_skeleton_en.xlsx")
  
  copy_ok <- file.copy(from = skeleton_file_path, to = filepath)
  return(invisible(copy_ok))
}