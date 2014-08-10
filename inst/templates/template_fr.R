# -*- Encoding:UTF-8 -*-
# <vartors template>
# Template par défaut en Français
# Utilisateurs de Windows : attention, encodé en UTF-8!

#< header
######### Script d'import de données ##########

# Importer le tableau de données en CSV
rep_rawdata <- read.csv( "rep_path_to_database", stringsAsFactors = FALSE)

# Changer le nom de colonnes en fonction de ceux définis dans le 
# cahier de variable
names(rep_rawdata) <- rep_columns_names

# Créer une copie "propre" des données
rep_cleandata <- rep_rawdata

#> header

#< numeric 
#< factor
#< integer
#< date
#< not_used
####### Nettoyage de la variable rep_rname #####
#> not_used

# explorer les données de base
head(rep_rawdata$rep_rname)
str(rep_rawdata$rep_rname)

#> numeric 
#> factor
#> integer
#> date

#< not_used
# La variable rep_rname n'est pas utilisée pour l'analyse
rep_cleandata$rep_rname <- NULL
#> not_used

#< numeric
# La variable rep_rname est décrite comme quantitive
rep_cleandata$rep_rname <- as.numeric(rep_rawdata$rep_rname)
#> numeric

#< integer
# La variable rep_rname est décrite comme un entier
rep_cleandata$rep_rname <- as.integer(rep_rawdata$rep_rname)
#> integer

#< factor
# La variable rep_rname est décrite comme une variable qualitative
rep_cleandata$rep_rname <- factor(
  x = rep_rawdata$rep_rname,
  levels = rep_levels,
  labels = rep_names,
  ordered = rep_orderedfactor
)
#> factor

#< date
# La variable rep_rname est décrite comme une date
rep_cleandata$rep_rname <- as.Date(rep_rawdata$rep_rname, format="rep_unit")
#> date

#< date
#< integer
#< factor
#< numeric
# Intégrer l'étiquette de la variable
attr(rep_cleandata$rep_rname, "label") <- "rep_varlabel"

# Explorer rapidement
head(rep_cleandata$rep_rname)
str(rep_cleandata$rep_rname)
summary(rep_cleandata$rep_rname)

# Nombre de manquants

sum(is.na(rep_cleandata$rep_rname))
#> factor
#> numeric
#> integer
#> date

#< factor
# Graphique rapide
plot(rep_cleandata$rep_rname)
#> factor

#< numeric
#< integer
# Graphique rapide
hist(rep_cleandata$rep_rname)
#> numeric
#> integer

#< footer
##### Explorer l'ensemble ######

str(rep_cleandata)

####### Sauvegarder ######
save(rep_cleandata, file="clean_data.Rdata")
#> footer
