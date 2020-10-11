#' Create a panel of plots for finding relationships
#'
#' @param dat Your data
#' @param var1 The bare variable you want on the x-axis
#' @param var2 The bare variable you want on the y-axis
#' @param distractors The number of distractor plots you want included. Defaults to 3.
#' @param answer Logical. TRUE if you want to play the game, FALSE otherwise.
#' @return A panel with several visualizations: one is the actual data and the rest are from shuffled data.
#' @examples
#' simViz(mtcars, mpg, cyl, 2)
#' @importFrom dplyr mutate
#' @importFrom rlang enquo quo_name !! :=
#' @importFrom purrr rerun
#' @importFrom ggplot2 ggplot aes_ geom_point theme_bw `%+%`
#' @importFrom utils menu
#' @importFrom magrittr %>%
#' @export

simViz <- function(dat, var1, var2, distractors = 3, answer = FALSE) {

  var1 <- rlang::enquo(var1)

  var2 <- rlang::enquo(var2)

  actual <- ggplot2::ggplot(dat, aes_(var1, var2), environment = environment()) +
    ggplot2::geom_point() +
    ggplot2::theme_bw()

  test <- purrr::rerun(distractors, {
    dat %>%
      dplyr::mutate(!!quo_name(var1) := sample(!!var1)) %>%
      ggplot2::ggplot(mapping = aes_(var1, var2), environment = environment()) +
      ggplot2::geom_point() +
      ggplot2::theme_bw()
    })

  test[length(test) + 1] = list(actual)

  test <- sample(test)

  multiplot(plotlist = test, cols = 2)

  if(answer == TRUE) {
    answer <- menu(c("No", "Yes"), title = "Are you ready to see the real visual?")

    if(answer == 2) {
      actual
    } else print("You probably don't have all day -- run it again and figure it out!")
  } else message("Good luck!")
}
