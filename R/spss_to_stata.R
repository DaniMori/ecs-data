#' Interfaz gráfico para transformar un archivo de datos de SPSS a formato Stata
#'
#' @return NULL
#'
#' @details Puede dar algún fallo no controlado
#'          (no se ha probado con muchos casos de uso)
#'
#' @importFrom miniUI    miniPage gadgetTitleBar miniContentPanel
#' @importFrom htmltools hr
#' @importFrom shiny     dialogViewer observeEvent reactiveValues renderText
#'                       runGadget    stopApp
#' @importFrom tools     file_path_sans_ext
#'
#' @examples ecs.data:::pss_to_stata()
spss_to_stata <- function() {

  INPUT_PATH_ID  <- "input_file"
  OUTPUT_PATH_ID <- "output_file"

  ui <- miniUI::miniPage(

    miniUI::gadgetTitleBar(TRANSFORM_SPPS_TO_STATA_CAPTION),

    miniUI::miniContentPanel(

      filePathInput(INPUT_PATH_ID, label = SPSS_FILE_TO_CONVERT),

      htmltools::hr(),

      filePathInput(OUTPUT_PATH_ID, label = STATA_FILE_TO_CREATE)
    )
  )

  server <- function(input, output, session) {

    values <- shiny::reactiveValues(file_out = NULL)

    # Listen for 'done' events. When we're finished, we'll stop the gadget.
    shiny::observeEvent(
      input$done,
      {
        file_in <- file_input()

        if (is.null(file_in)) {

          message(NO_INPUT_FILE_SELECTED)
          return(NULL)
        }
        if (is.null(values$file_out)) {

          message(NO_OUTPUT_FILE_SELECTED)
          return(NULL)
        }

        convert_spss_to_stata(file_in, values$file_out)
        shiny::stopApp()
      }
    )

    shiny::observeEvent(input$cancel, shiny::stopApp())

    file_input <- filePathConnection(
      input,
      output,
      session,
      INPUT_PATH_ID,
      file_caption = SELECT_SPSS_FILE,
      multiple     = FALSE,
      filters      = create_file_filters(SPSS_FILE, SPSS_EXT)
    )

    file_output <- filePathConnection(
      input,
      output,
      session,
      OUTPUT_PATH_ID,
      file_caption = SELECT_STATA_FILE,
      multiple     = FALSE,
      must_exist   = FALSE,
      filters      = create_file_filters(STATA_FILE, STATA_EXT)
    )

    shiny::observeEvent(
      input[[OUTPUT_PATH_ID]],
      values$file_out <- file_output()
    )

    shiny::observeEvent(
      input[[INPUT_PATH_ID]],
      {
        file_in <- file_input()

        if (is.null(file_in)) return(NULL)

        values$file_out <- paste(
          tools::file_path_sans_ext(file_in),
          STATA_EXT,
          sep = FILE_EXT_SEP
        )

        output[[text_id(OUTPUT_PATH_ID)]] <- shiny::renderText(values$file_out)
      }
    )
  }

  viewer <- shiny::dialogViewer(SPSS_TO_STATA_TITLE, height = 250)

  shiny::runGadget(ui, server, viewer = viewer, stopOnCancel = FALSE)
}
