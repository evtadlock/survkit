#' Plot Risk Table
#'
#' Internal function to generate the risk table beneath the survival curve.
#'
#' @param surv_data Survival data frame from extract_survival()
#' @param time_breaks Time axis breaks that match the curve x axis
#' @param viridis_option Viridis palette option
#' @param text_size Text size for numbers in risk table
#'
#' @return ggplot object
#' @keywords internal

plot_risk_table <- function(surv_data,
                            time_breaks,
                            viridis_option,
                            text_size = 4) {

  ###=============================================================
  ### Preserve the group order from the survival data
  ### This keeps the risk table rows aligned with the curve legend
  ###=============================================================

  group_levels <- unique(as.character(surv_data$group))

  ###=============================================================
  ### Extract number at risk for each group at each time break
  ### Each group gets its own y axis row to avoid overlapping labels
  ###=============================================================

  risk_data <- lapply(group_levels, function(grp) {

    group_data <- surv_data[surv_data$group == grp, ]

    data.frame(
      time = time_breaks,
      n.risk = sapply(time_breaks, function(t) {

        idx <- which(group_data$time <= t)

        if (length(idx) > 0) {
          group_data$n.risk[max(idx)]
        } else {
          NA
        }
      }),
      group = grp,
      stringsAsFactors = FALSE
    )
  })

  risk_df <- do.call(rbind, risk_data)

  ###=============================================================
  ### Force group to be a factor so ggplot uses separate rows
  ### The rev call places the first legend group at the top row
  ###=============================================================

  risk_df$group <- factor(
    risk_df$group,
    levels = rev(group_levels)
  )

  ###=============================================================
  ### Build risk table plot
  ### The y axis is the group, so multi group curves do not overlap
  ###=============================================================

  ggplot2::ggplot(
    risk_df,
    ggplot2::aes(
      x = .data$time,
      y = .data$group,
      label = .data$n.risk,
      color = .data$group
    )
  ) +
    ggplot2::geom_text(
      size = text_size,
      fontface = "bold",
      na.rm = TRUE
    ) +
    scale_color_survkit(option = viridis_option) +
    ggplot2::scale_x_continuous(
      breaks = time_breaks,
      expand = ggplot2::expansion(mult = c(0.02, 0.02))
    ) +
    ggplot2::scale_y_discrete(
      drop = FALSE
    ) +
    ggplot2::labs(
      title = "Number at risk",
      x = NULL,
      y = NULL
    ) +
    theme_survkit_risk()
}
