#' @export
#'
#' @importFrom assertive.types assert_is_data.frame
#' @importFrom assertive.sets  assert_is_subset
#' @importFrom pander          pandoc.table
write_vars_table <- function(variables) {

  ## Constants: ----
  VAR_PROPS <- c("var", "label", "type", "code")
  HEADERS   <- c("Main variable name", "Label", "Format", "Code")
  names(VAR_PROPS) <- HEADERS

  ## Argument checking and formatting: ----
  assertive.types::assert_is_data.frame(variables)
  assertive.sets::assert_is_subset(VAR_PROPS, colnames(variables))

  ## Main: ----
  variables$code <- sapply(variables$code, format_var_code)

  pander::pandoc.table(
    variables,
    style   = "grid",
    justify = "llll",
    keep.line.breaks = TRUE
  )
}

format_var_code <- function(code) {

  paste('-', code, names(code), collapse = ";\n")
}
