#' @title Spreadsheet column name from number
#' 
#' @description Convert an integer number to the equivalent column name in a spreadsheet. This is an helper function used internaly in \code{\link{descvars_skeleton}} to generate the variable column. For example, column 28 is "AB".
#' @param colnumber An integer. The number of the column.
#' 
#' @author Joris Muller
#' @export
#' @examples
#' colname_from_colnumber(3)
#' # "C"
#' colname_from_colnumber(27)
#' # "AA"
#' colname_from_colnumber(666)
#' # "XP"
#' @note This function have a bug : \code{colname_from_colnumber(53)} give AA instead of BA. The bug is \href{https://github.com/jomuller/vartors/issues/59}{listed in the bugtracking system as the issue 59} and will be fixed in a further version.
#' @keywords internal

colname_from_colnumber <- function(colnumber) {
  
  # Define the number of letter in the alphabet
  number_of_letters <- length(letters)
  
  # Number of the first letter
  num1 <- colnumber %% number_of_letters
  
  if(num1 == 0) num1 <- number_of_letters
  
  colname <- letters[num1]
  
  # Find if there is another(s) letters
  # that mean if it keep number after exact division
  num2 <- colnumber %/% (number_of_letters + 1)
  
  # If so, find the other letters (recursive function)
  if (num2 > 0) colname <- paste0( 
    colname_from_colnumber(num2),
    colname
  )
  
  return(toupper(colname))
}