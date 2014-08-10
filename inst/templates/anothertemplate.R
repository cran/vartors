# <vartors template>
# Exemple de template

#< head
# exemple de template
# copy 
#> head

#< not_used
# This variable is not used for analysis
rep_cleandata$rep_rname <- NULL
#> not_used

#< numeric 
#< factor
#< integer
#< date
####################
# Clean the variable rep_rname
####################

# explore the raw data
head(rep_rawdata$rep_rname)
str(rep_rawdata$rep_rname)

#> numeric 
#> factor
#> integer
#> date

#< numeric
# Set this var as an numeric
rep_cleandata$rep_rname <- as.numeric(rep_rawdata$rep_rname)
#> numeric

#< integer
# Set this var as an integer
rep_cleandata$rep_rname <- as.integer(rep_rawdata$rep_rname)
#> integer

#< factor
# Set it as a factor
rep_cleandata$rep_rname <- factor(
  x = rep_rawdata$rep_rname,
  levels = rep_levels,
  labels = rep_names,
  ordered = rep_orderedfactor
)
#> factor

#< date
# set this variable as a date
rep_cleandata$rep_rname <- as.Date(rep_rawdata$rep_rname, format="rep_unit")
#> date

#< date
#< integer
#< factor
#< numeric
# set the label
attr(rep_cleandata$rep_rname, "label") <- "rep_varlabel"

head(rep_cleandata$rep_rname)
str(rep_cleandata$rep_rname)
summary(rep_cleandata$rep_rname)
plot(rep_cleandata$rep_rname)

# number of NA
sum(is.na(rep_cleandata$rep_rname))


#> factor
#> numeric
#> integer
#> date
