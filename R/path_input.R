PATH_TYPE_SUFFIX <- "type"
LABEL_SUFFIX     <- "suffix"
TEXT_SUFFIX      <- "text"
CHECKBOX_SUFFIX  <- "checkbox"

CHOICE_DOC    <- "doc"
CHOICE_FOLDER <- "folder"

PATH_TYPE_OPTIONS <- c(CHOICE_DOC, CHOICE_FOLDER)

#' @importFrom htmltools css tags validateCssUnit
#' @importFrom shiny     actionButton checkboxInput radioButtons
pathInput <- function(input_id,
                      label,
                      radio_title   = USE,
                      choice_labels = c(DOC_S, FOLDER),
                      width         = "100%",
                      buttonLabel   = BROWSE_BUTTON_TEXT,
                      placeholder   = DOC_PATH_PLACEHOLDER,
                      subdir_label  = INCLUDE_SUBFOLDERS) {

  htmltools::tags$div(
    class = "form-group shiny-input-container",
    style = htmltools::css(width = htmltools::validateCssUnit(width)),

    shiny::radioButtons(
      inputId      = path_type_id(input_id),
      label        = USE,
      inline       = TRUE,
      choiceNames  = choice_labels,
      choiceValues = PATH_TYPE_OPTIONS
    ),

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
    ),

    shiny::checkboxInput(checkbox_id(input_id), subdir_label, value = FALSE)
  )
}

#' @importFrom assertive.properties is_empty
#' @importFrom rstudioapi           getActiveProject selectDirectory
#' @importFrom shiny                isolate radioButtons reactive reactiveValues
#'                                  renderText
#' @importFrom utils                choose.files Filters
pathConnection <- function(input,
                           output,
                           session,
                           input_id,
                           multiple       = TRUE,
                           file_caption   = SELECT_DOCUMENT_S,
                           folder_caption = SELECT_FOLDER,
                           button_label   = SELECT_LABEL,
                           filters        = utils::Filters) {
  observe(
    {
      updateCheckboxInput(
        session,
        checkbox_id(input_id),
        value = select_type() == CHOICE_FOLDER || incl_subfolder()
      )
    }
  )

  values <- shiny::reactiveValues(paths = rstudioapi::getActiveProject())

  select_type    <- shiny::reactive(input[[path_type_id(input_id)]])
  incl_subfolder <- shiny::reactive(input[[checkbox_id(input_id)]])

  select_path <- shiny::reactive(
    {
      if (input[[input_id]] != 0) {

        current_paths <- isolate(values$paths)
        path_ini <- current_paths[1]
        path_ini <- if (dir.exists(path_ini)) path_ini else dirname(path_ini)

        if (shiny::isolate(select_type()) == CHOICE_FOLDER) {

          paths <- rstudioapi::selectDirectory(
            caption = folder_caption,
            label   = button_label,
            path    = path_ini
          )
          if (is.null(paths)) return(current_paths)

        } else {

          paths <- utils::choose.files(
            default = file.path(path_ini, "*.*"),
            caption = file_caption,
            multi   = multiple,
            filters = filters
          )
          if (assertive.properties::is_empty(paths)) return(current_paths)
        }

        paths <- normalizePath(paths, winslash = DIR_SEP)

        values$paths <- paths

        paths
      }
    }
  )

  output[[text_id(input_id)]] <- shiny::renderText(
    paste0(select_path(), collapse = PATHS_COLLAPSE)
  )

  shiny::reactive(
    list(paths = select_path(), recursive = input[[checkbox_id(input_id)]])
  )
}
