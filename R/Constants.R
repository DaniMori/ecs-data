PKG_NAME <- ecs.data:::.packageName

R_VERSION <- "4.1.0"

STATAMARKDOWN_URL <- "hemken/Statamarkdown"

CRAN_DEPENDENCIES <- c(
  "assertive.properties",
  "assertive.strings",
  "configr",
  "devtools",
  "glue",
  "haven",
  "htmltools",
  "miniUI",
  "rmarkdown",
  "rstudioapi",
  "shiny",
  "stringr",
  "tools",
  "utils"
)


REMOTE_REPO <- "https://cran.rstudio.com"

USER_HOME_DIR       <- '~'
ONEDRIVE_SHARED_SEP <- ' - '
DIR_SEP             <- '/'
FILE_EXT_SEP        <- '.'
EMPTY_FILE_NAME     <- '.'


DEFAULT_ECS_MAIN_PATH <- file.path(USER_HOME_DIR, "..", "UAM")

ECS_DIRS_OWNER <- "marta.miret@uam.es"
DEFAULT_DB_DIR <- paste(
  ECS_DIRS_OWNER,
  "Bases de datos maestras Edad con Salud",
  sep = ONEDRIVE_SHARED_SEP
)
DEFAULT_DOC_DIR <- paste(
  ECS_DIRS_OWNER,
  "Documentacion Edad con Salud",
  sep = ONEDRIVE_SHARED_SEP
)
DEFAULT_DB_PATH  <- file.path(DEFAULT_ECS_MAIN_PATH, DEFAULT_DB_DIR)
DEFAULT_DOC_PATH <- file.path(DEFAULT_ECS_MAIN_PATH, DEFAULT_DOC_DIR)

DOC_DIR           <- "doc"
OUTCOMES_DIR      <- "outcomes"
COHORT_2019_DIR   <- "cohorte_2019"
COHORT_2011_DIR   <- "cohorte_2011"
WAVE_1_DIR        <- "ola_1"
WAVE_2_DIR        <- "ola_2"
WAVE_3_DIR        <- "ola_3"
WAVE_4_DIR        <- "ola_4"
COVID_SUBS_DIR    <- "post_confinamiento"
PRE_LOCKDOWN_DIR  <- "submuestra_pre_confinamiento"
COMPLETE_DIR      <- "muestra_completa"
RESOURCE_DIR      <- "www"

WORD_TEMPLATE_FILE <- "Description_outcome_vars_template.docx"
CITATION_SYLE_FILE <- "apa-old-doi-prefix.csl"
BIBLIOGRAPHY_FILE  <- "Edad_con_salud_outcome_vars.bib"
README_FILE        <- "readme.md"

PROJECT_FILES <- c(
  WORD_TEMPLATE_FILE,
  CITATION_SYLE_FILE,
  BIBLIOGRAPHY_FILE,
  README_FILE
)

CONFIG_TYPE <- "yaml"
CONFIG_FILE <- paste("config", CONFIG_TYPE, sep = FILE_EXT_SEP)

BASE_OUTCOME_FOLDER <- file.path(DOC_DIR, OUTCOMES_DIR)

# Folders where the Rmarkdown documents reside:
OUTCOME_VARS_FOLDERS <- c(
  file.path(BASE_OUTCOME_FOLDER, COHORT_2011_DIR, WAVE_1_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2011_DIR, WAVE_2_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2011_DIR, WAVE_3_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2011_DIR, WAVE_4_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2019_DIR, WAVE_1_DIR, PRE_LOCKDOWN_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2019_DIR, WAVE_1_DIR, COMPLETE_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2019_DIR, COVID_SUBS_DIR),
  file.path(BASE_OUTCOME_FOLDER, COHORT_2019_DIR, WAVE_2_DIR)
)

# Project folders to generate:
PROJECT_FOLDERS <- c(OUTCOME_VARS_FOLDERS, file.path(RESOURCE_DIR))


## Output directories:
DIR_OUTPUT_TERMINAL <- "Outcome descriptions"

DIR_OUTPUT <- file.path(
  c(
    "Edad con salud - Ola 1 - Línea base/Outcomes",
    "Edad con salud - Ola 2/Outcomes",
    "Edad con salud - Ola 3/Outcomes/Cohorte 2011",
    "Edad con salud - Ola 4/Outcomes/Cohorte 2011",
    file.path(
      "Edad con salud - Ola 3",
      "Outcomes/Cohorte 2019/Submuestra_1_preconfinamiento"
    ),
    file.path(
      "Edad con salud - Ola 3",
      "Outcomes/Cohorte 2019/Muestra completa"
    ),
    "Edad con salud - Subestudio COVID/Outcomes",
    "Edad con salud - Ola 2/Outcomes/Cohorte 2019"
  ),
  DIR_OUTPUT_TERMINAL
)
names(DIR_OUTPUT) <- OUTCOME_VARS_FOLDERS


STATA_EXT <- "dta"
SPSS_EXT  <- "sav"
RMD_EXT   <- "Rmd"
WORD_EXT  <- "docx"


SUFFIX_SEP         <- '_'
PATHS_COLLAPSE     <- '; '
INIT_REGEX_PREFFIX <- '^'
END_REGEX_SUFFIX   <- '$'
REGEX_ESCAPE       <- '\\'
ENDLINE            <- '\n'
EMPTY_STRING       <- ''
HORIZONTAL_RULE    <- paste0(rep('-', 74), collapse = EMPTY_STRING)
