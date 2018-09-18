#' Create a table of model coefficients
#'
#' @param dat Your data
#' @param dv The bare variable you want as the dv in your model
#' @param ... The bare variables you want as the predictors in your model
#' @param distractors The number of distractor coefficients you want included. Defaults to 3.
#' @param answer Logical. TRUE if you want to play the game, FALSE otherwise.
#' @return A data.frame with several sets of coefficients.
#' @examples
#' simMod(mtcars, mpg, hp, cyl)
#' @export

simMod <- function(dat, dv, ..., distractors = 3, answer = FALSE) {
  library(rlang); library(purrr); library(dplyr); library(ggplot2)

  dv <- enquo(dv)

  if(is.numeric(dat[, quo_name(dv)]) == FALSE) {
    stop("Your dv needs to be numeric! Just convert it and try again.")
  }

  predictors <- tidyselect::vars_select(colnames(dat), ...) %>%
    paste(., collapse = " + ")

  if(predictors == "") {
    stop("You need to include at least one predictor in your model!\nThat is the purpose of the dots in the function.")
  }

  modelCreator <- paste(quo_name(dv), "~", predictors, sep = " ")

  actual <- lm(modelCreator, data = dat)

  actual <- as.data.frame(t(actual$coefficients))

  test <- purrr::rerun(distractors, {
    mod <- dat %>%
      mutate(!!quo_name(dv) := sample(!!dv)) %>%
      lm(modelCreator, data = .)

    as.data.frame(t(mod$coefficients))
  })

  test <- do.call("rbind", c(test, actual))

  test <- test[sample(nrow(test)), ]

  rownames(test) <- 1:nrow(test)

  print(test)

  if(answer == TRUE) {
    answer <- menu(c("No", "Yes"), title = "Are you ready to see the real test statistics?")

    if(answer == 2) {
      actual
    } else print("You probably don't have all day -- run it again and figure it out!")
  } else message("Good luck!")
}
