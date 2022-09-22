#' @export
#'
#' @importFrom glue glue
description_title <- function() {

  cohort    <- params$cohort
  wave      <- params$wave
  variable  <- params$variable
  qualifier <- params$qualifier

  wave <- if (wave == "COVID") glue("{wave} substudy")
          else                 glue("wave {wave}")

  result <- glue::glue(DESCRIPTION_TITLE)

  if (is.null(qualifier)) return(result)

  qualifier <- glue::glue("({qualifier})")

  return(paste(result, qualifier))
}
