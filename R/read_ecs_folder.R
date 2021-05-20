DOC_FOLDER_KEY <- "DOC"
DB_FOLDER_KEY  <- "DB"

PROJECT_FOLDER_KEYS <- c(DB_FOLDER_KEY, DOC_FOLDER_KEY)

read_ecs_folder <- function(folder = PROJECT_FOLDER_KEYS, run_config = FALSE) {

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

  config_fields[[folder]]
}


#' @importFrom configr read.config
read_config_file <- function() {

  configr::read.config(
    file      = system.file(RESOURCE_DIR, CONFIG_FILE, package = PKG_NAME),
    file.type = CONFIG_TYPE
  )
}
