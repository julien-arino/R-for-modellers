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

Failure to use the "user friendly" method presented later will result in loss of marks in your `R` assignments!

---

<!-- _backgroundImage: "radial-gradient(red,30%,black)" -->
# Outline

- Packages (a.k.a. libraries)
- Installing a package
- Loading a package
- Be friendly to others!

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->Packages (a.k.a. libraries)

---

# <!--fit-->Be friendly to others!

---

# <!--fit-->When distributing your code, think of those using it

If you are using a slightly unusual library, it is possible that a person you share your code with does not have that library installed

In this case, it is nice to them if you spare them having to do the work to install the library

But it is also possible that they already have the library

In this case, it will be annoying to them if you trigger an installation of the library (especially under linux, since there libraries are compiled for installation)

---

So the way to proceed is to test whether the library is installed

If it is, load it

If it is not, install it then load it