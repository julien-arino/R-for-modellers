---
marp: true
title: Vignette 01 - Introduction to and installation of R
description: Julien Arino - R for modellers - Vignette 01 - Introduction to and installation of R.
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
# Vignette 01 <br> Introduction to & installation of ![width:50px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg)

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics & Data Science Nexus
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Outline

- Foreword: the ![width:32px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) language
- Installing ![width:32px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg)
- Running an ![width:32px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) script from the command line

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# <!--fit-->Foreword: the ![width:40px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) language

---

# <!--fit-->![width:40px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) was originally for stats but is now much more

- Open source version of S
- Appeared in 1993
- Now (2024-01) version 4.3
- One major advantage in my view: uses a lot of C and Fortran code. E.g., `deSolve`:
> The functions provide an interface to the FORTRAN functions 'lsoda', 'lsodar', 'lsode', 'lsodes' of the 'ODEPACK' collection, to the FORTRAN functions 'dvode', 'zvode' and 'daspk' and a C-implementation of solvers of the 'Runge-Kutta' family with fixed or variable time steps
- Very active community on the web, easy to find solutions (same true of Python, I just prefer R)

---

# History of ![width:50px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg)

```R
> install.packages("rversions")
> library(rversions)
> tail(r_versions())
    version                date              nickname
128   4.2.1 2022-06-23 07:05:33     Funny-Looking Kid
129   4.2.2 2022-10-31 08:05:54 Innocent and Trusting
130   4.2.3 2023-03-15 08:06:01      Shortstop Beagle
131   4.3.0 2023-04-21 07:06:14      Already Tomorrow
132   4.3.1 2023-06-16 07:06:07         Beagle Scouts
133   4.3.2 2023-10-31 08:07:42             Eye Holes
```

---

# ![width:50px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) is a scripted language

- Interactive
- Allows you to work in real time
    - Be careful: what is in memory might involve steps not written down in a script
    - If you want to reproduce your steps, it is good to write all the steps down in a script and to test from time to time running using `Rscript`: this will ensure that all that is required to run is indeed loaded to memory when it needs to, i.e., that it is not already there..

---

# Similar to matlab and Python..

.. with some differences, of course! Otherwise, where would the fun be? ;)

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# <!--fit-->Installing ![width:40px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg)

---

# The main location - CRAN

The [Comprehensive R Archive Network](https://cran.r-project.org/) or CRAN is where to go for all official things `R`

To install, select your OS from the main page

---

# A note for Linux users

Often, the version on your distribution is not the most up to date

Instructions are on CRAN about setting things up so you have the latest version. For instance,

- [Debian](https://cran.r-project.org/bin/linux/debian/#secure-apt)
- [Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/)

---

# Development environments

- Terminal version, not very friendly
- Nicer terminal: [radian](https://github.com/randy3k/radian)
- Execute R scripts by using `Rscript name_of_script.R`. Useful to run code in `cron`, for instance
- Integrate into jupyter notebooks
- Use IDEs:
    - [RStudio](https://www.rstudio.com/products/rstudio/) has become the reference (see [Vignette 02](https://julien-arino.github.io/R-for-modellers/SLIDES/vignette-02-Rstudio-and-friends.html))
    - [RKWard](https://invent.kde.org/education/rkward) is useful if you are for instance using an ARM processor (Raspberry Pi, some Chromebooks..)

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:running"></a>
# <!--fit-->Running an ![width:40px](https://raw.githubusercontent.com/julien-arino/R-for-modellers/main/assets/img/Rlogo.svg) script from the command line

---

# Why run from the command line?

As indicated, `R` is a scripted language and when run from an `R` console, it is interactive

$\implies$ what you did before is in memory of the session you are working in

This is frequent cause for errors when sharing your code with others