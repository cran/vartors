# -*- Encoding:ASCII -*-

#########################
# Title : Test units for the function create_descvars
# Created by Joris Muller the 2014-07-09
#########################

library(testthat)

context("Function create_descvars")

data(example_df)
a_descvars <- descvars_skeleton(example_df, 6)
default_descvars <- descvars_skeleton()

test_that("Create DatabaseDef from data.frame",{
  expect_is(a_descvars, "data.frame")
  expect_equal(a_descvars, default_descvars)
})

test_that("colname_from_colnumber helper function",{
  one <- colname_from_colnumber(1)
  expect_is(one, "character")
  expect_equal(length(one), 1)
  expect_equal(colname_from_colnumber(3), "C")
  expect_equal(colname_from_colnumber(26), "Z")
  expect_equal(colname_from_colnumber(27), "AA")
  expect_equal(colname_from_colnumber(28), "AB")
})

test_that("find_levels helper function", {
  foo <- c(1,4,6,3,3,3,3,2,0,9)
  bar <- c("one","one","two","three","five")
  
  expect_equal(find_levels(foo, 10), c("0", "1", "2", "3", "4","6", "9"))
  expect_equal(find_levels(bar, 10), c("five", "one", "three", "two"))
})

test_that("is_maybe_factor helper function", {
  foo <- 1:100
  bar <- rbinom(100, 4, 0.3)
  
  expect_true(is_maybe_factor(bar, 5))  
  expect_false(is_maybe_factor(foo, 5))
})

test_that("list_level helper function", {
  data(example_df)
  listlevels <- list_level(example_df, 6)
  expect_is(listlevels, "data.frame")
  })