library(readxl)
library(readr)
library(tidyr)
library(janitor)


# Tracfed DHS Prosecutions 2006-2024
tracfed_dhs_prosecutions_2006_2024 <- read_xlsx("tracfed-dhs-prosecutions-2006-2024.xlsx")

tracfed_sheets <- lapply(excel_sheets("tracfed-dhs-prosecutions-2006-2024.xlsx"), 
                         read_excel, 
                         path = "tracfed-dhs-prosecutions-2006-2024.xlsx")
tracfed_sheet_names <- excel_sheets("tracfed-dhs-prosecutions-2006-2024.xlsx")

for (i in seq_along(tracfed_sheet_names)) {
  write.csv(tracfed_sheets[[i]], file = paste0(tracfed_sheet_names[i], ".csv"), row.names = FALSE)
}


# PRM Refugee Admissions Report
prm_refugee_admissions <- read_xlsx("PRM Refugee Admissions Report 2024.xlsx")

prm_sheets <- lapply(excel_sheets("PRM Refugee Admissions Report 2024.xlsx"), 
                     read_excel, 
                     path = "PRM Refugee Admissions Report 2024.xlsx")
prm_sheet_names <- excel_sheets("PRM Refugee Admissions Report 2024.xlsx")

for (i in seq_along(prm_sheet_names)) {
  write.csv(prm_sheets[[i]], file = paste0("PRM/", prm_sheet_names[i], ".csv"), row.names = FALSE)
}
