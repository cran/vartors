# -*- Encoding:ASCII -*-

#########################
# Title : Test units the class Descvar
# Created by Joris Muller the 2014-06-03
#########################

# import testthat package
library(testthat)

context("DatabaseDef class")

test_that("simple construct",{
  expect_is(new("DatabaseDef"),"DatabaseDef")
  expect_is(
    new("DatabaseDef", "variables_definitions"=list(vardef(rname="age",type="numeric"))), "DatabaseDef")
})

list_of_descvars <- list(vardef("id","integer"),vardef("age","numeric"),vardef("city","factor"))
database_description <- database_def(list_of_descvars)

test_that("constructor",{

  expect_is(database_description,"DatabaseDef")
})

test_that("get_all_rname Method should get all the rnames", {
  column_names <- get_all_rnames(database_description)
  expect_is(column_names, "character")
  expect_equal(column_names, c("id", "age", "city"))
}
)

test_that("rep_columns_names should be placed properly",{
  expect_output(create_script(database_description)@header, "city")
}
)