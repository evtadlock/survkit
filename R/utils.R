#' Calculate Golden Ratio Dimensions
#'
#' Helper function to generate plot dimensions following the golden ratio (1:1.618).
#' Default is optimized for posters at 600 DPI.
#'
#' @param width Width in inches (default 10)
#' @param ratio Golden ratio multiplier (default 1.618)
#' @return Named list with width and height
#' @export
#'
#' @examples
#' dims <- golden_ratio(width = 10)
#' # Use with ggsave:
#' # ggsave("plot.png", width = dims$width, height = dims$height, dpi = 600)
golden_ratio <- function(width = 10, ratio = 1.618) {
  list(
    width = width,
    height = width / ratio
  )
}

#' Save survkit Plot at 600 DPI
#'
#' Convenience wrapper for ggsave with 600 DPI and golden ratio dimensions.
#'
#' @param filename File name/path for output
#' @param plot Plot object (default: last plot displayed)
#' @param width Width in inches (default 10)
#' @param dpi Resolution in dots per inch (default 600)
#' @param ... Additional arguments passed to ggsave
#' @export
#'
#' @examples
#' \dontrun{
#' library(survival)
#' p <- survkit(lung, "time", "status", "sex")
#' save_survkit("survival_curve.png", p)
#' }
save_survkit <- function(filename, plot = ggplot2::last_plot(),
                         width = 10, dpi = 600, ...) {
  dims <- golden_ratio(width = width)

  ggplot2::ggsave(
    filename = filename,
    plot = plot,
    width = dims$width,
    height = dims$height,
    dpi = dpi,
    ...
  )
}
