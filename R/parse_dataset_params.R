#' @importFrom glue glue
parse_dataset_params <- function(cohort = COHORTS, wave = WAVES) {

  cohort <- as.character(cohort)
  wave   <- as.character(wave)

  tryCatch(
    match.arg(cohort),
    error = function(e) stop(glue(WRONG_COHORT_PARAM))
  )

  waves_valid <- WAVES_PER_COHORT[[cohort]]

  tryCatch(
    match.arg(as.character(wave), waves_valid),
    error = function(e) stop(glue(WRONG_WAVE_PARAM))
  )

  invisible(NULL)
}
