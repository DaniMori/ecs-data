#' @export
get_dataset_line <- function() {

  cohort <- params$cohort
  wave   <- params$wave

  dataset <- paste(cohort, wave, sep = SUFFIX_SEP)

  switch(
    dataset,
    `2011_1`     = 2,
    `2011_2`     = 3,
    `2011_3`     = 4,
    `2019_1`     = 5,
    `2019_COVID` = 6
  )
}
