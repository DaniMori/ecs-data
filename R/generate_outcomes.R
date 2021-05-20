OVERWRITE_OPTIONS <- c("none", "old", "all")


#' @importFrom assertive.properties is_empty
#' @importFrom htmltools            tags
#' @importFrom miniUI               miniPage gadgetTitleBar miniContentPanel
#' @importFrom shiny                observeEvent stopApp dialogViewer
#'                                  radioButtons renderPrint runGadget
#'                                  verbatimTextOutput
generate_outcomes <- function() {

  INPUT_PATH_ID  <- "input_path"
  FILE_FILTER_ID <- "file_filter"
  FILE_INFO_ID   <- "files_info"

  ui <- miniUI::miniPage(

    miniUI::gadgetTitleBar(GENERATE_OUTCOMES_CAPTION),

    miniUI::miniContentPanel(

      pathInput(INPUT_PATH_ID, label = PATH),

      shiny::radioButtons(
        inputId      = FILE_FILTER_ID,
        label        = OVERWRITE,
        width        = "100%",
        choiceNames  = OVERWRITE_LABELS,
        choiceValues = OVERWRITE_OPTIONS
      ),

      htmltools::tags$div(
        class = "form-group",
        style = "width:100%",
        htmltools::tags$label(DOCUMENTS_TO_CREATE),
        htmltools::tags$pre(
          id          = FILE_INFO_ID,
          class       = "shiny-text-output",
          style       = "white-space:pre-wrap"
        )
      )
    )
  )

  server <- function(input, output, session) {

    read_ecs_folder(folder = DOC_FOLDER_KEY, run_config = TRUE)

    # Listen for 'done' events. When we're finished, we'll stop the gadget.
    shiny::observeEvent(
      input$done,
      {
        if (nrow(docs()) != 0) {

          render_outcome_docs(
            docs()$input,
            recursive = selection()$recursive,
            overwrite = input[[FILE_FILTER_ID]]
          )
        }

        shiny::stopApp()
      }
    )

    shiny::observeEvent(input$cancel, shiny::stopApp())

    selection <- pathConnection(
      input,
      output,
      session,
      INPUT_PATH_ID,
      filters = create_file_filters(RMARKDOWN_FILES, RMD_EXT)
    )

    docs <- reactive(
      {
        selection <- selection()

        if (is.null(selection$paths)) return(data.frame())

        docs <- validate_docs(selection$paths, recursive = selection$recursive)

        if (is.null(docs)) return(data.frame())

        filter_docs(docs, overwrite = input[[FILE_FILTER_ID]])
      }
    )

    output[[FILE_INFO_ID]] <- shiny::renderPrint(
      cat(docs()$output, sep = paste0(ENDLINE, HORIZONTAL_RULE, ENDLINE))
    )
  }

  viewer <- shiny::dialogViewer(GENERATE_OUTCOMES_TITLE)

  shiny::runGadget(ui, server, viewer = viewer, stopOnCancel = FALSE)
}

#' @importFrom rstudioapi getActiveProject
#' @importFrom stringr    str_detect
paths_in_active_project <- function(path,
                                    base_dir = rstudioapi::getActiveProject()) {

  path     <- normalizePath(path,     winslash = DIR_SEP)
  base_dir <- normalizePath(base_dir, winslash = DIR_SEP)

  stringr::str_detect(path, pattern = paste0(INIT_REGEX_PREFFIX, base_dir))
}

#' @importFrom rstudioapi getActiveProject
#' @importFrom stringr    str_remove
#' @importFrom tools      file_path_sans_ext
get_output_docs <- function(input_docs,
                            doc_folder = read_ecs_folder(DOC_FOLDER_KEY)) {

  input_dirs <- stringr::str_remove(
    dirname(input_docs),
    pattern = paste0(
      INIT_REGEX_PREFFIX,
      rstudioapi::getActiveProject(),
      DIR_SEP
    )
  )
  output_dirs  <- file.path(doc_folder, DIR_OUTPUT[input_dirs])

  input_names  <- tools::file_path_sans_ext(basename(input_docs))
  output_names <- paste(input_names, WORD_EXT, sep = FILE_EXT_SEP)

  file.path(output_dirs, output_names)
}


dirs_to_files <- function(input, recursive = TRUE) {

  dirs <- input[dir.exists(input)]

  files <- input[!dir.exists(input)]

  unique(c(files, list.files(dirs, full.names = TRUE, recursive = recursive)))
}


filter_docs <- function(docs, overwrite = OVERWRITE_OPTIONS) {

  overwrite  <- match.arg(overwrite)

  filter <- switch (
    overwrite,
    none = !file.exists(docs$output),
    all  = rep(TRUE, nrow(docs)),
    old  = {

      time_input  <- file.mtime(docs$input)
      time_output <- file.mtime(docs$output)

      time_output < time_input | is.na(time_output)
    }
  )

  docs[filter, ]
}

#' @importFrom assertive.properties is_empty
#' @importFrom rstudioapi           getActiveProject
#' @importFrom tools                file_ext
validate_docs <- function(paths, recursive = TRUE) {

  valid_paths <- paths_in_active_project(
      paths,
      file.path(rstudioapi::getActiveProject(), BASE_OUTCOME_FOLDER)
    )

  if (!all(valid_paths)) {

    warning(PATHS_NOT_IN_PROJECT)

    paths <- paths[valid_paths]

    if (assertive.properties::is_empty(paths)) return(NULL)
  }

  input_docs <- dirs_to_files(paths, recursive = recursive)
  input_docs <- input_docs[tools::file_ext(input_docs) == RMD_EXT]

  output_docs <- get_output_docs(input_docs)

  data.frame(input = input_docs, output = output_docs)
}

#' @importFrom rmarkdown render
render_outcome_docs <- function(documents,
                                recursive = TRUE,
                                overwrite = OVERWRITE_OPTIONS) {

  documents <- validate_docs(documents, recursive = recursive)

  for (index in seq_len(nrow(documents))) {

    output_doc <- documents$output[index]

    not_gen <- is.null(filter_docs(documents[index, ], overwrite = overwrite))

    if (not_gen) {

      message(DOC_WILL_NOT_BE_OVERWRITTEN, ENDLINE, output_doc)
    }

    rmarkdown::render(
      input = documents$input[index],
      output_format = "word_document",
      output_dir    = dirname(output_doc)
    )
  }
}
