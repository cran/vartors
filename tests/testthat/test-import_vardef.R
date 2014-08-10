# -*- Encoding:ASCII -*-

#########################
# Title : Test units for the methods import_vardef
# Created by Joris Muller the 2014-06-03
#########################

# import  testthat package
library(testthat)

context("Test import_vardef methods")

# Create a test df
testdf <- read.table(header = TRUE, stringsAsFactors=FALSE, 
                     text="
rname  varlabel  description  type  flevel1  flabel1  flevel2  flabel2  flevel3  flabel3
id        Identification  'Unique ID'  integer NA NA NA NA NA NA
age       'Age of patient' NA integer NA NA NA NA NA NA
city      'City'  'City where live actually' factor 1 Strasbourg 2 Paris 3 London
weight    'Weight' 'Weight at the beginning of the study' numeric NA NA NA NA NA NA")

q <- import_vardef(testdf)

test_that("Method for data.frame",
          expect_is(q,"DatabaseDef")
)


test_that("Helper function change_colnames",{
  original <- c("variable","type", "unuseful column","etiquette")
  dict <- c("rname"="variable","varlabel"="etiquette","flabel"="flabel","flevel"="flevel")
  expect_equal(change_colnames(actual_colnames=original, colname_dictionnary=dict),
               c("rname", "type", "unuseful column", "varlabel"))
  
  original <- c("variable","type", "unuseful column","modalite1","clef1","modalite2","clef2")
  dict <- c("rname"="variable","varlabel"="etiquette","flabel"="modalite","flevel"="clef")
  expect_equal(change_colnames(actual_colnames=original, colname_dictionnary=dict),
               c("rname", "type", "unuseful column", "flabel1", "flevel1", "flabel2", 
                 "flevel2"))
})

test_that("Helper function complete_colname_dictionnary",
          expect_equal(complete_colname_dictionnary( given_dictionnary=c("type"="genre"))[1:2],
                       c( "type"  = "genre","rname" ="rname"))
)


# Create a test df with non standard header
testdf2 <- read.table(header = TRUE, stringsAsFactors=FALSE, 
                      text="
variable  etiquette  description  type  code1  modalite1  code2  modalite2  code3  modalite3
id        Identification  'Unique ID'  integer NA NA NA NA NA NA
age       'Age of patient' NA integer NA NA NA NA NA NA
city      'City'  'City where live actually' factor 1 Strasbourg 2 Paris 3 London
weight    'Weight' 'Weight at the beginning of the study' numeric NA NA NA NA NA NA")

q2 <- import_vardef(testdf2, c("rname"="variable","varlabel"="etiquette","flevel"="code","flabel"="modalite"))

test_that("non standard header transformation",{
  expect_is(q2, "DatabaseDef")
  expect_equal(length(q2@variables_definitions), 4)
}
)

# Should know how to import no only character in data.frame

test_that("Import data.frame not only with character",{
  testdf3 <- read.table(header = TRUE, stringsAsFactors=TRUE, 
                        text="
rname  varlabel  description  type  flevel1  flabel1  flevel2  flabel2  flevel3  flabel3
id        Identification  'Unique ID'  integer NA NA NA NA NA NA
age       'Age of patient' NA integer NA NA NA NA NA NA
city      'City'  'City where live actually' factor 1 Strasbourg 2 Paris 3 London
weight    'Weight' 'Weight at the beginning of the study' numeric NA NA NA NA NA NA"
  )
  q3 <- import_vardef(testdf3)
  expect_is(q3, "DatabaseDef")
  expect_equal(length(q3@variables_definitions), 4)
}
)