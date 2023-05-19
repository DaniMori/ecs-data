CHOICE_DOC    <- "doc"
CHOICE_FOLDER <- "folder"

#' @importFrom htmltools css tags validateCssUnit
#' @importFrom shiny     actionButton checkboxInput radioButtons
filePathInput <- function(input_id,
                          label,
                          width       = "100%",
                          buttonLabel = BROWSE_BUTTON_TEXT,
                          placeholder = FILE_PATH_PLACEHOLDER) {

  htmltools::tags$div(
    class = "form-group shiny-input-container",
    style = htmltools::css(width = htmltools::validateCssUnit(width)),

    htmltools::tags$label(label, id = label_id(input_id)),

    htmltools::tags$div(
      class = "input-group",

      htmltools::tags$label(
        class = "input-group-btn input-group-prepend",
        shiny::actionButton(input_id, label = buttonLabel)
      ),

      htmltools::tags$pre(
        id          = text_id(input_id),
        class       = "shiny-text-output form-control",
        readonly    = "readonly",
        style       = "white-space:pre-wrap",
        placeholder = placeholder
      )
    )
  )
}

#' @importFrom assertive.properties is_empty
#' @importFrom rstudioapi           getActiveProject selectDirectory
#' @importFrom shiny                isolate radioButtons reactive reactiveValues
#'                                  renderText
filePathConnection <- function(input,
                               output,
                               session,
                               input_id,
                               file_caption = SELECT_DOCUMENT_S,
                               button_label = SELECT_LABEL,
                               multiple     = TRUE,
                               must_exist   = TRUE,
                               filters      = utils::Filters) {

  values <- shiny::reactiveValues(
    path = file.path(rstudioapi::getActiveProject(), EMPTY_FILE_NAME)
  )

  select_path <- shiny::reactive(
    {
      if (input[[input_id]] != 0) {

        path <- utils::choose.files(
          default = isolate(values$path),
          caption = file_caption,
          multi   = multiple,
          filters = filters
        )
        if (assertive.properties::is_empty(path)) return(NULL)

        path <- normalizePath(path, winslash = DIR_SEP, mustWork = must_exist)

        values$path <- path

        path
      }
    }
  )

  output[[text_id(input_id)]] <- shiny::renderText(select_path())

  shiny::reactive(select_path())
}
