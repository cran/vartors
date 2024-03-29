% Generated by roxygen2 (4.0.1): do not edit by hand
\name{script_template}
\alias{script_template}
\title{Create a \code{ScriptTemplate} object}
\usage{
script_template(blocs, language = "R", raw_template)
}
\arguments{
\item{blocs}{A list. Each element of the list is a character vector with the lines for a type.}

\item{language}{A length-one character vector. The extension of the language used in the template. Should be \code{R}, \code{Rmd} or \code{Rnw}}

\item{raw_template}{A character vector with the raw template}
}
\description{
Create a \code{ScriptTemplate} object
}
\author{
Joris Muller
}
\seealso{
\code{\link{ScriptTemplate-class}}. More information about template in the \link[=ScriptTemplate]{dedicated documentation}.
}
\keyword{internal}
\keyword{template}

