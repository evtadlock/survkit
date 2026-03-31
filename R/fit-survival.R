#' Fit Survival Model
#'
#' Internal function to fit either Kaplan-Meier or Cox-adjusted survival model.
#'
#' @param data Data frame
#' @param time Time variable name
#' @param status Status variable name
#' @param group Grouping variable name
#' @param adjust_for Optional covariate names for Cox adjustment
#' @param reference Reference values for covariates
#'
#' @return survfit object
#' @keywords internal
fit_survival <- function(data, time, status, group, adjust_for = NULL, reference = NULL) {

  if (is.null(adjust_for)) {
    # Kaplan-Meier mode
    formula_str <- paste0("survival::Surv(", time, ", ", status, ") ~ ", group)
    formula <- as.formula(formula_str)
    survival::survfit(formula, data = data)

  } else {
    # Cox-adjusted mode

    # Remove rows with missing values in any required variables
    required_vars <- c(time, status, group, adjust_for)
    complete_data <- data[complete.cases(data[required_vars]), ]

    if (nrow(complete_data) == 0) {
      stop("No complete cases available after removing missing values in covariates")
    }

    # Build formula string
    formula_str <- paste0(
      "survival::Surv(", time, ", ", status, ") ~ ",
      group, " + ",
      paste(adjust_for, collapse = " + ")
    )
    formula <- as.formula(formula_str)

    # Fit Cox model with complete data
    cox_model <- survival::coxph(formula, data = complete_data)

    # Build reference frame for adjusted predictions
    if (is.null(reference)) {
      reference <- lapply(complete_data[adjust_for], function(x) {
        if (is.numeric(x)) {
          mean(x, na.rm = TRUE)
        } else {
          names(sort(table(x), decreasing = TRUE))[1]
        }
      })
    }

    # Create newdata frame with all group levels at reference covariate values
    new_data <- data.frame(
      group_col = unique(complete_data[[group]]),
      stringsAsFactors = FALSE
    )
    names(new_data)[1] <- group

    # Add reference values for each covariate
    for (i in seq_along(adjust_for)) {
      new_data[[adjust_for[i]]] <- reference[[i]]
    }

    # Generate adjusted survival curves
    survival::survfit(cox_model, newdata = new_data)
  }
}
