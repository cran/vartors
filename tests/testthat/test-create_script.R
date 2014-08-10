# -*- Encoding:ASCII -*-

#########################
# Title : Test units the methods create_script
# Created by Joris Muller the 2014-06-08
#########################

# import testthat package
library(testthat)

context("Methods create_script")

# Create a simple description of a numeric variable
numericvar <- vardef(
  rname       = "a_numeric_variable",
  type        = "numeric",
  varlabel    = "A big numeric variable",
  description = "Not really useful",
  comment     = "I want to try something with this numeric variable"
  )

# Create a simple description of a factor variable 
factorvar <- vardef(
  rname       = "another_variable", 
  type        = "factor",
  varlabel    = "A big variable", 
  description = "another unuseful factor variable",
  comment     = "I want to try something with this numeric variable"
  )

# Import some templates
onetemplate <- import_template()
another_template <- import_template(
  path=paste0(path.package("vartors"), "/templates/anothertemplate.R")
  )

test_that("create_script for VariableDef",{
  expect_is(create_script(template=onetemplate, var_desc=numericvar),"ScriptOutput")
  create_script(template=another_template, var_desc=factorvar)
})

list_of_descvars <- list(vardef("id",type = "integer"),vardef("age",type = "numeric"),vardef("city",type = "factor"))

test_that("DatabaseDef create_script methods",{
database_description <- database_def(list_of_descvars)

multivar_dm <- create_script(database_description)
expect_is(multivar_dm,"ScriptOutput")
expect_output(multivar_dm,"raw_data\\$city")

})


# Create a test df
testdf <- read.table(header = TRUE, stringsAsFactors=FALSE, 
                     text="
                     rname  varlabel  description  type  flevel1  fname1  flevel2  fname2  flevel3  fname3
                     id        Identification  'Unique ID'  integer NA NA NA NA NA NA
                     age       'Age of patient' NA integer NA NA NA NA NA NA
                     city      'City'  'City where live actually' factor 1 Strasbourg 2 Paris 3 London
                     weight    'Weight' 'Weight at the beginning of the study' numeric NA NA NA NA NA NA")


a_dm <- create_script(testdf)

test_that("Method create_script for data.frame",
          expect_is(a_dm,"ScriptOutput")
)

test_that("header and footer could be turn off",{
  expect_output(
    create_script(vardef("test", type="numeric"), header=FALSE, footer=FALSE), 
    "hist\\(clean_data\\$test\\)\\n\\n#- End of the script in R -#")
  expect_output(create_script(vardef("test", type="numeric"), header=FALSE, footer=TRUE), "save\\(clean_data")
})

test_that("fix7 : when no label given with level, names=levels",{
  noname <- vardef(varlabel = "noname", type = "factor", levels = c("Men","Women"))
  expect_output(create_script(noname), "labels = c\\('Men', 'Women'\\)")
  })