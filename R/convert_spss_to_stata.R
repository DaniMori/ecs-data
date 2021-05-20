#' @importFrom haven read_sav write_dta
convert_spss_to_stata <- function(input_path, output_path) {

  message(TRANSFORMING_DATASET)

  haven::write_dta(haven::read_sav(input_file), path = output_file)

  message(DATASET_SAVED)

  invisible(TRUE)
}
