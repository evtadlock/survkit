#' survkit Viridis Color Scale
#'
#' Default color scale using viridis palette (colorblind-safe, print-friendly).
#'
#' @param option Viridis palette option: "viridis" (default), "magma", "inferno",
#'   "plasma", "cividis", "rocket", "mako", "turbo"
#' @param ... Additional arguments passed to scale_color_viridis_d
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() +
#'   scale_color_survkit()
scale_color_survkit <- function(option = "viridis", ...) {
  ggplot2::scale_color_viridis_d(option = option, end = 0.9, ...)
}

#' @rdname scale_color_survkit
#' @export
scale_fill_survkit <- function(option = "viridis", ...) {
  ggplot2::scale_fill_viridis_d(option = option, end = 0.9, ...)
}
