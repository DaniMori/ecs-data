PATH_TYPE_SUFFIX <- "type"
LABEL_SUFFIX     <- "suffix"
TEXT_SUFFIX      <- "text"
CHECKBOX_SUFFIX  <- "checkbox"

path_type_id <- function(id) paste(id, PATH_TYPE_SUFFIX, sep = SUFFIX_SEP)
label_id     <- function(id) paste(id, LABEL_SUFFIX,     sep = SUFFIX_SEP)
text_id      <- function(id) paste(id, TEXT_SUFFIX,      sep = SUFFIX_SEP)
checkbox_id  <- function(id) paste(id, CHECKBOX_SUFFIX,  sep = SUFFIX_SEP)
