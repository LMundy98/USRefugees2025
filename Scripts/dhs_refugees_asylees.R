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
library(svglite)
library(rvg)
library(officer)

# read and clean csvs
refugee_arrivals_fy23 <- read.csv("Spreadsheets/DHS/total_refugees_fy2023.csv") %>%
  clean_names() %>%
  mutate(
    fiscal_year = as.integer(year),
    arrivals = str_remove_all(number, ",") %>%
      str_trim() %>%
      as.numeric()
  ) %>%
  select(-year, -number)

asylum_grants_fy23 <- read.csv("Spreadsheets/DHS/total_asylees_fy2023.csv") %>%
  clean_names() %>%
  mutate(
    across(
      c(total, affirmative, defensive),
      ~ str_remove_all(.x, ",") %>%
        str_trim() %>%
        as.numeric()
    )
  ) %>%
rename(fiscal_year = year)


# Creating dataframe for presidential admins
pres_admins <- data.frame(
  president = c("Ford", "Carter", "Reagan", "Bush.Sr", "Clinton", "Bush.Jr", "Obama", "Trump", "Biden"),
  start_year = c(1975, 1977, 1981, 1989, 1993, 2001, 2009, 2017, 2021),
  end_year = c(1976, 1980, 1988, 1992, 2000, 2008, 2016, 2020, 2024)
)


# Plot refugee arrivals on line graph
arrivals_line_plot <- ggplot(data = refugee_arrivals_fy23) +
  geom_line(
    aes(x = fiscal_year, y = arrivals)
  ) +
  theme_minimal()

arrivals_line_plot

arrivals_line_plot_dml <- rvg::dml(ggobj = arrivals_line_plot)
officer::read_pptx() %>%
  officer::add_slide() %>%
  officer::ph_with(arrivals_line_plot_dml, ph_location()) %>%
  base::print(
    target = here::here(
      "_posts",
      "2020-09-22-exporting-editable-ggplot-graphics",
      "slides",
      "demo_one.pptx"
    )
  ) # troubleshooting

ggsave("Charts/dhs_ref_arrivals_fy23.png", arrivals_line_plot, width = 16, height = 9, units = "in", dpi = 300)
ggsave("Charts/dhs_ref_arrivals_fy23.svg", arrivals_line_plot, device = "svg")
ggsave("Charts/dhs_ref_arrivals_fy23.emf", arrivals_line_plot)

# Plot Asylum grants on line graph
asylum_fy23_long <- pivot_longer(
  data = asylum_grants_fy23,
  cols = c(total, affirmative, defensive),
  names_to = "proceeding_type",
  values_to = "cases_approved"
  )

asylum_line_plot <- ggplot(data = asylum_fy23_long) +
  geom_line(
    aes(x = fiscal_year, y = cases_approved, color = proceeding_type)
  ) +
  theme_minimal()

asylum_line_plot # Line plot may not be most informative here, since this is not a flow over time but cases approved in a year. Bar plot may be more informative


