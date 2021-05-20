#' Configura las carpetas de proyecto de "Edad con Salud" (i.e., las carpetas
#' compartidas de OneDrive)
#'
#' @return `TRUE` (invisible) si las carpetas se han configurado correctamente;
#'         `FALSE` (invisible) si hay algún problema durante la configuración
#'                 de las carpetas.
#' @details Muestra dos ventanas de selección de ruta, una para cada carpeta
#'          ("Bases de Datos" y "Documentación", respectivamente).
#'          Por defecto intentará inicializar las ventanas en las rutas
#'          más habituales de "Edad con Salud", lo cual no debería dar problemas
#'          si las carpetas compartidas de OneDrive se han sincronizado en las
#'          rutas por defecto.
#'          Para instrucciones sobre cómo sincronizar las carpetas compartidas,
#'          ver el
#'          \href{https://bit.ly/33PJOJe}{Manual de sincronización de OneDrive}.
#'
#' @export
#'
#' @importFrom configr    write.config
#' @importFrom glue       glue
#' @importFrom rstudioapi selectDirectory
#'
#' @family configuration functions
#' @examples \dontrun{config_ecs_folders()}
config_ecs_folders <- function() {

  message(CONFIGURING_FOLDERS)

  db_dir <- rstudioapi::selectDirectory(
    caption = SELECT_DB_FOLDER,
    label   = SELECT_LABEL,
    path    = initialize_directory(
      DEFAULT_DB_PATH,
      fallback_dir = DEFAULT_ECS_MAIN_PATH
    )
  )

  if (is.null(db_dir)) {

    warning(NO_DB_FOLDER_SELECTED)
    invisible(FALSE)
  }
  message(glue::glue(DB_FOLDER_SELECTED))

  doc_dir <- rstudioapi::selectDirectory(
    caption = SELECT_DOC_FOLDER,
    label   = SELECT_LABEL,
    path    = initialize_directory(
      DEFAULT_DOC_PATH,
      fallback_dir = DEFAULT_ECS_MAIN_PATH
    )
  )

  if (is.null(doc_dir)) {

    warning(NO_DOC_FOLDER_SELECTED)
    invisible(FALSE)
  }
  message(glue::glue(DOC_FOLDER_SELECTED))

  dirs_list <- list(DB = db_dir, DOC = doc_dir)

  result <- configr::write.config(
    dirs_list,
    file.path = system.file(RESOURCE_DIR, CONFIG_FILE, package = PKG_NAME),
    write.type = CONFIG_TYPE
  )

  if (!result) {

    warning(CONFIG_FOLDER_ERROR)
    invisible(FALSE)
  }

  invisible(TRUE)
}

initialize_directory <- function(dir, fallback_dir = NULL) {

  if (dir.exists(dir)) {

    dir

  } else {

    if (!is.null(fallback_dir) & dir.exists(fallback_dir)) {

      fallback_dir

    } else {

      USER_HOME_DIR
    }
  }
}
