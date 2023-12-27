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
- [RMarkdown](#rmarkdown)
- [Sweave](#sweave)
- [Quarto](#quarto)
- [Shiny](#shiny)
- [Shiny server](#shiny-server)

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
# <!--fit-->RMarkdown

---

# RMarkdown

- Rmarkdown: markdown that incorporates R commands
- Useful for generating reports in html, pdf or doc, can make slides as well..
- See [Vignette 13](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-13-RMarkdown.html)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Sweave

---

# Sweave

- Sweave: LaTeX incorporating R commands
- Useful for generating pdf reports
- Not used as much as Rmarkdown these days, probably because Rmarkdown allows output also in html and doc
- If you have a whole document to typeset using LaTeX, then still the best option
- See [Vignette 14](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-14-Sweave.html)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Quarto

---

# Quarto

- Promoted as next-gen version of Sweave/RMarkdown
- Will confess that I have not yet seen why switch
- See [Vignette 15](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-15-Quarto.html)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Shiny

---

# Shiny

- Shiny: easily create an interactive web site running R code
- See [Vignette 16](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-16-Shiny.html)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# <!--fit-->Shiny server

---

# Shiny server

- [Shiny server](https://posit.co/products/open-source/shinyserver/): run Shiny apps on a Linux server
- Useful for instance if you have a Linux VM running somewhere
- See, e.g., my instance [here](https://daytah-or-dahtah.ovh:3838/)
- See [Vignette 17](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-17-Shiny-server.html)

