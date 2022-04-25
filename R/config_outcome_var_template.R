#' @export
#'
#' @importFrom glue glue
config_outcome_var_template <- function() {

  # Activate necessary packages:
  library(Statamarkdown)

  # Configure Stata path if necessary:
  engine_paths <- list()

  if (exists("STATA_PATH")) engine_paths <- c(engine_paths, stata = STATA_PATH)

  # Output configuration options:
  options(width = 88L) # R text output width

  knitr::opts_chunk$set(
    engine.path = engine_paths,
    echo        = FALSE, # Do not show syntax by default
    results     = 'hide',# Omit results of running syntax
    cleanlog    = TRUE,  # Omit repeating syntax in Stata output
    collectcode = TRUE,  # Reuse Stata code in previous 'chunks'
    comment     = ''     # No prefix in results
  )

  ecs.data:::parse_dataset_params(params$cohort, params$wave)

  invisible(NULL)
}
