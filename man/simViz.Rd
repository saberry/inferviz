% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simViz.R
\name{simViz}
\alias{simViz}
\title{Create a panel of plots for finding relationships}
\usage{
simViz(dat, var1, var2, distractors = 3, answer = FALSE)
}
\arguments{
\item{dat}{Your data}

\item{var1}{The bare variable you want on the x-axis}

\item{var2}{The bare variable you want on the y-axis}

\item{distractors}{The number of distractor plots you want included. Defaults to 3.}

\item{answer}{Logical. TRUE if you want to play the game, FALSE otherwise.}
}
\value{
A panel with several visualizations: one is the actual data and the rest are from shuffled data.
}
\description{
Create a panel of plots for finding relationships
}
\examples{
simViz(mtcars, mpg, cyl, 2)
}
