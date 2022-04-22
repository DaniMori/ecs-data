DOC_FOLDER_KEY <- "DOC"
DB_FOLDER_KEY  <- "DB"

PROJECT_FOLDER_KEYS <- c(DB_FOLDER_KEY, DOC_FOLDER_KEY)


#' Lee la carpeta de proyecto de "Edad con Salud" (i.e., carpeta
#' compartida de OneDrive) indicada y la devuelve como una ruta relativa al
#' "HOME" del usuario.
#'
#' @param folder ("DOC") cadena de caracteres indicando la
#'        _clave_, es decir, si se desea obtener la ruta a la carpeta de datos
#'        ("DB") o de documentación ("DOC", por defecto).
#' @param run_config (`FALSE`) valor lógico indicando si ejecutar la
#'        configuración de las carpetas, en caso de que el archivo de
#'        configuración esté vacío. En caso de no ejecutarse la configuración
#'        (por defecto) si el archivo de configuración está vacío termina con un
#'        error.
#' @param rel_stata (`FALSE`) valor lógico indicando si devolver la ruta
#'        relativa al "HOME" de usuario entendido según Stata. Windows suele
#'        considerar el "HOME" como una ruta del tipo
#'        `C:/Users/<username>/Documents`, mientras que Stata considera el
#'        "HOME" como `C:/Users/<username>`.
#'
#' @return ruta local a la carpeta del  proyecto, relativa al "HOME" del usuario
#' @details Devuelve la ruta a la carpeta de OneDrive de Edad con Salud
#'          seleccionada. La carpeta (_bases de datos_ o _documentación_)
#'          se selecciona mediante la clave correspondiente en el parámetro
#'          `folder`.
#'          Para instrucciones sobre cómo sincronizar las carpetas compartidas,
#'          ver el
#'          \href{https://bit.ly/33PJOJe}{Manual de sincronización de OneDrive}.
#'
#' @importFrom fs path_rel
#'
#' @export
read_ecs_folder <- function(folder     = PROJECT_FOLDER_KEYS,
                            run_config = FALSE,
                            rel_stata  = FALSE) {
  folder <- match.arg(folder)

  config_fields <- read_config_file()

  if (identical(config_fields, FALSE)) {

    if (run_config) {

      if (!config_ecs_folders()) stop(RUN_CONFIG_FOLDER_ERROR)

      config_fields <- read_config_file()

    } else {

      stop(CONFIG_FILE_NOT_SET)
    }
  }

  result <- config_fields[[folder]]

  home_dir <- if (rel_stata) USER_HOME_STATA else USER_HOME_DIR

  start_dir <- path.expand(home_dir)

  file.path(USER_HOME_DIR, fs::path_rel(result, start = start_dir))
}


#' @importFrom configr read.config
read_config_file <- function() {

  configr::read.config(
    file      = system.file(RESOURCE_DIR, CONFIG_FILE, package = PKG_NAME),
    file.type = CONFIG_TYPE
  )
}

#' @importFrom assertive.types assert_is_a_bool
get_user_base_dir <- function(normalize = FALSE) {

  ## Argument checking and formatting: ----
  assertive.types::assert_is_a_bool(normalize)

  ## Main: ----
  result <- file.path(USER_HOME_DIR, DIR_UP)

  if (normalize) normalizePath(result, winslash = DIR_SEP)
  else           result
}

#' @importFrom assertive.types assert_is_a_bool
get_org_OneDrive_base_dir <- function(normalize = FALSE) {

  ## Argument checking and formatting: ----
  assertive.types::assert_is_a_bool(normalize)

  ## Main: ----
  file.path(get_user_base_dir(normalize = normalize), DIR_ONEDRIVE_ORG)
}

#' @importFrom assertive.types assert_is_a_bool
get_OneDrive_dir_prefix <- function(normalize = FALSE) {

  ## Argument checking and formatting: ----
  assertive.types::assert_is_a_bool(normalize)

  ## Main: ----
  file.path(get_org_OneDrive_base_dir(normalize = normalize), ECS_DIRS_OWNER)
}
