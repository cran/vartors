# -*- ASCII -*-

# Description -----------------------------------------------------------------
# Title : Launch all tests units using Hadley Wickam's package(testthat)
# Date : 2014-05-06
# By : Joris Muller
###############################################################################

library(testthat)
library(vartors)

# Test units are placed in ints/testthat and lauched by this command
test_check(package="vartors")