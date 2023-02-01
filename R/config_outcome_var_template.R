#' @export
#'
#' @importFrom knitr opts_chunk
config_outcome_var_template <- function() {

  # Activate necessary packages:
  library(Statamarkdown)

  # Configure Stata path (if necessary):

  engine_paths <- knitr::opts_chunk$get("engine.path")

  if (is.null(engine_paths) || is.null(engine_paths$stata)) {

    engine_paths <- list()

    if (exists("STATA_PATH")) {

      engine_paths <- c(engine_paths, stata = STATA_PATH)

    } else {

      stop(STATA_PATH_NOT_FOUND)
    }
  }


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

  parse_dataset_params(params$cohort, params$wave, params$variable)

  invisible(NULL)
}
