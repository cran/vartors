# -*- Encoding:ASCII -*-

#########################
# Title : Test units the class Dm_template
# Created by Joris Muller the 2014-06-03
#########################

# import Hadley Wickam's testthat package
library(testthat)

# Test units for Dm_template class

context("ScriptTemplate class")

test_that("ScriptTemplate object construction",{
  a <- import_template()
  expect_is(a, "ScriptTemplate")
  expect_equal(a@raw_template[1], "# -*- Encoding:ASCII -*-" )
}
)