# -*- Encoding:ASCII -*-
# <vartors template>
# Default template for English in R

#< header
######### Importation script ##########
# import data
rep_rawdata <- read.csv("rep_path_to_database")

# Change headers
names(rep_rawdata) <- rep_columns_names

# Make a copy
rep_cleandata <- rep_rawdata

#> header

#< numeric 
#< factor
#< integer
#< date
#< not_used
####### Clean the variable rep_rname #####
#> not_used

# explore the raw data
head(rep_rawdata$rep_rname)
str(rep_rawdata$rep_rname)

#> numeric 
#> factor
#> integer
#> date

#< not_used
# The variable rep_rname is not used for analysis
rep_cleandata$rep_rname <- NULL
#> not_used

#< numeric
# Set rep_varlable as a numeric
rep_cleandata$rep_rname <- as.numeric(rep_rawdata$rep_rname)
#> numeric

#< integer
# Set rep_varlable as an integer
rep_cleandata$rep_rname <- as.integer(rep_rawdata$rep_rname)
#> integer

#< factor
# Set rep_varlable as a factor
rep_cleandata$rep_rname <- factor(
  x = rep_rawdata$rep_rname,
  levels = rep_levels,
  labels = rep_names
)
#> factor

#< ordered
rep_cleandata$rep_rname <- factor(
  x = rep_rawdata$rep_rname,
  levels = rep_levels,
  labels = rep_names,
  ordered = TRUE
)
#> ordered
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

# number of NA

sum(is.na(rep_cleandata$rep_rname))
#> factor
#> numeric
#> integer
#> date

#< factor
# Make a plot
plot(rep_cleandata$rep_rname)
#> factor

#< numeric
#< integer
hist(rep_cleandata$rep_rname)
#> numeric
#> integer

#< footer
##### watch all ######

str(rep_cleandata)

####### Save the cleaned data ######
save(rep_cleandata, file="clean_data.Rdata")
#> footer
