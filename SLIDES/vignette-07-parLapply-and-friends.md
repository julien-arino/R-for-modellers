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
- [Setting up a cluster on a single machine](#setting-up-a-cluster-on-a-single-machine)

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
# <!--fit-->Setting up a cluster on a single machine
- [Example 1 - Sensitivity of $\mathcal{R}_0$](#example-1---sensitivity-of)

---

- When on a single machine, a *cluster* is a subset of the compute threads on the machine
- `R` uses the word *cores* even when referring to threads
- For example, if your laptop has 4 cores/8 threads, you can create a cluster with 2-8 "cores"
- Each core is a *worker*

---

# <!--fit-->Workers need information to work

This is probably the most confusing part about parallel computing (until you think about it)

Workers are *separated* `R` instances which receive their work orders from the main `R` instance (the *dispatcher*), so they must be given all the information needed to carry out the work

This needs to be done prior to the computation, as workers receive minimal information from the dispatcher at runtime...

---

- Needs package `parallel`
- Detect number of cores using `detectCores()`
- Initiate cluster with number of cores
- Make workers aware of info they need to work

---

<!-- _backgroundImage: "linear-gradient(to top, #156C26, 1%, black)" -->
# <!--fit-->Example 1 - Sensitivity of $\mathcal{R}_0$

---

# <!--fit-->Sensitivity of $\mathcal{R}_0$ to changes in parameters

We take the value of $\mathcal{R}_0$ in an SIR model with demography and proportional (standard) incidence
$$
\mathcal{R}_0 = \frac{\beta}{d+\gamma}
$$
We want to know how the value of $\mathcal{R}_0$ changes as a function of changes in the parameters $\beta,\gamma,d$

This is *sensitivity analysis* and will be covered in detail in another Vignette

---

We define the function whose value we want to compute

```R
R0 = function(p) {
  return(p$beta/(p$gamma+p$d))
}
```

---

# Create a wrapper function

We create a "wrapper" of the function `R0` that allows to change a subset of the values in `param` (for instance, we may want to change only $\beta$ and $\gamma$)

```R
one_run_R0 = function(p, param) {
  for (pp in names(p))
    param[[pp]] = p[[pp]]
  return(R0(param))
}
```

In more complex problems, this wrapper function is really important and can be much more evolved..

---

# Set up parameters

```R
param = list()
# Contact parameter
param$beta = 1e-6
# Average duration of infection
param$gamma = 1/4.5 
# Average lifetime
param$d = 1/(365.25*80)
```

---

# <!--fit-->Set up variations of the parameters

We use the `sensitivity` library to generate sample values of the parameters

```R
library(sensitivity)
nb_sims = 10000 # nb of simulations
param_vary = list()
for (i in 1:nb_sims) {
  param_vary[[i]] = list()
  param_vary[[i]]$beta = runif(1, min = 1e-9, max = 1e-4)
}
for (i in (nb_sims+1):(2*nb_sims)) {
  param_vary[[i]] = list()
  param_vary[[i]]$S0 = runif(1, min = 1000, max = 100000)
}
for (i in (2*nb_sims+1):(3*nb_sims)) {
  param_vary[[i]] = list()
  param_vary[[i]]$beta = runif(1, min = 1e-9, max = 1e-4)
  param_vary[[i]]$S0 = runif(1, min = 1000, max = 100000)
}
```

---

# Non-parallel version

```R
tictoc::tic()
result = lapply(X = param_vary,
                FUN = function(x) one_run_R0(x, param))
tictoc::toc()
```

---

# Parallel version

```R
# Detect number of cores, use all but 1
no_cores <- parallel::detectCores() - 1
# Initiate cluster
tictoc::tic()
cl <- parallel::makeCluster(no_cores)
# Export needed variables
parallel::clusterExport(cl,
              c("R0",
                "one_run_R0",
                "param"))
# Run computation
result = parallel::parLapply(cl = cl, X = param_vary,
                             fun =  function(x) one_run_R0(x, param))
# Stop cluster
parallel::stopCluster(cl)
tictoc::toc()
```

---

# Remember Amdahl's law ?

```R
nb_sims = 1000
sequential: 0.015 sec elapsed
parLapply: 0.096 sec elapsed
cluster: 1.125 sec elapsed

nb_sims = 10000
sequential: 0.093 sec elapsed
parLapply: 0.114 sec elapsed
cluster: 1.034 sec elapsed

nb_sims = 1e+05
sequential: 0.878 sec elapsed
parLapply: 0.506 sec elapsed
cluster: 1.416 sec elapsed

nb_sims = 1e+06
sequential: 15.807 sec elapsed
parLapply: 14.833 sec elapsed
cluster: 16.881 sec elapsed
```