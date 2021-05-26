#' Configura el entorno y comprueba la configuración del paquete `ecs.data`
#'
#' @param conf_folders (`TRUE`) valor lógico indicando si configurar las
#'                     carpetas de proyecto de Edad con Salud
#' @param check_R_version (`FALSE`) valor lógico indicando si comprobar la
#'                        versión de R en uso.
#' @param check_CRAN_deps (`FALSE`) valor lógico indicando si comprobar e
#'                        instalar los paquetes del "Cran"
#' @param check_Statamarkdown (`TRUE`) valor lógico indicando si comprobar
#'                            e instalar el paquete "Statamarkdown"
#' @param check_Stata (`TRUE`) valor lógico indicando si comprobar la
#'                    instalación de Stata
#'
#' @return `TRUE` (invisible) si el entorno se ha configurado correctamente;
#'         `FALSE` (invisible) si hay algún problema durante la configuración.
#' @details Hay cinco requisitos para que el paquete funcione correctamente;
#'   cada uno de ellos se comprobará si el argumento correspondiente es `TRUE`:
#'   - Se compureba que la versión de R es igual o superior a la 4.0.5; en caso
#'   contrario se emite un aviso, pero no se considera un problema de
#'   configuración.
#'   - Se comprueba si están instaladas las dependencias del 'CRAN';
#'   en caso de que falte alguna, se intenta instalar.
#'   Devuelve `FALSE` si falla la instalación de algún paquete.
#'   - Se comprueba si el paquete `Statamarkdown` está instalado;
#'   en caso contrario se intenta instalar. Devuelve `FALSE` si la instalación
#'   no se consigue completar.
#'   - Se comprueba que es posible encontrar una instalación de 'Stata'.
#'   En caso de que no, se emite un aviso explicando la configuración manual,
#'   y de devuelve `FALSE`.
#'   - Se intenta configurar las carpetas de proyecto de Edad con Salud
#'   (para hacerlo correctamente es necesario que las carpetas de OneDrive
#'   estén sincronizadas localmente). En caso de que al menos una de ellas no se
#'   pueda configurar, se devuelve `FALSE`.
#' @export
#'
#' @importFrom assertive.strings is_an_empty_string
#' @importFrom devtools          session_info install_github
#' @importFrom glue              glue
#' @importFrom rstudioapi        showDialog
#' @importFrom Statamarkdown     find_stata
#' @importFrom stringr           str_extract
#' @importFrom utils             flush.console install.packages
#'
#' @family configuration functions
#' @examples \dontrun{configure_ecs()}
configure_ecs <- function(check_R_version     = FALSE,
                          check_CRAN_deps     = FALSE,
                          check_Statamarkdown = TRUE,
                          check_Stata         = TRUE,
                          conf_folders        = TRUE,
                          confirmation        = FALSE) {

  if (confirmation) rstudioapi::showDialog(PKG_NAME, CONFIGURATION_MSG)

  result <- TRUE # Valor por defecto para el resultado de la configuración

  # Check R version:
  if (check_R_version) {

    r_version <- stringr::str_extract(
      devtools::session_info()$platform$version,
      pattern = "\\d+\\.\\d+\\.\\d+"
    )

    message(R_VERSION_CHECK)

    if (!is_updated_version(r_version)) {

      warning(glue::glue(R_VERSION_OLD))
    }

    utils::flush.console()
  }


  # Check and install missing dependencies:
  if (check_CRAN_deps) {

    message(CHECK_DEPENDENCIES)

    for (package in CRAN_DEPENDENCIES) {

      if (!require(package, character.only = TRUE, quietly = TRUE)) {

        result <- tryCatch(
          {
            utils::install.packages(package, repos = REMOTE_REPO)
            TRUE
          },
          error = function(e) {

            message(geterrmessage())
            FALSE
          }
        ) &&
          result # Keeps the `FALSE` value if it has been already set to `FALSE`
      }
    }

    utils::flush.console()
  }


  # Check and install 'Statamarkdown'
  if (check_Statamarkdown) {

    suppressMessages(
      statamarkdown_found <- require(Statamarkdown, quietly = TRUE)
    )

    if (!statamarkdown_found) {

      message(STATAMARKDOWN_INSTALL)

      devtools::install_github(STATAMARKDOWN_URL)

      suppressMessages(
        statamarkdown_found <- require(Statamarkdown, quietly = TRUE)
      )

      if (!statamarkdown_found) {

        warning(STATAMARKDOWN_INSTALL_ERROR)
        result <- FALSE
      }

      utils::flush.console()
    }
  }

  # Check Stata installation:
  if (check_Stata) {

    stata_path <- Statamarkdown::find_stata(message = FALSE)

    if (assertive.strings::is_an_empty_string(stata_path)) {

      warning(STATA_NOT_FOUND)
      result <- FALSE

    } else {

      message(glue::glue(STATA_FOUND))
    }

    utils::flush.console()
  }

  # Configure project folders:
  if (conf_folders) {

    if (confirmation) rstudioapi::showDialog(PKG_NAME, CONFIGURATION_DIRS)

    result <- config_ecs_folders() && result

    utils::flush.console()
  }

  # Inform of result
  confirmation_message <- if (result) CONFIGURATION_OK else CONFIGURATION_WARN

  if (confirmation) rstudioapi::showDialog(PKG_NAME, confirmation_message)
  else message(confirmation_message)

  utils::flush.console()

  invisible(TRUE)
}


#' @importFrom stringr           str_extract str_remove
#' @importFrom assertive.strings is_an_empty_string
is_updated_version <- function(current, suggested = R_VERSION) {

  DIGIT_PATTERN  <- "^\\d+"
  REMOVE_PATTERN <- paste0(DIGIT_PATTERN, "[\\.-]?")

  stop_loop <- FALSE

  while(!stop_loop) {

    current_use   <- as.integer(
      stringr::str_extract(current,   pattern = DIGIT_PATTERN)
    )
    suggested_use <- as.integer(
      stringr::str_extract(suggested, pattern = DIGIT_PATTERN)
    )

    if (current_use < suggested_use) return(FALSE)
    if (current_use > suggested_use) return(TRUE)

    current   <- stringr::str_remove(current, pattern = REMOVE_PATTERN)
    suggested <- stringr::str_remove(suggested, pattern = REMOVE_PATTERN)

    current_empty   <- assertive.strings::is_an_empty_string(current)
    suggested_empty <- assertive.strings::is_an_empty_string(suggested)

    stop_loop <- any(current_empty, suggested_empty)

    if (current_empty & !suggested_empty) return(FALSE)
  }

  TRUE
}
