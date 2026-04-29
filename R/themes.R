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
