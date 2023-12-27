---
marp: true
title: Vignette 02 - RStudio and friends
description: Julien Arino - R for modellers - Vignette 02 - RStudio and friends.
theme: default
class: invert
math: mathjax
paginate: false
size: 4:3
---

<style>
  img[alt~="center"] {
    display: block;
    margin: 0 auto;
  }
</style>

<!-- backgroundColor: black -->
<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Vignette 02<br>RStudio and friends

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

<!-- _backgroundImage: "radial-gradient(red,30%,black)" -->
# Outline

- [RStudio](#rstudio)
- [RStudio server](#rstudio-server)
- Sweave
- RMarkdown
- Quarto
- Shiny
- Shiny server

---

# Posit

- [Posit](https://posit.co/) was formerly called `RStudio`, like their main product

- Did a lot of development for `R`, still do even on the open source side of things

- For-profit company, sells "pro" versions of its open source products

- IMOBO: in the process of moving to the "dark side", trying to ram "pro" versions down your throat

- You can completely exist without using the pro versions, though, don't worry!

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->RStudio

---

# RStudio

- [RStudio](https://posit.co/products/open-source/rstudio/) has become the reference IDE for `R`
- [Download link](https://posit.co/download/rstudio-desktop/), since the main download links appear broken

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->RStudio server

---

# RStudio server

- [RStudio server](https://posit.co/products/open-source/rstudio-server/): run RStudio on a Linux server and connect via a web interface
- [Download link](https://posit.co/download/rstudio-server/), since the main download links appear broken
- Note that as far as I can tell, there is no mechanism to auto-update RStudio-server, so you will have to program something or check the site regularly..

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Sweave

---

# Sweave

- RSweave: LaTeX incorporating R commands. Useful for generating reports. Not used as much as Rmarkdown these days

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->RMarkdown

---

# RMarkdown

- Rmarkdown: markdown that incorporates R commands. Useful for generating reports in html or pdf, can make slides as well..

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Quarto

---

# Quarto

- Promoted as next-gen version of Sweave/RMarkdown
- Will confess that I have not yet seen why switch

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Shiny

---

# Shiny

- Shiny: easily create an interactive web site running R code

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Shiny server

---

# Shiny server

- [Shiny server](https://posit.co/products/open-source/shinyserver/): run Shiny apps on a Linux server
- Useful for instance if you have a Linux VM running somewhere
- 

