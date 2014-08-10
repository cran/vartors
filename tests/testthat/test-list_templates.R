# -*- Encoding:ASCII -*-

#########################
# Title : Test units the function list_templates()
# Created by Joris Muller the 2014-07-23
#########################

# import testthat package
library(testthat)

context("list_templates function")

builtin_list <- list_templates()

test_that("list builtin",{
  
  expect_is(builtin_list, "character")
  expect_more_than(length(builtin_list), 4)
})

test_that("is_template helper function", {
  path_to_a_builtin <- paste0(path.package("vartors"),"/templates/simpletemplate.R")
  expect_equal(is_vartors_template(path_to_a_builtin), TRUE)
})