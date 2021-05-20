#' Transforma un archivo de datos de SPSS a formato Stata
#'
#' @return `TRUE` (invisible) si el archivo se ha guardado correctamente
#'         en formato Stata.
#'         `FALSE` (invisible) si el usuario cancela la selección de alguno
#'         de los dos archivos
#'
#' @details Puede dar algún fallo no controlado
#'          (no se ha probado con muchos casos de uso)
#' @export
#'
#' @importFrom assertive.strings is_an_empty_string
#' @importFrom rstudioapi        selectFile
#' @importFrom tools             file_ext
#'
#' @examples spss_to_stata()
spss_to_stata <- function() {

  input_file <- rstudioapi::selectFile(
    caption = SELECT_SPSS_FILE,
    label   = SELECT_LABEL,
    path    = USER_HOME_DIR,
    filter  = create_glob(SPSS_FILES, SPSS_EXT)
  )

  if (is.null(input_file)) {

    warning(NO_INPUT_FILE_SELECTED)
    return(invisible(FALSE))
  }

  input_dir <- dirname(input_file)

  output_file <- rstudioapi::selectFile(
    caption  = SELECT_STATA_FILE,
    label    = SELECT_LABEL,
    path     = input_dir,
    filter   = create_glob(STATA_FILES, STATA_EXT),
    existing = FALSE
  )

  if (is.null(output_file)) {

    warning(NO_OUTPUT_FILE_SELECTED)
    return(invisible(FALSE))
  }

  if (assertive.strings::is_an_empty_string(tools::file_ext(output_file))) {

    output_file <- paste(output_file, STATA_EXT, sep = FILE_EXT_SEP)
  }

  convert_spss_to_stata(input_file, output_file)
}
