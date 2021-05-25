#' @importFrom assertive.strings is_an_empty_string
#' @importFrom devtools          session_info install_github
#' @importFrom stringr           str_extract
setup_ecs_project <- function(path, ...) {

  # Ensure project path exists:

  dir.create(path, recursive = TRUE, showWarnings = FALSE)


  # Create directory structure:

  for(folder in PROJECT_FOLDERS) {

    new_folder <- file.path(path, folder)
    dir.create(new_folder, recursive = TRUE)
    Sys.chmod(new_folder, mode = "200") ## TODO: Testear modo lectura
  }


  # Populate necessary files:

  resource_path <- file.path(path, RESOURCE_DIR)

  file.copy(
    from = get_proj_bib_file(where = "package"),
    to   = get_proj_bib_file(where = "project", proj_path = path)
  )
  file.copy(
    from = get_proj_readme_file(where = "package"),
    to   = get_proj_readme_file(where = "project", proj_path = path)
  )


  # collect inputs:

  params <- list(...) # TODO: Not used


  # Execute configuration (if requested):

  if (params$exec_conf) {

    configure_ecs(
      check_R_version     = TRUE,
      check_CRAN_deps     = TRUE,
      confirmation        = TRUE
    )
  }

  NULL
}
