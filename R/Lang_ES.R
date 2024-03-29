CHECK_DEPENDENCIES <- "\nComprobando e instalando paquetes necesarios"

CONFIGURATION_MSG  <- "Se va a configurar el paquete 'ecs.data'"
CONFIGURATION_DIRS <- "Selecciona la ubicacion de las carpetas de Edad con Salud"
CONFIGURATION_OK   <- "El paquete 'ecs.data' se ha configurado correctamente"
CONFIGURATION_WARN <-
  "Hubo problemas durante la configuraciOn del paquete 'ecs.data'"


CONFIGURING_FOLDERS <- "\nConfigurando carpetas de proyecto de 'Edad con Salud'"
SELECT_DB_FOLDER    <- "\nSelecciona la carpeta de 'Bases de Datos maestras'"
SELECT_DOC_FOLDER   <- "\nSelecciona la carpeta de 'Documentacion'"

NO_DB_FOLDER_SELECTED <-
  "\nNo se ha seleccionado ninguna carpeta de 'Bases de Datos maestras'"
NO_DOC_FOLDER_SELECTED <-
  "\nNo se ha seleccionado ninguna carpeta de 'Documentacion'"
DB_FOLDER_SELECTED <-
  "\n\nSeleccionada como carpeta de 'Bases de Datos maestras' la ruta:\n{db_dir}"
DOC_FOLDER_SELECTED <-
  "\n\nSeleccionada como carpeta de 'Documentación' la ruta:\n{doc_dir}"
CONFIG_FOLDER_ERROR <-
  "\nError al escribir las carpetas de proyecto en el archivo de configuración."
RUN_CONFIG_FOLDER_ERROR <-
  "\nEjecución de `config_ecs_folders()` falló; ejecútala manualmente."
CONFIG_FILE_NOT_SET <-
  "\nConfiguración pendiente de ejecutar; ejecuta `config_ecs_folders()`."


NO_INPUT_FILE_SELECTED <-
  "No se ha seleccionado ningún archivo de SPSS para convertir"
NO_OUTPUT_FILE_SELECTED <-
  "No se ha seleccionado el nombre del archivo de Stata a escribir"


R_VERSION_CHECK <- "Comprobando version de R"

R_VERSION_OLD <- paste(
  "\n\nTu versión de R es {r_version};",
  "se recomienda actualizar a la versión {R_VERSION} o posterior"
)


SELECT_LABEL          <- "OK"
BROWSE_BUTTON_TEXT    <- "Buscar..."
DOC_PATH_PLACEHOLDER  <- "Selecciona carpeta o documento(s) a procesar"
FILE_PATH_PLACEHOLDER <- "Selecciona archivo"
DOC_S                 <- "Documento(s)"
FOLDER                <- "Carpeta"
USE                   <- "Usar:"
PATH                  <- "Ruta:"
SELECT_DOCUMENT_S     <- "Seleccionar documento(s)"
SELECT_FOLDER         <- "Seleccionar carpeta"
INCLUDE_SUBFOLDERS    <- "Incluir subcarpetas"

OVERWRITE      <- "Sobreescribir..."
OVERWRITE_NONE <- "Ninguno (Genera sólo documentos no existentes)"
OVERWRITE_OLD  <- "Antiguos (Genera sólo documentos actualizados)"
OVERWRITE_ALL  <- "Todos (Genera todos los documentos seleccionados)"
OVERWRITE_NONE_TT <- "Genera sólo documentos no existentes"
OVERWRITE_OLD_TT  <- "Genera sólo documentos actualizados"
OVERWRITE_ALL_TT  <- "Genera todos los documentos seleccionados"

OVERWRITE_LABELS <- c(OVERWRITE_NONE,    OVERWRITE_OLD,    OVERWRITE_ALL)
# OVERWRITE_TOOLTIPS <- c(OVERWRITE_NONE_TT, OVERWRITE_OLD_TT, OVERWRITE_ALL_TT)

PATHS_NOT_IN_PROJECT <-
  "Algunas rutas de origen no están en el proyecto actual."
DOC_WILL_NOT_BE_OVERWRITTEN <-
  "El siguiente documento ya existe y no será sobreescrito:"
DOCUMENTS_TO_CREATE <- "Documentos a generar:"


SELECT_SPSS_FILE  <- "Selecciona el archivo de SPSS para convertir"
SELECT_STATA_FILE <- "Selecciona el nombre para el nuevo archivo de Stata"

SPSS_FILES      <- "Archivos SPSS"
STATA_FILES     <- "Archivos Stata"
RMARKDOWN_FILES <- "Archivos Rmarkdown"

SPSS_FILE  <- "Archivo de SPSS"
STATA_FILE <- "Archivo de Stata"

SPSS_FILE_TO_CONVERT <- paste(SPSS_FILE, "a convertir:")
STATA_FILE_TO_CREATE <- paste(STATA_FILE, "a generar:")


SPSS_TO_STATA_TITLE             <- "SPSS a Stata"
TRANSFORM_SPPS_TO_STATA_CAPTION <- "Convertir archivo SPSS a formato Stata"
TRANSFORMING_DATASET            <- "Convirtiendo el archivo a formato Stata"
DATASET_SAVED                   <- "Archivo guardado en formato Stata con éxito"

GENERATE_OUTCOMES_TITLE   <- "Generar variables outcome"
GENERATE_OUTCOMES_CAPTION <- "Generar variables outcome"


STATAMARKDOWN_INSTALL <- paste(
  "Paquete `Statamarkdown` no encontrado. Instalando `Statamarkdown`"
)

STATAMARKDOWN_INSTALL_ERROR <- paste(
  "\nNo se ha podido instalar el paquete `Statamarkdown`;",
  "intenta instalarlo manualmente.\n",
  "Más información en:\n",
  "https://www.ssc.wisc.edu/~hemken/Stataworkshops/Statamarkdown/installing-statamarkdown.html"
)

STATA_FOUND <- "\n\nInstalación de Stata encontrada en '{stata_path}'"

STATA_NOT_FOUND <- paste(
  "\nNo se ha encontrado una instalación de Stata en tu ordenador.",
  "",
  "Sigue los siguientes pasos:",
  "",
  "1. Comprueba que tienes Stata instalado; en caso contrario, instálalo.",
  "2. Ejecuta Stata.",
  "3. Ejecuta `sysidr` en la consola de Stata (sin acentos invertidos).",
  paste(
    "4. Tu instalación de Stata está en la ruta que aparece en primer lugar,",
    "a continuación de 'STATA'"
  ),
  paste(
    "5. Abre la carpeta indicada en esa ruta y",
    "comprueba el nombre del ejecutable (seguramente 'StataSE-64.exe')"
  ),
  "6. Escribe esa ruta en tus archivos Rmarkdown (línea 20)",
  sep = "\n"
)
