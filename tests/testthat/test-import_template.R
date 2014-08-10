# -*- Encoding:ASCII -*-

#########################
# Title : Test units for the function import template
# Created by Joris Muller the 2014-06-09
#########################

library(testthat)

context("import_template")

test_that("detect_language helper function",{
  a_r_path <- "ds/file.R"
  expect_equal(detect_language(a_r_path),"R")
  expect_equal(detect_language("ds/file.r"),"R")
  expect_equal(detect_language("ds/file.Rmd"),"Rmd")
  expect_equal(detect_language("ds/file.Rnw"),"Rnw")
  expect_warning(detect_language("ds/file.txt"))
})

test_that("import_template function",{
  a <- import_template()
  expect_is(a, "ScriptTemplate")
  expect_equal(a@language, "R")
  })

test_that("New import builtin", {
  b <- import_template(language = "Rmd", idiom = "fr")
  expect_equal(b@language, "Rmd")
})

test_that("use the builtin argument",{
  c <- import_template(builtin = "template_fr.Rmd")
  expect_equal(c@language, "Rmd")
  d <- import_template(builtin = "anothertemplate.R")
  expect_equal(d@language, "R")
})