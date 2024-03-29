% Generated by roxygen2 (4.0.1): do not edit by hand
\name{list_templates}
\alias{list_templates}
\title{List available vartors templates in a folder}
\usage{
list_templates(dirpath)
}
\arguments{
\item{dirpath}{path to the directory. If missing, the directory of the \pkg{vartors} package with built-in templates.}
}
\value{
Return a character vector with the names of the files which are \pkg{vartors} templates.
}
\description{
List the file in the specified directory and check if these files are \pkg{vartors} templates. To detect, a file as \pkg{vartors} templates, the file must have one of the supported extension (`.R` or `.Rmd` for the moment) and have the tag \code{<vartors template>} in the first lines.
}
\examples{
# Get the list of built-in template
list_templates()
}
\author{
Joris Muller
}
\seealso{
\link[=ScriptTemplate]{Script templates} could be imported with \code{\link{import_template}}. This function use \code{\link{is_vartors_template}} to check if a file is a vartors template.

\code{\link{is_vartors_template}}
}

