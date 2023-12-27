---
marp: true
title: Vignette 03 - Installing  and loading packages
description: Julien Arino - R for modellers - Vignette 03 - Installing and loading packages.
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
# Vignette 03 - Installing and loading packages

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

# <!--fit-->Note - Required reading/watching for MATH 2740 students

If you are a student in the University of Manitoba's Mathematics of Data Science course (MATH 2740), this is **required** reading/watching

Failure to use the ["friendly" method](#sec:friendly) will result in loss of marks in your `R` assignments!

---

<!-- _backgroundImage: "radial-gradient(red,30%,black)" -->
# Outline

- [Packages (a.k.a. libraries)](#sec:packages)
- [Installing a package](#sec:installing)
- [Loading a package](#sec:loading)
- [Be friendly to others!](#sec:friendly)
- [Updating packages](#sec:updating)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
<a id="sec:packages"></a>
# <!--fit-->Packages (a.k.a. libraries)

---

*Packages* (or *libraries*) extend `R` by providing functions or data that is useful in particular contexts

Packages allow to avoid "bloating", since the `R` core remains relatively light and you only install the additional content you need

---

# CRAN is the main source for packages

```R
> paste(nrow(available.packages()),"on",Sys.Date())
[1] "20240 on 2023-12-26"
```

---

# There are also packages not on CRAN

- For instance, packages on GitHub
- Sometimes packages get removed from CRAN, although the latest versions are typically still available
- Installation is a little different (detailed later)

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
<a id="sec:installing"></a>
# <!--fit-->Installing a package

---

# From CRAN

Use the command `install.packages()`

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
<a id="sec:loading"></a>
# <!--fit-->Loading a package

---

Once a package is installed, you load it with the command `library()`

It is not required to use quotation marks, e.g., `library(ggplot2)`

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
<a id="sec:friendly"></a>
# <!--fit-->Be friendly to others!

---

# <!--fit-->When distributing your code, think of those using it

If you are using a slightly unusual library, it is possible that a person you share your code with does not have that library installed

In this case, it is nice to them if you spare them having to do the work to install the library

But it is also possible that they already have the library

In this case, it will be annoying to them if you trigger an installation of the library (especially under linux, since there libraries are compiled for installation)

---

So the way to proceed is to **test** whether the library is installed

- If it is, load it
- If it is not, install it then load it

```R
if (!require(package_name)) {
    install.packages("package_name")
    library(package_name)
}
```
> `require` is designed for use inside other functions; it returns `FALSE` and gives a warning (rather than an error as `library()` does by default) if the package does not exist.

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
<a id="sec:updating"></a>
# <!--fit-->Updating packages

