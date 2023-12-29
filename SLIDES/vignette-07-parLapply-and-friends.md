---
marp: true
title: Vignette 07 - parLapply and friends
description: Julien Arino - R for modellers - Vignette 07 - parLapply and friends.
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
# Vignette 07<br>parLapply and friends

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
- [Embarrassingly parallel problems](#embarrassingly-parallel-problems)
- [Setting up a cluster](#setting-up-a-cluster)

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# <!--fit-->Embarrassingly parallel problems

---

# Embarrassingly parallel problems

Some of the computational tasks we perform are embarrassingly parallel: they can be split into independent sub-tasks that can be run in parallel

For example, independent simulations of a stochastic process or evaluation of the output of a function at different parameter values

These problems are easy to parallelise

---

# Benefits of parallelisation 

- If your task is simple enough, you get a speed-up that is close to the number of cores you have available
  - If you have 8 threads and are evaluating a function at 8 different parameter values, then the 8 calls can happen simultaneously
- If your task is more complex, you get a speed-up, but it will be less than the number of cores you have available
  - There is some overhead associated with parallelisation
  - Some tasks are already parallelised (e.g. matrix multiplication), which means that you do not get a speed-up if you parallelise them again

---

# Amdahl's law

$$
  S_{\text{latency}}(s)=
  \frac {1}{(1-p)+p/s}
$$

where
- $S_{\text{latency}}$ is the theoretical speedup of the execution of the whole task
- $s$ is the speedup of the part of the task that benefits from improved system resources
- $p$ is the proportion of execution time that the part benefiting from improved resources originally occupied

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# <!--fit-->Setting up a cluster

---
