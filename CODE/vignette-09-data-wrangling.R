# Example code for Vignette 09
# Data wrangling


github_URL = "https://raw.githubusercontent.com/"
repo_URL = "julien-arino/datasets/master/"
file_name = "SARS_data.csv"
SARS_URL = paste0(github_URL, repo_URL, file_name)
SARS = read.csv(SARS_URL)

# Name of the country we want to keep
ctry = "Canada"

# Doing things "old school"
SARS_selected = SARS[SARS$country == ctry, ]

# Doing things old school, version 2
idx = which(SARS$country == ctry)
head(idx)
SARS_selected = SARS[idx,]

# Playing with indices
idx_CAN = which(SARS$country == ctry)
idx_date = which(SARS$toDate < "2003-04-30")
idx_CAN_date = intersect(idx_CAN, idx_date)

# Using sqldf
library(sqldf)
query = paste0("SELECT * ",
               "FROM SARS ",
               "WHERE country = '", 
               ctry, "'")
SARS_selected = sqldf(query)

# Using dplyr
library(dplyr)
SARS_selected = SARS %>%
  filter(country == ctry)


# Make the incidence column
SARS_selected$incidence = 
  c(0, diff(SARS_selected$totalNumberCases))

# Keep only positive incidences (discard 0 or negative adjustments)
SARS_selected = SARS_selected %>%
  filter(incidence > 0)

# Make the date column a date
SARS_selected$toDate = lubridate::ymd(SARS_selected$toDate)

# Make a smaller data frame with only the columns we need for the plot
SARS_to_plot = SARS_selected %>%
  select(toDate, incidence)
# We need a function from the following library:
library(incidence2)
# For the vignettes, we want to make this plot on a black background
# Are we plotting for a dark background
plot_blackBG = TRUE
# We use the function incidence2::incidence to prepare the data for
# the plot
incid = incidence(SARS_to_plot, 
                  date_index = "toDate", 
                  counts = "incidence")
if (plot_blackBG) {
  library(ggdark)
  plot(incid) +
    labs(fill = "Type") +
    xlab("Date") + ylab("Incidence") +
    labs(caption = 
           sprintf("SARS-CoV-1 incidence in %s", ctry)) +
    dark_mode() + 
    theme(legend.position = "none")
} else {
  plot(incid) +
    labs(fill = "Type") +
    xlab("Date") + ylab("Incidence") +
    labs(caption = 
           sprintf("SARS-CoV-1 incidence in %s", ctry)) +
    theme(legend.position = "none")
}
# Save the figure
ggsave(filename = sprintf("../SLIDES/FIGS/SARS-CoV-1-%s.png",
                          ctry),
       width = 20, height = 10, units = "cm")

# Crop the figure (using a function in useful_functions.R)
# crop_figure(sprintf("../SLIDES/FIGS/SARS-CoV-1-%s.png", ctry))

