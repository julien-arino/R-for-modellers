---
marp: true
title: Vignette 12 - Fitting an ODE
description: Julien Arino - R for modellers - Lecture 12 - Fitting ordinary differential equations (ODE) to data in R
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

# Vignette 12<br>Fitting an ODE

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
- Principle - Fitting data
- Example 1 - Kermack McKendrick SIR epidemic model

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Principle - Fitting data

---

# Fitting data

- Note that this is a super simplified version of what to do
- Much more elaborate procedures exist
  - Roda. [Bayesian inference for dynamical systems](https://doi.org/10.1016/j.idm.2019.12.007)
  - Portet. [A primer on model selection using the Akaike Information Criterion](https://doi.org/10.1016/j.idm.2019.12.010)

---

- Let us grab some epi data online and fit an SIR model to it
- Do not expect anything funky, as I said, this is the baby version
- Also, keep in mind that any identification procedure is subject to risks due to *identifiability issues*; see, e.g., Roda et al, [Why is it difficult to accurately predict the COVID-19 epidemic?](https://doi.org/10.1016/j.idm.2020.03.001)

---

# Principle

- Data is a set $(t_i,y_i)$, $i=1,\ldots,N$, where $t_i\in\mathcal{I}$, some interval
- Solution to SIR is $(t,x(t))$ for $t\in\mathcal{I}$
- Suppose parameters of the model are $p$
- We want to minimise the error function
$$
E(p) = \sum_{i=1}^N \|x(t_i)-y_i\|
$$

---

- Norm is typically Euclidean, but could be different depending on objectives
- So given a point $p$ in (admissible) parameter space, we compute the solution to the ODE, compute $E(p)$
- Using some minimisation algorithm, we seek a minimum of $E(p)$ by varying $p$

---

# What are $y_i$ and $x(t_i)$ here?

- In epi data for infectious diseases, we typically have incidence, i.e., number of new cases per unit time
- In SIR model, this is $\beta SI$ or $\beta SI/N$, so, if using mass action incidence and Euclidean norm
$$
E(p)=\sum_{i=1}^N(\beta S(t_i)I(t_i)-y_i)^2
$$
or, if using standard incidence
$$
E(p)=\sum_{i=1}^N
\left(\beta \frac{S(t_i)I(t_i)}{N}-y_i\right)^2
$$

---

# Implementing in practice

See the code [practicum_01_fitting.R](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/CODE/practicum_01_fitting.R), which we will go over now