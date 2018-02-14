#' Create a panel of plots for finding relationships
#'
#' @param dat Your data
#' @param var1 The bare variable you want on the x-axis
#' @param var2 The bare variable you want on the y-axis
#' @param distractors The number of distractor plots you want included. Defaults to 3.
#' @return A panel with several visualizations: one is the actual data and the rest are from shuffled data.
#' @examples
#' simViz(mtcars, mpg, cyl, 2)
#' @export

simViz <- function(dat, var1, var2, distractors = 3) {

  library(rlang); library(purrr); library(dplyr); library(ggplot2)

  source("R/multiplot.R")

  var1 <- enquo(var1)

  var2 <- enquo(var2)

  actual <- ggplot(dat, aes_(var1, var2), environment = environment()) +
    geom_point() +
    theme_bw()

  test <- purrr::rerun(distractors, {
    dat %>%
      mutate(!!quo_name(var1) := sample(!!var1)) %>%
      ggplot(mapping = aes_(var1, var2), environment = environment()) +
      geom_point() +
      theme_bw()
    })

  test[length(test) + 1] = list(actual)

  test <- sample(test)

  multiplot(plotlist = test, cols = 2)

  answer <- menu(c("No", "Yes"), title = "Are you ready to see the real visual?")

  if(answer == 2) {
    actual
  } else print("You probably don't have all day -- run it again and figure it out!")

}

# debugonce(simFunction)

# simViz(mtcars, mpg, cyl, 5)

# dat = dat
# x = NULL
# y = NULL
# color = NULL
# fill = NULL
# geoms = c("point", "bar", "line")
# facet = NULL
