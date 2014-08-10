# -*- Encoding:ASCII -*-

#########################
# Title : Test units the template "Rmd_fr"
# Created by Joris Muller the 2014-07-01
#########################

# import Hadley Wickam's testthat package
library(testthat)

context("Rmd_fr template")

# Create the script for a simple numeric

numericvar <- vardef(rname = "age", varlabel = "Age a la consultation", description = "Age demandee lors de la consultation. Se base sur ce que dit le patient etant donne que la date de naissance est parfois inconnue", comment = "Parfois age approximatif", type = "numeric" )

rmd_fr_template <- create_script(var_desc = numericvar, template =import_template(language = "Rmd",idiom = "fr"))

test_that("numeric var for Rmd_fr template",{
  expect_is(rmd_fr_template, "ScriptOutput")
  expect_output(rmd_fr_template, "- Nom dans R : age")
})

data(sample_descvar)
rmd_template <- import_template(language = "Rmd", idiom = "fr")

rmd_script <- create_script(var_desc = sample_descvar, template = rmd_template)
test_that("Rmd script complete",{
  expect_is(rmd_script, "ScriptOutput")
} )
#write(rmd_script)