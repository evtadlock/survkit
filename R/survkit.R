#' survkit: Survival Curves with Risk Tables
#'
#' Generate publication-ready survival curves with integrated risk tables.
#' Uses viridis colors, golden ratio dimensions, and 600 DPI optimization.
#'
#' @param data Data frame containing survival data
#' @param time Column name for time-to-event variable (string)
#' @param status Column name for event indicator (1 = event, 0 = censored)
#' @param group Column name for grouping variable
#' @param adjust_for Optional character vector of covariate names for Cox adjustment
#' @param reference Optional named list of reference values for covariates (default: mean/mode)
#' @param viridis_option Viridis palette: "viridis" (default), "magma", "inferno", "plasma", "cividis"
#' @param conf_int Show confidence intervals (default TRUE)
#' @param conf_int_alpha Transparency for confidence interval ribbons (default 0.2)
#' @param censor_marks Show censoring marks (default TRUE, KM mode only)
#' @param censor_shape Shape for censor marks (default 3 = plus sign, see ?pch for options)
#' @param censor_size Size for censor marks (default 3)
#' @param censor_stroke Stroke width for censor marks (default 1.5)
#' @param line_width Width of survival curves (default 1.2)
#' @param risk_table Include risk table (default TRUE)
#' @param risk_table_height Proportion of plot height for risk table (default 0.25)
#' @param risk_table_text_size Text size in risk table (default 4)
#' @param time_breaks Numeric vector of time points for axis and risk table (auto-generated if NULL)
#' @param title Optional plot title
#' @param subtitle Optional plot subtitle
#'
#' @return A patchwork object combining survival curve and risk table
#' @export
#'
#' @examples
#' \dontrun{
#' library(survival)
#'
#' # Basic KM curve with defaults
#' survkit(lung, "time", "status", "sex")
#'
#' # Adjusted for covariates
#' survkit(lung, "time", "status", "sex",
#'         adjust_for = c("age", "ph.ecog"))
#'
#' # Custom styling
#' survkit(lung, "time", "status", "sex",
#'         line_width = 2,
#'         censor_size = 4,
#'         conf_int_alpha = 0.3,
#'         viridis_option = "plasma")
#'
#' # Minimal style - thin lines, no CI
#' survkit(lung, "time", "status", "sex",
#'         line_width = 0.8,
#'         conf_int = FALSE)
#' }
survkit <- function(data, time, status, group,
                    adjust_for = NULL,
                    reference = NULL,
                    viridis_option = "viridis",
                    conf_int = TRUE,
                    conf_int_alpha = 0.2,
                    censor_marks = TRUE,
                    censor_shape = 3,
                    censor_size = 3,
                    censor_stroke = 1.5,
                    line_width = 1.2,
                    risk_table = TRUE,
                    risk_table_height = 0.25,
                    risk_table_text_size = 4,
                    time_breaks = NULL,
                    title = NULL,
                    subtitle = NULL) {

  # Fit survival model
  adjusted <- !is.null(adjust_for)
  fit <- fit_survival(data, time, status, group, adjust_for, reference)

  # Extract survival data
  surv_data <- extract_survival(fit)

  # Auto-generate time breaks if not provided
  if (is.null(time_breaks)) {
    time_breaks <- pretty(c(0, max(surv_data$time)), n = 5)
  }

  # Build curve plot
  p_curve <- plot_curve(
    surv_data = surv_data,
    viridis_option = viridis_option,
    conf_int = conf_int,
    conf_int_alpha = conf_int_alpha,
    censor_marks = censor_marks,
    censor_shape = censor_shape,
    censor_size = censor_size,
    censor_stroke = censor_stroke,
    line_width = line_width,
    adjusted = adjusted,
    time_breaks = time_breaks,
    title = title,
    subtitle = subtitle
  )

  # Build and combine risk table if requested
  if (risk_table) {
    p_risk <- plot_risk_table(
      surv_data = surv_data,
      time_breaks = time_breaks,
      viridis_option = viridis_option,
      text_size = risk_table_text_size
    )

    # Combine with patchwork
    combined <- p_curve / p_risk +
      patchwork::plot_layout(heights = c(1 - risk_table_height, risk_table_height))

    return(combined)
  } else {
    return(p_curve)
  }
}
