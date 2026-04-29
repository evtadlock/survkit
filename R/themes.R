#' survkit Theme
#'
#' Publication style ggplot2 theme for survkit plots.
#'
#' @param base_size Base font size
#'
#' @return ggplot2 theme
#' @export

theme_survkit <- function(base_size = 16) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        face = "bold",
        size = base_size + 4,
        hjust = 0.5
      ),
      plot.subtitle = ggplot2::element_text(
        size = base_size,
        hjust = 0.5
      ),
      axis.title = ggplot2::element_text(
        face = "bold"
      ),
      axis.text = ggplot2::element_text(
        color = "black"
      ),
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom",
      panel.grid.minor = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(10, 15, 10, 15)
    )
}

#' survkit Risk Table Theme
#'
#' Specialized theme for risk tables beneath survival curves.
#'
#' @param base_size Base font size
#'
#' @return ggplot2 theme
#' @keywords internal

theme_survkit_risk <- function(base_size = 16) {
  theme_survkit(base_size = base_size) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(
        hjust = 1,
        size = 10,
        face = "bold",
        margin = ggplot2::margin(r = 8)
      ),
      legend.position = "none",
      plot.title = ggplot2::element_text(
        size = 18,
        face = "bold",
        hjust = 0.5,
        margin = ggplot2::margin(b = 12)
      ),
      plot.margin = ggplot2::margin(8, 15, 12, 15)
    )
}
