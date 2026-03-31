#' survkit Theme
#'
#' Clean theme optimized for posters and publications at 600 DPI.
#' Uses golden ratio dimensions and centered titles.
#'
#' @param base_size Base font size (default 16, suitable for posters)
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   theme_survkit()
theme_survkit <- function(base_size = 16) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 22, face = "bold", hjust = 0.5),
      plot.subtitle = ggplot2::element_text(size = 14, hjust = 0.5),
      axis.title = ggplot2::element_text(size = 14),
      axis.text = ggplot2::element_text(size = 12),
      legend.position = "bottom",
      legend.title = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )
}

#' survkit Risk Table Theme
#'
#' Specialized theme for risk tables that matches the main plot styling
#' but removes unnecessary elements.
#'
#' @param base_size Base font size
#' @keywords internal
theme_survkit_risk <- function(base_size = 16) {
  theme_survkit(base_size = base_size) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(hjust = 1, size = 12, face = "bold"),
      legend.position = "none",
      plot.margin = ggplot2::margin(0, 10, 5, 10)
    )
}
