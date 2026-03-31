#' Plot Survival Curve
#'
#' Internal function to generate the main survival curve plot.
#'
#' @param surv_data Survival data frame from extract_survival()
#' @param viridis_option Viridis palette option
#' @param conf_int Show confidence intervals
#' @param conf_int_alpha Transparency for CI ribbons
#' @param censor_marks Show censor marks
#' @param censor_shape Shape for censor marks
#' @param censor_size Size for censor marks
#' @param censor_stroke Stroke width for censor marks
#' @param line_width Width of survival curves
#' @param adjusted Is this an adjusted curve?
#' @param time_breaks Time axis breaks
#' @param title Plot title
#' @param subtitle Plot subtitle
#'
#' @return ggplot object
#' @keywords internal
plot_curve <- function(surv_data, viridis_option, conf_int, conf_int_alpha,
                       censor_marks, censor_shape, censor_size, censor_stroke,
                       line_width, adjusted, time_breaks, title, subtitle) {

  p <- ggplot2::ggplot(surv_data, ggplot2::aes(x = .data$time, y = .data$surv,
                                               color = .data$group, fill = .data$group)) +
    ggplot2::geom_step(linewidth = line_width) +
    theme_survkit() +
    scale_color_survkit(option = viridis_option) +
    scale_fill_survkit(option = viridis_option) +
    ggplot2::labs(
      y = "Survival probability",
      x = "Time",
      title = title,
      subtitle = subtitle
    ) +
    ggplot2::scale_y_continuous(
      limits = c(0, 1),
      expand = c(0, 0),
      breaks = seq(0, 1, 0.2)
    ) +
    ggplot2::scale_x_continuous(
      breaks = time_breaks,
      expand = c(0.01, 0)
    )

  # Add confidence intervals
  if (conf_int) {
    p <- p + ggplot2::geom_ribbon(
      ggplot2::aes(ymin = .data$lower, ymax = .data$upper),
      alpha = conf_int_alpha,
      color = NA
    )
  }

  # Add censor marks (KM mode only)
  if (censor_marks && !adjusted) {
    censor_data <- surv_data[surv_data$n.censor > 0, ]
    if (nrow(censor_data) > 0) {
      p <- p + ggplot2::geom_point(
        data = censor_data,
        ggplot2::aes(x = .data$time, y = .data$surv),
        shape = censor_shape,
        size = censor_size,
        stroke = censor_stroke
      )
    }
  }

  p
}
