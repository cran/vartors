# -*- Encoding:ASCII -*-

#########################
# Title : Test units the class Descvar
# Created by Joris Muller the 2014-06-03
#########################

# import Hadley Wickam's testthat package
library(testthat)

context("Descvar class")

test_that("Descvar class definition",{
  expect_output(showClass("VariableDef"),"Class \"VariableDef\"")
  empty_descvar <- new(Class="VariableDef")
  expect_is(empty_descvar,"VariableDef")

  # Check if there is the slots expected
  # Maybe this test is not usefull
  expect_equal(slotNames(empty_descvar), 
               c("varlabel",
                 "description",
                 "comment",
                 "unit",
                 "type", 
                 "rname",  
                 "levels", 
                 "names")
               )
}
)

##### Validity check -----------
test_that("Validity check for slot rname",{
  expect_error(validObject(new("VariableDef")), "'rname' must be of length one")
  expect_error(validObject(new("VariableDef",rname="var space")), "Must contain only")
  expect_error(validObject(new("VariableDef",rname="spe$$cialchar")), "Must contain only")
  expect_error(validObject(new("VariableDef",rname="2startnumber")))
  expect_error(validObject(new("VariableDef",rname="vargood",varlabel=c("a","b"))))
 
  expect_error(validObject(new("VariableDef",rname="vargood",type="ds")))
  expect_error(new("VariableDef",rname="vargood",type="numeric", names=c("stupid","label")),"could be only set for")
})

test_that("Validity check for slot varlabel",{
  expect_warning(validObject(new("VariableDef",rname="vargood", type="not_used",varlabel="really too long label with more than 40 characters")))
})


test_that("VariableDef constructor",{
  expect_is( vardef("test"), "VariableDef")
  # If no rname is provided, then it is created
  no_rname <- vardef(varlabel = "mauvais nom")
  expect_equal(no_rname$rname, "mauvais.nom")
  expect_equal(no_rname$type, "not_used")
  expect_is(no_rname, "VariableDef")
  
  # If no varlabel is provided, then create one according to the name
  no_varlabel <- vardef(rname = "test")
  expect_equal(no_varlabel$varlabel, "test")
  expect_is(no_varlabel, "VariableDef")
  
  # If no varlabel or rname, expect errors
  expect_error(vardef())
  
  # If description provided, added
  vardef(varlabel = "test", description = "blablabla")
  
  # If comment provided, added
  vardef(varlabel = "test", comment = "bliblibla")
}
)

test_that("VariableDef dollar getteur",{
  descvar_object <- vardef("test")
  expect_equal(descvar_object$rname,"test")
  expect_error(descvar_object$wrongslot,"wrong")
}
)

test_that("add default values",{
  expect_equal(vardef("une_date",type="date")$unit,"%d/%m/%Y")
  expect_output(vardef("une_date",type="factor", levels=c(1:5)),"levels = 1, 2, 3, 4, 5")
  expect_output(vardef(rname = "poids",type="integer",unit="Kg"),"poids \\(Kg\\)")
}
)

# Fix1 rname should accept non perfect name and send only a warning in this case

test_that("Throw warning instead of stop",{
  expect_warning(vardef("aNonPerfectVar"))
  expect_warning(vardef("a_tooooooooo_long_var"))
  expect_warning(vardef("LeadingUpper"))
}
  )

test_that("Deal with NA",{
  expect_is(vardef("NAtype", type=NA), "VariableDef")
})

test_that("Warning if levels or labels in not factor class",{
  expect_warning(a <- vardef("jd", type = "not_used", levels = c("sqd")))
  expect_equal(a$rname, "jd")
  })

test_that("fix7 : when no label given with level, names=levels",{
  expect_is(vardef(varlabel = "noname", type = "factor", levels = c("Men","Women")), "VariableDef")
}
)

test_that("If NA given to argument",{
  # factor
  afactor <- vardef(varlabel = "afactor", type = "factor", levels = NA)
  expect_equal(afactor$levels, character())
  expect_equal(afactor$names, character())

  afactor2 <- vardef(varlabel = "afactor", type = "factor", levels = NA, names = NA)
  expect_equal(afactor2$levels, character())
  expect_equal(afactor2$names, character())
})