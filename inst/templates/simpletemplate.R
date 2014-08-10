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

#< integer
#< numeric 
#< factor
# explore the raw data
head(rep_rawdata$rep_rname)
str(rep_rawdata$rep_rname)
#> numeric 
#> factor
#> integer

#< numeric
rep_cleandata$rep_rname <- as.numeric(rep_rawdata$rep_rname)
#> numeric

#< integer
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

#< factor
#< numeric
#< integer
# set the label
attr(rep_cleandata$rep_rname, "label") <- "rep_varlabel"

head(rep_cleandata$rep_rname)
str(rep_cleandata$rep_rname)
summary(rep_cleandata$rep_rname)

# number of NA
sum(is.na(rep_cleandata$rep_rname))
#> factor
#> numeric
#> integer
