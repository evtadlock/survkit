#' Extract Survival Data from survfit Object
#'
#' Internal function to convert survfit object to tidy data frame.
#'
#' @param fit survfit object
#'
#' @return Data frame with time, surv, n.risk, n.event, n.censor, lower, upper, group
#' @keywords internal
extract_survival <- function(fit) {

  summ <- summary(fit)

  # Check if surv is a matrix (adjusted curves with multiple groups)
  if (is.matrix(summ$surv)) {
    # Adjusted curves: surv is a matrix with one column per group
    # Time points are the same for all groups
    n_groups <- ncol(summ$surv)
    n_times <- length(summ$time)

    # Get group names from newdata
    if (!is.null(summ$newdata)) {
      group_var <- names(summ$newdata)[1]
      group_labels <- as.character(summ$newdata[[group_var]])
    } else {
      group_labels <- colnames(summ$surv)
      if (is.null(group_labels)) {
        group_labels <- paste0("Group", seq_len(n_groups))
      }
    }

    # Create long-format data frame
    df_list <- lapply(seq_len(n_groups), function(i) {
      data.frame(
        time = summ$time,
        n.risk = summ$n.risk,
        n.event = summ$n.event,
        n.censor = if (!is.null(summ$n.censor)) summ$n.censor else rep(0, n_times),
        surv = summ$surv[, i],
        lower = if (is.matrix(summ$lower)) summ$lower[, i] else summ$lower,
        upper = if (is.matrix(summ$upper)) summ$upper[, i] else summ$upper,
        strata = group_labels[i],
        group = group_labels[i],
        stringsAsFactors = FALSE
      )
    })

    df <- do.call(rbind, df_list)

  } else if (!is.null(summ$strata) && length(unique(summ$strata)) > 1) {
    # KM curves with strata: surv is a vector, strata is a factor
    # Each time point belongs to one stratum
    n_obs <- length(summ$time)

    # Extract group labels from strata factor levels
    group_labels <- gsub(".*=", "", as.character(summ$strata))

    df <- data.frame(
      time = summ$time,
      n.risk = summ$n.risk,
      n.event = summ$n.event,
      n.censor = if (!is.null(summ$n.censor)) summ$n.censor else rep(0, n_obs),
      surv = summ$surv,
      lower = summ$lower,
      upper = summ$upper,
      strata = as.character(summ$strata),
      group = group_labels,
      stringsAsFactors = FALSE
    )

  } else {
    # Single group: no strata or only one stratum
    n_obs <- length(summ$time)

    df <- data.frame(
      time = summ$time,
      n.risk = summ$n.risk,
      n.event = summ$n.event,
      n.censor = if (!is.null(summ$n.censor)) summ$n.censor else rep(0, n_obs),
      surv = summ$surv,
      lower = summ$lower,
      upper = summ$upper,
      strata = "all",
      group = "all",
      stringsAsFactors = FALSE
    )
  }

  df
}
