---
marp: true
title: Lecture 10 - Solving ODE
description: Julien Arino - R for modellers - Lecture 10 - Solving ordinary differential equations (ODE) in R
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

# Lecture 10 - Solving ODE

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

- The deSolve library

---

<!-- _backgroundImage: "linear-gradient(to bottom, red, black)" -->
# The deSolve library

---

# The deSolve library

- As I have already pointed out, [`deSolve`](https://cran.r-project.org/web/packages/deSolve/index.html):
> The functions provide an interface to the FORTRAN functions 'lsoda', 'lsodar', 'lsode', 'lsodes' of the 'ODEPACK' collection, to the FORTRAN functions 'dvode', 'zvode' and 'daspk' and a C-implementation of solvers of the 'Runge-Kutta' family with fixed or variable time steps

---

- You are benefiting from years and years of experience: [ODEPACK](https://computing.llnl.gov/projects/odepack) is a set of Fortran (77!) solvers developed at Lawrence Livermore National Laboratory (LLNL) starting in the late 70s

- Other good solvers written in `C` are also included

- Refer to the [package help](https://cran.r-project.org/web/packages/deSolve/deSolve.pdf) for details

---

# Using deSolve for simple ODEs

As with more numerical solvers, you need to write a function returning the value of the right hand side of your equation (the vector field) at a given point in phase space, then call this function from the solver

```R
library(deSolve)
rhs_logistic <- function(t, x, p) {
  with(as.list(x), {
    dN <- p$r * N *(1-N/p$K)
    return(list(dN))
  })
}
params = list(r = 0.1, K = 100)
IC = c(N = 50)
times = seq(0, 100, 1)
sol <- ode(IC, times, rhs_logistic, params)
```

---

This also works: add `p` to arguments of `as.list` and thus use without `p$` prefix

```R
library(deSolve)
rhs_logistic <- function(t, x, p) {
  with(as.list(c(x, p)), {
    dN <- r * N *(1-N/K)
    return(list(dN))
  })
}
params = list(r = 0.1, K = 100)
IC = c(N = 50)
times = seq(0, 100, 1)
sol <- ode(IC, times, rhs_logistic, params)
```

In this case, beware of not having a variable and a parameter with the same name..

---

# Default method: `lsoda`

- `lsoda` switches automatically between stiff and nonstiff methods

- You can also specify other methods: "lsode", "lsodes", "lsodar", "vode", "daspk", "euler", "rk4", "ode23", "ode45", "radau", "bdf", "bdf_d", "adams", "impAdams" or "impAdams_d" ,"iteration" (the latter for discrete-time systems)

```
ode(y, times, func, parms, 
    method = "ode45")
```

- You can even implement your own integration method

