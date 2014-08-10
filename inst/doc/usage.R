## ----, echo = FALSE, message = FALSE-------------------------------------
library(knitr)
knitr::opts_chunk$set(
  comment = "#>",
  error = FALSE,
  tidy = FALSE
)

library(vartors)

## ------------------------------------------------------------------------
# Load the database
raw_data <- read.csv(file = paste0(path.package("vartors"),"/examples/bad_database.csv"))

## ------------------------------------------------------------------------
str(raw_data)

## ----, eval=FALSE--------------------------------------------------------
#  clean_data <- raw_data
#  clean_data$initial <- as.character(raw_data$initial)
#  clean_data$birth <- as.Date(raw_data$birth, format = "%Y-%m-%d")
#  

## ----, echo=FALSE--------------------------------------------------------
# Because limits in detection of factors not implemented yet
raw_data$birth <- as.character(raw_data$birth)
raw_data$initial <- as.character(raw_data$initial)
raw_data$height <- as.character(raw_data$height)
raw_data$weight <- as.character(raw_data$weight)
raw_data$siblings <- as.character(raw_data$siblings)

## ----, results='asis'----------------------------------------------------
library(vartors)
desc_skeleton <- descvars_skeleton(raw_data)
kable(desc_skeleton[,1:12])

## ----, eval=FALSE--------------------------------------------------------
#  desc_complete <- edit(desc_skeleton)

## ----, eval=FALSE--------------------------------------------------------
#  write.csv(desc_skeleton, file = "variables_description.csv")

## ------------------------------------------------------------------------
# Path to csv in the vartors package. 
# It's a specific case. In real usage, use the path to your file instead
path_to_vardesc <- paste0(path.package("vartors"),
                          "/examples/variables_description_bad_database.csv")
# Import the csv
complete_vardesc <- read.csv(file = path_to_vardesc)

## ----, echo=FALSE, results='asis'----------------------------------------
kable(complete_vardesc[, 1:8])

## ----, echo=FALSE, results='asis'----------------------------------------
kable(complete_vardesc[, c(1:2,9:17)])

## ----, warning=FALSE-----------------------------------------------------
suppressWarnings(
database_def_object <- import_vardef(complete_vardesc)
)

## ------------------------------------------------------------------------
database_def_object

## ------------------------------------------------------------------------
simple_script <- create_script(var_desc = database_def_object)

## ------------------------------------------------------------------------
simple_script

## ----, eval=FALSE--------------------------------------------------------
#  write_file(object = simple_script, filepath = "my_import_script1.R")

## ----, eval=FALSE--------------------------------------------------------
#  write_file(create_script(var_desc = complete_vardesc), filepath = "my_import_script1.R")

## ----, eval=FALSE--------------------------------------------------------
#  ?import_template

## ------------------------------------------------------------------------
rmd_template <- import_template(builtin = "template_fr.Rmd")

## ------------------------------------------------------------------------
rmd_script <- create_script(var_desc = database_def_object, template = rmd_template)

## ------------------------------------------------------------------------
rmd_script

## ----, eval=FALSE--------------------------------------------------------
#  ?template

## ----, eval=FALSE--------------------------------------------------------
#  export_template(builtin = "template_fr.Rmd", to = "mytemplate.Rmd")

## ----, eval=FALSE--------------------------------------------------------
#  my_template <- import_template(path = "mytemplate.Rmd")

## ----, eval=FALSE--------------------------------------------------------
#  create_script(var_desc = database_def_object, template = my_template)

