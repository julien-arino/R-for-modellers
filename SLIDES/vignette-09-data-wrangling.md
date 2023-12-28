---
marp: true
title: Vignette 09 - Data wrangling
description: Julien Arino - R for modellers - Data wrangling.
theme: default
class: invert
math: mathjax
paginate: false
size: 4:3
---

<style>
  .theorem {
    text-align:justify;
    background-color:#16a085;
    border-radius:20px;
    padding:10px 20px 10px 20px;
    box-shadow: 0px 1px 5px #999;  margin-bottom: 10px;
  }
  .definition {
    text-align:justify;
    background-color:#ededde;
    border-radius:20px;
    padding:10px 20px 10px 20px;
    box-shadow: 0px 1px 5px #999;
    margin-bottom: 10px;
  }
  img[alt~="center"] {
    display: block;
    margin: 0 auto;
  }
</style>

<!-- backgroundColor: black -->
<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Vignette 09 - Data wrangling

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Outline


---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Data wrangling

---

# Data wrangling: `dplyr` vs `sqldf`

`dplyr` is part of the `tidyverse` set of libraries. Load `magrittr` and its pipe `%>%`

`sqldf` allows to use SQL on dataframes.. interesting alternative if you know SQL

---

```R
library(sqldf)
library(dplyr)

SARS = read.csv("../DATA/SARS-CoV-1_data.csv")

## Three ways to keep only the data for one country
ctry = "Canada"
# The basic one
idx = which(SARS$country == ctry)
SARS_selected = SARS[idx,]
# The sqldf way
SARS_selected = sqldf(paste0("SELECT * FROM SARS WHERE country = '", 
                             ctry, "'"))
# The dplyr way
SARS_selected = SARS %>%
  filter(country == ctry)
```

---

```R
# Create incidence for the selected country. diff does difference one by one,
# so one less entry than the vector on which it is being used, thus we pad with a 0.
SARS_selected$incidence = c(0, diff(SARS_selected$totalNumberCases))
# Keep only positive incidences (discard 0 or negative adjustments)
SARS_selected = SARS_selected %>%
  filter(incidence > 0)

# Plot the result
# Before plotting, we need to make the dates column we will use be actual dates..
SARS_selected$toDate = lubridate::ymd(SARS_selected$toDate)
EpiCurve(SARS_selected,
         date = "toDate", period = "day",
         freq = "incidence",
         title = "SARS-CoV-1 incidence in Canada in 2003")
```

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SARS-CoV-1_cases_CAN.png)

