#' A helper function for simViz
#'
#' @param ... Your plots
#' @param plotlist A list objects of plots
#' @param file The variable you want on the y-axis
#' @param cols The number of columns
#' @param layout More specific layout stuff
#' @return A panel with several visualizations.
#' @examples
#' simViz(mtcars, mpg, cyl, 2)
#' @importFrom grid grid.newpage pushViewport viewport
#' @export

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  if (is.null(layout)) {
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }

  if (numPlots==1) {
    print(plots[[1]])

  } else {
    grid::grid.newpage()
    grid::pushViewport(grid::viewport(layout = grid::grid.layout(nrow(layout),
                                                                 ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = grid::viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
