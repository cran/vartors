# -*- Encoding:ASCII -*-

#########################
# Title : Test units the class ScriptOutput
# Created by Joris Muller the 2014-06-03
#########################

library(testthat)
context("ScriptOutput methods")

# !!!Warning!!!
# This test-unit have to write files. It does it in /var/tmp, then
# user have to have access to it
test_directory <- tempdir()

# Create VariableDef objects ---------------------------

numericvar <- vardef(
  "a_variable",
  type="numeric",
  varlabel="A big variable",
  comment="I want to try something with this numeric variable"
)

factorvar <- vardef(
  "another_variable", 
  type="factor",
  varlabel="A big variable", 
  comment="I want to try something with this numeric variable"
)

# Import some templates ---------------------------

# default template
onetemplate <- import_template()

another_template <- import_template(
  path = paste0(path.package("vartors"), "/templates/anothertemplate.R")
)

# Write some ScriptOutput objects

dm <- create_script(template = another_template, var_desc = factorvar)
dm2 <- create_script(template = another_template, var_desc = numericvar)

# Test write_file() method -------------------------

# Load the sample VariableDef
data(sample_descvar)

# Create the ScriptOutput object and hide the Warnings (due to
# too large rnames)
suppressWarnings(
  script <- create_script(var_desc = sample_descvar)
)

test_that("write_file method with no extension",{

  # Set a file path
  filename <- "test_script"
  test_path1 <- paste0(test_directory, filename)
  test_expected_path <- paste0(test_path1, ".R")
  
  # Suppres old file test
  if(file.exists(test_expected_path)) file.remove(test_expected_path)
  
  # Write a file
  expect_equal(write_file(script, file=test_path1), test_expected_path)
  # See if exists
  expect_true(file.exists(test_expected_path))
  # Clean
  file.remove(test_path1)
    })

test_that("write method with extension",{
  
  # Set a file path
  filename <- "test_script.R"
  test_path2 <- paste0(test_directory, filename)
  test_expected_path <- test_path2
  
  # Suppres old file test
  if(file.exists(test_expected_path)) file.remove(test_expected_path)
  
  # Write a file
  expect_equal(write_file(script, file=test_path2), test_expected_path)
  # See if exists
  expect_true(file.exists(test_expected_path))
  # Clean
  if(file.exists(test_expected_path)) file.remove(test_expected_path)
})


# c method ---------------
test_that("ScriptOutput c method",{
  expect_is(c(dm,dm2),"ScriptOutput")
  dm4 <- dm2
  dm4@language <- "Rmd"  
  expect_error(c(dm, dm4))
})

# Test header et footer
dm5 <- create_script(template=onetemplate, var_desc=factorvar)

# write(dm5, file = "../test.R")
dm6 <- create_script(template=import_template(language = "Rmd", idiom = "fr"), var_desc=factorvar)
# write(dm6, file = "../test")
