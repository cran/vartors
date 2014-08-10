# -*- encoding:ASCII -*-

##################
# Message and action to perform when package is attached
# Created the 2014-07-09 by Joris Muller
##################

.onAttach <- function(...){
  
  if(interactive()) {
    # if the session is driven by an human, send some message
    
    # Get the actual version of the package
    actual_version <- utils::packageVersion("vartors")
    
    # Prepare the message
    start_message <- paste0(
      "The package 'vartors' is actually under active developpement.\n",
      "There should be minor changes in the API between versions.\n",
      "You are loading the version ", actual_version,"\n",
      "For more information see https://github.com/jomuller/vartors"
      )

    # Make a message that should be suppressed 
    final_message <- packageStartupMessage(start_message)

    } else {
    
    # If it's not interactive, return NULL
    final_message <- NULL
  }
  
  return(final_message)
}