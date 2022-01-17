#' @export
#'
#' @importFrom assertive.types assert_is_data.frame
#' @importFrom assertive.sets  assert_is_subset
#' @importFrom pander          pandoc.table
write_vars_table <- function(variables, style = "grid") {

  ## Constants: ----
  VAR_PROPS        <- c("var", "label", "type", "code")
  HEADERS          <- c("Main variable name", "Label", "Format", "Code")
  names(VAR_PROPS) <- HEADERS

  PANDOC_TABLE_STYLES <- c("multiline", "grid", "simple", "rmarkdown", "jira")

  ## Argument checking and formatting: ----
  assertive.types::assert_is_data.frame(variables)
  assertive.sets::assert_is_subset(VAR_PROPS, colnames(variables))
  assertive.types::assert_is_a_string(style)

  style <- match.arg(style, PANDOC_TABLE_STYLES)

  ## Main: ----
  variables$code <- sapply(
    variables$code,
    format_var_code,
    linefeeds = style == "grid"
  )

  pander::pandoc.table(
    variables,
    style            = style,
    justify          = "llll",
    split.tables     = Inf,
    keep.line.breaks = TRUE
  )
}

format_var_code <- function(code, linefeeds = TRUE) {

  collapser <- if (linefeeds) ";\n" else "; "

  paste('-', code, names(code), collapse = collapser)
}
