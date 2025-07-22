library(tidyverse)
library(janitor)
library(tidycensus)
library(stringr)
library(prettyunits)
library(lubridate)
library(scales)
library(dplyr)
library(readxl)
library(readr)
library(ggplot2)


# PRM Refugee Admissions Report
prm_refugee_admissions <- read_xlsx("Spreadsheets/PRM/PRM Refugee Admissions Report 2024.xlsx")

prm_sheets <- lapply(excel_sheets("Spreadsheets/PRM/PRM Refugee Admissions Report 2024.xlsx"), 
                     read_excel, 
                     path = "Spreadsheets/PRM/PRM Refugee Admissions Report 2024.xlsx")
prm_sheet_names <- excel_sheets("Spreadsheets/PRM/PRM Refugee Admissions Report 2024.xlsx")
for (i in seq_along(prm_sheet_names)) {
  write.csv(prm_sheets[[i]], file = paste0("Spreadsheets/PRM/", prm_sheet_names[i], ".csv"), row.names = FALSE)
} # yearly sheets unnecessary for current level of analysis, but saved just in case


# Cleaning the cumulative sheet
prm_cumulative <- read.csv("Spreadsheets/PRM/Cumulative Summary.csv", skip = 9) %>%
  select(-"NA..2")
prm_cumulative_header <- prm_cumulative[1:3, ] %>%
  t() %>%
  as.data.frame() %>%
  mutate(merged = apply(., 1, function (x) paste(na.omit(x), collapse = " ")))
  final_header <- prm_cumulaive_header$merged
prm_cumulative_clean <- prm_cumulative[-(1:3), ]
names(prm_cumulative_clean) <- final_header
prm_cumulative_no_footer <- prm_cumulative_clean[-(52:55), ] %>%
  clean_names()
write.csv(prm_cumulative_no_footer, "Spreadsheets/PRM/cleaned_cumalative_summary.csv", row.names = FALSE)






# Creating df for presidential admins
pres_admins <- data.frame(
  president = c("Ford", "Carter", "Reagan", "Bush.Sr", "Clinton", "Bush.Jr", "Obama", "Trump", "Biden"),
  start_year = c(1975, 1977, 1981, 1989, 1993, 2001, 2009, 2017, 2021),
  end_year = c(1976, 1980, 1988, 1992, 2000, 2008, 2016, 2020, 2024)
)


# Making numeric and pivoting
prm_summary <- prm_cumulative_no_footer %>%
  mutate(across(everything(), ~as.numeric(.)))
prm_long <- prm_summary %>%
  pivot_longer(
    cols = -fiscal_year,
    names_to = "Region",
    values_to = "Admissions"
  )


# Line colors
region_colors <- c(
  africa = "#D55E00",
  asia = "#0072B2",
  europe_central_asia = "#F0E442",
  former_soviet_union = "#CC79A7",
  kosovo = "#999999",
  latin_america_caribbean = "#56B4E9",
  near_east_south_asia = "#009E73",
  psi = "#E69F00",
  total = "#000000"
)


# Plotting line graph
timeline <- ggplot(prm_long) +
    geom_line(aes(x = fiscal_year, y = Admissions, color = Region), size = 1.1) +
  scale_x_continuous(breaks = seq(1975, 2025, by = 5)) +
  scale_y_continuous(
    limits = c(0,220000),
    labels = scales::unit_format(scale = 1/1000, unit="K")
  ) +
  scale_color_manual(values = region_colors) +
  labs(
    title = "Refugee Admissions to the United States from Fiscal Year 1975 to 2025",
    x = "Year",
    y = "Refugee Admissions",
    caption = "Source: Refugee Processing Center Report on Bureau of Population, Refugees, and Migration (PRM) data
    Link: https://www.wrapsnet.org/admissions-and-arrivals/"
  ) +
  geom_rect(
    data = pres_admins,
    aes(xmin = start_year - 1, xmax = end_year, ymin = -Inf, ymax = Inf, fill = president), 
    inherit.aes = FALSE,
    alpha = 0.1,
    show.legend = FALSE
  ) +
  scale_fill_manual(values = c(
   Ford = "#FF0000", 
   Carter = "#0000FF", 
   Reagan = "#FF0000",
   Bush.Sr = "#FF0000", 
   Clinton = "#0000FF", 
   Bush.Jr = "#FF0000", 
   Obama = "#0000FF", 
   Trump = "#FF0000", 
   Biden = "#0000FF"
  )) +
  geom_vline(
    data = pres_admins,
    aes(xintercept = end_year),
    linetype = "dashed"
  ) +
  geom_text(data = pres_admins,
            aes(x = (start_year + end_year) / 2,
                y = 220000,  
                label = president)) +
  theme_minimal()
timeline
ggsave("Charts/prm_admissions_timeline_1975_2025.png", timeline, width = 16, height = 9, units = "in", dpi = 300)




# Plotting line graph -- total only
timeline_total_only <- ggplot(prm_summary) +
  geom_line(aes(x = fiscal_year, y = total), linewidth = 1.1) +
  scale_x_continuous(breaks = seq(1975, 2025, by = 5)) +
  scale_y_continuous(
    limits = c(0,220000),
    labels = scales::unit_format(scale = 1/1000, unit="K")
  ) +
  labs(
    title = "Refugee Admissions to the United States from Fiscal Year 1975 to 2025",
    x = "Year",
    y = "Refugee Admissions",
    caption = "Source: Refugee Processing Center Report on Bureau of Population, Refugees, and Migration (PRM) data
    Link: https://www.wrapsnet.org/admissions-and-arrivals/"
  ) +
  geom_rect(
    data = pres_admins,
    aes(xmin = start_year - 1, xmax = end_year, ymin = -Inf, ymax = Inf, fill = president), 
    inherit.aes = FALSE,
    alpha = 0.1,
    show.legend = FALSE
  ) +
  scale_fill_manual(values = c(
    Ford = "#FF0000", 
    Carter = "#0000FF", 
    Reagan = "#FF0000",
    Bush.Sr = "#FF0000", 
    Clinton = "#0000FF", 
    Bush.Jr = "#FF0000", 
    Obama = "#0000FF", 
    Trump = "#FF0000", 
    Biden = "#0000FF"
  )) +
  geom_vline(
    data = pres_admins,
    aes(xintercept = end_year),
    linetype = "dashed"
  ) +
  geom_text(data = pres_admins,
            aes(x = (start_year + end_year) / 2,
                y = 220000,  
                label = president))+
  theme_minimal()
timeline_total_only
ggsave("Charts/total_admissions_1975_2025.png", timeline_total_only, width = 16, height = 9, units = "in", dpi = 300)








# Plotting line graph -- historical trends
timeline_historical <- ggplot(prm_long) +
  geom_line(aes(x = fiscal_year, y = Admissions, color = Region)) +
  scale_x_continuous(breaks = seq(1975, 2025, by = 5)) +
  scale_y_continuous(
    limits = c(0,220000),
    labels = scales::unit_format(scale = 1/1000, unit="K")
  ) +
  scale_color_manual(values = region_colors) +
  labs(
    title = "Refugee Admissions to the United States from Fiscal Year 1975 to 2025",
    x = "Year",
    y = "Refugee Admissions",
    caption = "Source: Refugee Processing Center Report on Bureau of Population, Refugees, and Migration (PRM) data
    Link: https://www.wrapsnet.org/admissions-and-arrivals/"
  )+
  theme_minimal()
timeline_historical
ggsave("Charts/prm_admissions_timeline_historical.png", timeline_historical, width = 16, height = 9, units = "in", dpi = 300)





# Plotting Bar Graph
prm_totals <- prm_summary %>%
  select(fiscal_year, total)
pres_admins_long <- pres_admins %>%
  rowwise() %>%
  mutate(fiscal_year = list(seq(start_year, end_year))) %>%
  unnest(fiscal_year)
prm_totals_by_pres <- left_join(pres_admins_long, prm_totals) %>%
  group_by(president)
pres_yrly_avg <- prm_totals_by_pres %>%
  group_by(president) %>%
  summarize(
    term_start = min(fiscal_year),
    term_end = max(fiscal_year),
    avg_admissions = mean(total, na.rm = TRUE),
    total_admissions = sum(total, na.rm = TRUE)
    ) %>%
  arrange(term_start)

bar_pres_avgs <- ggplot(pres_yrly_avg) +
  geom_col(mapping = aes(x = reorder(president, term_start), y = avg_admissions, fill = president), show.legend = FALSE) +
  scale_fill_manual(values = c(
    Ford = "#FF0000", 
    Carter = "#0000FF", 
    Reagan = "#FF0000",
    Bush.Sr = "#FF0000", 
    Clinton = "#0000FF", 
    Bush.Jr = "#FF0000", 
    Obama = "#0000FF", 
    Trump = "#FF0000", 
    Biden = "#0000FF"
  )) +
  scale_y_continuous(
    limits = c(0, 125000),
    labels = scales::unit_format(scale = 1/1000, unit="K")) +
  labs(
    title = "Average Yearly Refugee Admissions By Presidential Administration Since 1975",
    x = "President",
    y = "Average Admissions Per Year",
    caption = "Source: Refugee Processing Center Report on Bureau of Population, Refugees, and Migration (PRM) data
    Link: https://www.wrapsnet.org/admissions-and-arrivals/"
  ) +
  geom_hline(yintercept = 72155, color = "black", linetype = "dashed") +
  theme_minimal()
bar_pres_avgs
ggsave("Charts/avg_admissions_by_pres.png", bar_pres_avgs)
