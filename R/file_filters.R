create_glob <- function(file_type, file_ext) {

  paste0(file_type, " (*.", file_ext, ")")
}

create_file_filters <- function(descriptions, extensions) {

  descriptions <- create_glob(descriptions, extensions)
  ext_masks    <- paste0("*.", extensions)

  matrix(
    c(descriptions, ext_masks),
    ncol = 2,
    dimnames = list(extensions, NULL)
  )
}
