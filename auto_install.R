# ==============================================================================
#
# FILE NAME:   auto_install.R
# DESCRIPTION: This script can be used to automatically install and configure
#              the package ecs.data
#
# AUTHOR:      Daniel Morillo (danivmorillo@gmail.com)
#
# DATE:        06/07/2021
#
# ==============================================================================


## ---- MAIN: ------------------------------------------------------------------

if (!require(devtools, quietly = TRUE)) install.packages("devtools")

devtools::install_github("hemken/Statamarkdown")

devtools::install_github("CCOMS-UAM/ecs-data")

ecs.data::configure_ecs(
  check_R_version = TRUE,
  check_CRAN_deps = TRUE,
  confirmation    = TRUE
)
