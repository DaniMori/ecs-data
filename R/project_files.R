#' Devuelve la ruta de acceso a un archivo de proyecto, ya sea en el propio
#' proyecto, o en el paquete `ecs.data`
#'
#' @param file      Archivo al que se quiere acceder
#' @param where     (`"project"`) Uno de "project", o "package"
#' @param proj_path (`rstudioapi::getActiveProject()`)
#'                  Directorio raíz del proyecto
#'
#' @return Ruta al archivo solicitado
#' @export
#'
#' @importFrom rstudioapi getActiveProject
get_projectfile_path <- function(file,
                                 where     = c("project", "package"),
                                 proj_path = rstudioapi::getActiveProject()) {
  where <- match.arg(where)
  file  <- match.arg(file, choices = PROJECT_FILES)

  if (where == "package") {

    system.file(RESOURCE_DIR, file, package = PKG_NAME)

  } else {

    dir <- if (file != README_FILE) file.path(proj_path, RESOURCE_DIR)
           else                     proj_path

    file.path(dir, file)
  }
}

#' @export
get_pkg_docx_template <- function(where     = "package",
                                  proj_path = rstudioapi::getActiveProject()) {

  get_projectfile_path(WORD_TEMPLATE_FILE, where = where, proj_path = proj_path)
}

#' @export
get_proj_bib_file <- function(where     = "project",
                              proj_path = rstudioapi::getActiveProject()) {

  get_projectfile_path(BIBLIOGRAPHY_FILE, where = where, proj_path = proj_path)
}

#' @export
get_proj_csl_file <- function(where     = "package",
                              proj_path = rstudioapi::getActiveProject()) {

  get_projectfile_path(CITATION_SYLE_FILE, where = where, proj_path = proj_path)
}

#' @export
get_proj_readme_file <- function(where     = "package",
                                 proj_path = rstudioapi::getActiveProject()) {

  get_projectfile_path(README_FILE, where = where, proj_path = proj_path)
}
