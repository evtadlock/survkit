#' Plot Risk Table
#'
#' Internal function to generate the risk table beneath the survival curve.
#'
#' @param surv_data Survival data frame from extract_survival()
#' @param time_breaks Time axis breaks (must match curve x-axis)
#' @param viridis_option Viridis palette option
#' @param text_size Text size for numbers in risk table
#'
#' @return ggplot object
#' @keywords internal
plot_risk_table <- function(surv_data, time_breaks, viridis_option, text_size = 4) {

  # Extract n.risk at each time break for each group
  risk_data <- lapply(unique(surv_data$group), function(grp) {
    subset <- surv_data[surv_data$group == grp, ]
    data.frame(
      time = time_breaks,
      n.risk = sapply(time_breaks, function(t) {
        idx <- which(subset$time <= t)
        if (length(idx) > 0) {
          subset$n.risk[max(idx)]
        } else {
          NA
        }
      }),
      group = grp,
      stringsAsFactors = FALSE
    )
  })
  risk_df <- do.call(rbind, risk_data)

  ggplot2::ggplot(risk_df, ggplot2::aes(x = .data$time, y = .data$group,
                                        label = .data$n.risk, color = .data$group)) +
    ggplot2::geom_text(size = text_size, fontface = "bold") +
    theme_survkit_risk() +
    scale_color_survkit(option = viridis_option) +
    ggplot2::scale_x_continuous(
      breaks = time_breaks,
      expand = c(0.01, 0)
    ) +
    ggplot2::labs(title = "Number at risk")
}
