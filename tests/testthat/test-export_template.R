# -*- Encoding:ASCII -*-

#########################
# Title : Test units for the function export_template
# Created by Joris Muller the 2014-06-03
#########################

library(testthat)
context("Function export_template")

test_that("write the default file",{
  
  test_path1 <- tempfile( pattern = "template_test", fileext = ".R")
  
  # Write a file
  expect_equal(export_template("template_en.R", to = test_path1), test_path1)
  # See if exists
  expect_true(file.exists(test_path1))
  # Clean
})

# test_that("Errors if file not exists", {
#   expect_error(export_template("tralalala.R"))
# })

test_that("return path if dir", {
  test_path2 <- paste0(tempdir(),"/")
  
  full_path <- paste0(test_path2, "template_en.R")
  # Write a file
  expect_equal(export_template("template_en.R", to = test_path2),full_path )
  # See if exists
  expect_true(file.exists(full_path))
})