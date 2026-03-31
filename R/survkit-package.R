#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom stats as.formula
#' @importFrom rlang .data
## usethis namespace: end
NULL

# Suppress R CMD check notes for ggplot2 NSE (non-standard evaluation)
utils::globalVariables(c("time", "surv", "group", "lower", "upper", "n.risk", "n.censor"))
