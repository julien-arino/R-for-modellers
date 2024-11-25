## ----set-options,echo=FALSE,warning=FALSE,message=FALSE-----------------------
# Load required libraries
required_packages = c("dplyr", 
                      "ggplot2", 
                      "knitr", 
                      "latex2exp", 
                      "lhs", 
                      "RColorBrewer", 
                      "sensitivity", 
                      "tidyr")
for (p in required_packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p, dependencies = TRUE)
    require(p, character.only = TRUE)
  }
}
# Knitr options
opts_chunk$set(echo = TRUE, 
               warning = FALSE, 
               message = FALSE, 
               fig.width = 6, 
               fig.height = 4, 
               fig.path = "FIGS/comp-analysis-",
               fig.keep = "high",
               fig.show = "hide")


## ----set-slide-background,echo=FALSE,results='asis'---------------------------
# Are we plotting for a dark background?
plot_blackBG = FALSE
if (plot_blackBG) {
  bg_color = "black"
  fg_color = "white"
  input_setup = "\\input{slides-setup-blackBG.tex}"
} else {
  bg_color = "white"
  fg_color = "black"
  input_setup = "\\input{slides-setup-whiteBG.tex}"
}
cat(input_setup)


## ----echo=FALSE---------------------------------------------------------------
# Just to make sure RStudio highlights properly until the next code chunk


## ----R0-SLIAR-function--------------------------------------------------------
R0_SLIAR = function(p) {
  OUT = p$beta*(p$p/p$gamma+p$delta*(1-p$p)/p$eta)*p$S0
  return(OUT)
}


## ----R0-SLIAR-function-2------------------------------------------------------
R0_SLIAR_2 = function(p) {
  with(as.list(p), {
       OUT = beta*(p/gamma+delta*(1-p)/eta)*S0
       return(OUT)
  })
}


## ----parameters---------------------------------------------------------------
p = list()
p$kappa = 1/3 # incubation
p$p = 1/3 # fraction going to I vs A
p$beta = 1 # contact parameter
p$delta = 1/3 # infectivity differential A
p$gamma = 1/7 # recovery rate I
p$eta = 1/7 # recovery rate A
p$f = 0.5 # fraction symptomatic not dying
p$S0 = 999 # Initial S


## ----plot-R0-SLIAR-1----------------------------------------------------------
beta = seq(1e-5, 1e-1, by=1e-3)
R0_values = c()
for (i in 1:length(beta)) {
  p$beta = beta[i]
  R0_values = c(R0_values, R0_SLIAR(p))
}
plot(beta, R0_values, 
     type="l", xlab=expression(beta), ylab=expression(R[0]))


## ----beta-fct-R0-SLIAR--------------------------------------------------------
beta_SLIAR = function(R0, p) {
  return(R0/((p$p/p$gamma+p$delta*(1-p$p)/p$eta)*p$S0))
}


## ----plot-R0-SLIAR-2----------------------------------------------------------
p$beta = beta_SLIAR(R0=1.5, p)
gamma = seq(from=1/14, to=1, by=0.01)
R0_values = c()
for (i in 1:length(gamma)) {
  p$gamma = gamma[i]
  R0_values = c(R0_values, R0_SLIAR(p))
}
plot(gamma, R0_values, 
     type="l", xlab=expression(gamma), ylab=expression(R[0]),
     main = TeX("$R_0$ as a function of $\\gamma$"))
# Throw in a line at R0=1 for good measure
abline(h=1, col="red", lty = 3)


## ----plot-R0-SLIAR-3----------------------------------------------------------
inv_gamma = 1/gamma
plot(inv_gamma, R0_values, 
     type="l", 
     xlab=TeX("Average duration of the symptomatic infectious period (days)"), 
     ylab=expression(R[0]),
     main = TeX("$R_0$ as a function of $1/\\gamma$"))
abline(h=1, col="red", lty = 3)


## ----plot-R0-SLIAR-4----------------------------------------------------------
idx_switch = which(R0_values<=1)[1]
inv_gamma_switch = inv_gamma[idx_switch]
plot(inv_gamma, R0_values, 
     type="l", 
     xlab=TeX("Average duration of the symptomatic infectious period (days)"),
     ylab=expression(R[0]),
     main = TeX("$R_0$ as a function of $1/\\gamma$"))
points(x = inv_gamma_switch, y = 1, col = "darkred", pch = 16)
abline(h=1, col="red", lty = 3)


## -----------------------------------------------------------------------------
values = expand.grid(gamma = seq(1/14, 1, by=0.01), 
                     p = seq(0, 1, by = 0.01))
head(values)


## -----------------------------------------------------------------------------
R0_values = c()
for (i in 1:nrow(values)) {
  p$gamma = values$gamma[i]
  p$p = values$p[i]
  R0_values = c(R0_values, R0_SLIAR(p))
}
values$R0 = R0_values
head(values, 4)


## -----------------------------------------------------------------------------
R0_SLIAR_vect = function(p, v) {
  return(p$beta*(v$p/v$gamma + p$delta*(1-v$p)/p$eta)*p$S0)
}
values = expand.grid(gamma = seq(1/14, 1, by=0.01), 
                     p = seq(0, 1, by = 0.01))
values$R0 = R0_SLIAR_vect(p, values)
head(values, 4)


## ----plot-R0-SLIAR-fct-gamma-p-1----------------------------------------------
image(x = unique(values$gamma), y = unique(values$p), 
      z = matrix(values$R0, 
                 nrow = length(unique(values$gamma))),
      col = brewer.pal(9, "YlOrRd"),
      xlab = TeX("$\\gamma$"),
      ylab = TeX("$p$"),
      main = TeX("$R_0$ as a function of $\\gamma$ and $p$"))


## ----plot-R0-SLIAR-fct-gamma-p-2----------------------------------------------
R0_SLIAR_vect_inv_gamma = function(p, v) {
  return(p$beta*(v$p*v$inv_gamma + p$delta*(1-v$p)/p$eta)*p$S0)
}
values = expand.grid(inv_gamma = seq(1, 14, by=0.01), 
                     p = seq(0, 1, by = 0.01))
values$R0 = R0_SLIAR_vect_inv_gamma(p, values)
image(x = unique(values$inv_gamma), y = unique(values$p), 
      z = matrix(values$R0, 
                 nrow = length(unique(values$inv_gamma))),
      col = brewer.pal(9, "YlOrRd"),
      xlab = TeX("Average duration of the symptomatic infectious period (days)"),
      ylab = TeX("$p$"),
      main = TeX("$R_0$ as a function of $1/\\gamma$ and $p$"))


## ----plot-R0-SLIAR-fct-gamma-p-2-legend---------------------------------------
image(x = unique(values$inv_gamma), y = unique(values$p), 
      z = matrix(values$R0, 
                 nrow = length(unique(values$inv_gamma))),
      col = brewer.pal(9, "YlOrRd"),
      xlab = TeX("Average duration of the symptomatic infectious period (days)"),
      ylab = TeX("$p$"),
      main = TeX("$R_0$ as a function of $1/\\gamma$ and $p$"))
contour(x = unique(values$inv_gamma), y = unique(values$p), 
        z = matrix(values$R0, 
                   nrow = length(unique(values$inv_gamma))),
        levels = c(1), add = TRUE)


## ----plot-R0-SLIAR-fct-gamma-p-3----------------------------------------------
require(ggplot2)
ggplot(values, aes(x = inv_gamma, y = p, fill = R0)) + 
  geom_tile() + 
  scale_fill_viridis_c() +
  #scale_fill_gradientn(colours = brewer.pal(9, "YlOrRd")) +
  xlab("Average duration of the symptomatic infectious period (days)") +
  ylab(TeX("$p$")) +
  ggtitle(TeX("$R_0$ as a function of $1/\\gamma$ and $p$")) +
  theme_minimal()


## ----plot-R0-SLIAR-fct-gamma-p-5----------------------------------------------
contour(x = unique(values$inv_gamma), y = unique(values$p), 
        z = matrix(values$R0, 
                   nrow = length(unique(values$inv_gamma))),
        xlab = "Average duration of the symptomatic infectious period (days)",
        ylab = TeX("$p$"),
        main = TeX("$R_0$ as a function of $1/\\gamma$ and $p$"))


## ----plot-R0-SLIAR-fct-gamma-p-6----------------------------------------------
filled.contour(x = unique(values$inv_gamma), y = unique(values$p), 
        z = matrix(values$R0, 
                   nrow = length(unique(values$inv_gamma))),
        xlab = "Average duration of the symptomatic infectious period (days)",
        ylab = TeX("$p$"),
        main = TeX("$R_0$ as a function of $1/\\gamma$ and $p$"))


## -----------------------------------------------------------------------------
params = list()
params$N = 1000
params$I0 = 1
params$S0 = params$N-params$I0
params$R0 = c(0.5, 5)
params.vary = list(
  delta = c(0.05, 1), 
  p = c(0, 1), 
  gamma = c(1/10, 1/2), 
  eta = c(1/7,1))
params.vary$beta = 
  c(params.vary$gamma[1]*params$R0[1]/params$S0,
    params.vary$eta[2]*params$R0[2]/(params.vary$delta[2]*params$S0))


## ----graph2d-samples-function,echo=FALSE--------------------------------------
graph2d_samples <- function(M_sample, 
                            highlight = TRUE,
                            subdivs = NULL) {
  stopifnot(ncol(M_sample) == 2)
  sims <- nrow(M_sample)
  par(mar = c(4,4,2,2))
  plot.default(M_sample[,1], M_sample[,2], type = "n", ylim = c(0,1),
    xlim = c(0,1), xlab = "Parameter 1", ylab = "Parameter 2", 
    xaxs = "i",  yaxs = "i", main = "")
  if (highlight) {
    for (i in 1:nrow(M_sample)) {
    rect(floor(M_sample[i,1]*sims)/sims, floor(M_sample[i,2]*sims)/sims,
         ceiling(M_sample[i,1]*sims)/sims, ceiling(M_sample[i,2]*sims)/sims, 
         col = "grey")
    }
  }
  points(M_sample[,1], M_sample[,2], pch = 19, col = "red")
  if (is.null(subdivs)) {
    abline(v = (0:sims)/sims, h = (0:sims)/sims)
  } else {
    abline(v = (0:subdivs[1])/subdivs[1], h = (0:subdivs[2])/subdivs[2])
  }
}


## ----grid-sampling-2d-example,echo=FALSE,fig.height=3.3,fig.width=6,fig.show='asis'----
A <- expand.grid(p1 = seq(0, 1, length.out = 5), 
                 p2 = seq(0, 1, length.out = 4))
graph2d_samples(A, highlight = FALSE, subdivs = c(4,3))


## -----------------------------------------------------------------------------
nb_points_per_param = 10
params.grid = expand_grid(
  delta = seq(params.vary$delta[1], 
              params.vary$delta[2], 
              length.out = nb_points_per_param),
  p = seq(params.vary$p[1], params.vary$p[2], length.out = nb_points_per_param),
  gamma = seq(params.vary$gamma[1], params.vary$gamma[2], length.out = nb_points_per_param),
  eta = seq(params.vary$eta[1], params.vary$eta[2], length.out = nb_points_per_param),
  beta = seq(params.vary$beta[1], params.vary$beta[2], length.out = nb_points_per_param))


## ----sensi-R0-SLIAR-grid------------------------------------------------------
R0_SLIAR = function(p, p_fixed) {
  OUT = p$beta*(p$p/p$gamma+p$delta*(1-p$p)/p$eta)*p_fixed$S0
  return(OUT)
}
R0_values = R0_SLIAR(params.grid, params)


## ----compute-PRCC-R0-SLIAR-grid-----------------------------------------------
compute_PRCC = function(v, pars) {
  x = pcc(pars, as.numeric(v),
          rank = TRUE, semi = FALSE)
  return(x)
}
R0_SLIAR_PRCC_grid = compute_PRCC(R0_values, params.grid)


## -----------------------------------------------------------------------------
R0_SLIAR_PRCC_grid


## ----plot-PRCC-R0-SLIAR-grid-base---------------------------------------------
idx = order(abs(R0_SLIAR_PRCC_grid$PRCC$original), 
            decreasing = TRUE)
plot(R0_SLIAR_PRCC_grid$PRCC$original[idx], 
     ylim = c(-1,1), xaxt='n',
     xlab = "Parameter", ylab = "PRCC",
     main = TeX("PRCC for $R_0$ - parameters sampled using a grid"),
     pch = 19, col = "blue", cex = 2)
axis(1, at = 1:length(idx), 
     labels = rownames(R0_SLIAR_PRCC_grid$PRCC)[idx])
abline(h=0, lty = 3)


## ----plot-PRCC-R0-SLIAR-grid-2------------------------------------------------
colour = viridis::viridis(length(idx))
labels =  sprintf("$\\%s$", rownames(R0_SLIAR_PRCC_grid$PRCC)[idx])
labels = gsub("\\\\p", "p", labels)
plot(R0_SLIAR_PRCC_grid$PRCC$original[idx], 
     ylim = c(-1,1), xaxt='n', pch = 19, 
     xlab = "Parameter", ylab = "PRCC",
     col = colour, 
     main = TeX("PRCC for $R_0$ - parameters sampled using a grid"),
     cex = 3 * abs(R0_SLIAR_PRCC_grid$PRCC$original)[idx])
axis(1, at = 1:length(idx), labels = TeX(labels))
abline(h=0, lty = 3)


## ----plot-PRCC-R0-SLIAR-grid-ggplot2------------------------------------------
df = data.frame(Parameter = rownames(R0_SLIAR_PRCC_grid$PRCC)[idx],
                PRCC = R0_SLIAR_PRCC_grid$PRCC$original[idx])
ggplot(df, aes(x = Parameter, y = PRCC)) +
  geom_point(colour = "blue", size = 3) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_minimal()


## -----------------------------------------------------------------------------
nb_samples = 1000000
length_grid_side = floor(nb_samples^(1/5))
params.grid = parameterSets(par.ranges = params.vary,
                             samples = rep(length_grid_side, 5),
                             method = "grid")
params.grid = as.data.frame(params.grid)
colnames(params.grid) = names(params.vary)
R0_values = R0_SLIAR(params.grid, params)
R0_SLIAR_PRCC_grid_2 = compute_PRCC(R0_values, params.grid)


## ----sobol-sampling-2d-example,echo=FALSE,fig.height=3.3,fig.width=6,fig.show='asis'----
A <- parameterSets(par.ranges = list(p1 = c(0, 1), 
                                     p2 = c(0, 1)),
                   samples = 20,
                   method = "sobol")
graph2d_samples(A, highlight = FALSE, subdivs = c(10,10))


## ----echo=TRUE----------------------------------------------------------------
nb_samples = 100000
params.sobol = parameterSets(par.ranges = params.vary,
                             samples = nb_samples,
                             method = "sobol")
params.sobol = as.data.frame(params.sobol)
colnames(params.sobol) = names(params.vary)


## ----compute-R0-values-sensi-SLIAR-Sobol--------------------------------------
R0_values = R0_SLIAR(params.sobol, params)
compute_PRCC = function(v, pars) {
  x = pcc(pars, as.numeric(v),
          rank = TRUE, semi = FALSE)
  return(x)
}
R0_SLIAR_PRCC_sobol = compute_PRCC(R0_values, params.sobol)


## -----------------------------------------------------------------------------
R0_SLIAR_PRCC_sobol


## ----plot-PRCC-R0-SLIAR-2-----------------------------------------------------
idx = order(abs(R0_SLIAR_PRCC_sobol$PRCC$original),
            decreasing = TRUE)
colour = viridis::viridis(length(idx))
labels =  sprintf("$\\%s$", rownames(R0_SLIAR_PRCC_sobol$PRCC)[idx])
labels = gsub("\\\\p", "p", labels)
plot(R0_SLIAR_PRCC_sobol$PRCC$original[idx], 
     ylim = c(-1,1), xaxt='n', pch = 19, 
     xlab = "Parameter", ylab = "PRCC",
     col = colour,
     main = TeX("PRCC for $R_0$ - parameters sampled using Sobol"),
     cex = 3 * abs(R0_SLIAR_PRCC_sobol$PRCC$original)[idx])
axis(1, at = 1:length(idx), labels = TeX(labels))
abline(h=0, lty = 3)


## ----plot-PRCC-R0-SLIAR-ggplot2-----------------------------------------------
df = data.frame(Parameter = rownames(R0_SLIAR_PRCC_sobol$PRCC)[idx],
                PRCC = R0_SLIAR_PRCC_sobol$PRCC$original[idx])
ggplot(df, aes(x = Parameter, y = PRCC)) +
  geom_point(colour = "blue", size = 3) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_minimal()


## ----lhs-sampling-2d-example,echo=FALSE,fig.height=3.3,fig.width=6,fig.show='asis'----
A <- randomLHS(20, 2)
graph2d_samples(A)


## ----echo=TRUE----------------------------------------------------------------
params.lhs = lhs::randomLHS(nb_samples, length(params.vary))
params.lhs = as.data.frame(params.lhs)
colnames(params.lhs) = names(params.vary)
head(params.lhs)


## -----------------------------------------------------------------------------
for (c in 1:length(params.vary)) {
  params.lhs[,c] = params.vary[[c]][1] + params.lhs[,c] * 
    (params.vary[[c]][2] - params.vary[[c]][1])
}
R0_values = R0_SLIAR(params.lhs, params)
R0_SLIAR_PRCC_lhs = compute_PRCC(R0_values, params.lhs)


## ----plot-PRCC-R0-SLIAR-lhs---------------------------------------------------
idx = order(abs(R0_SLIAR_PRCC_lhs$PRCC$original),
            decreasing = TRUE)
colour = viridis::viridis(length(idx))
labels =  sprintf("$\\%s$", rownames(R0_SLIAR_PRCC_lhs$PRCC)[idx])
labels = gsub("\\\\p", "p", labels)
plot(R0_SLIAR_PRCC_lhs$PRCC$original[idx], 
     ylim = c(-1,1), xaxt='n', pch = 19, 
     xlab = "Parameter", ylab = "PRCC",
     main = TeX("PRCC for $R_0$ with parameters sampled using LHS"),
     col = colour, 
     cex = 3 * abs(R0_SLIAR_PRCC_lhs$PRCC$original)[idx])
axis(1, at = 1:length(idx), labels = TeX(labels))
abline(h=0, lty = 3)


## ----results='asis'-----------------------------------------------------------
R0_SLIAR_PRCC = cbind(R0_SLIAR_PRCC_grid$PRCC$original,
                R0_SLIAR_PRCC_grid_2$PRCC$original,
                R0_SLIAR_PRCC_sobol$PRCC$original,
                R0_SLIAR_PRCC_lhs$PRCC$original)
rownames(R0_SLIAR_PRCC) = rownames(R0_SLIAR_PRCC_grid$PRCC)
colnames(R0_SLIAR_PRCC) = c("Grid 1", "Grid 2", "Sobol", "LHS")
knitr::kable(R0_SLIAR_PRCC, digits = 3, booktabs = TRUE)


## ----split-sobol-as-list------------------------------------------------------
params.sobol.list = split(params.sobol, seq(nrow(params.sobol)))
head(params.sobol.list, n = 2)


## -----------------------------------------------------------------------------
R0_values = lapply(X = params.sobol.list, 
                   FUN = function(x) R0_SLIAR(x, params))
head(R0_values, n = 2)


## -----------------------------------------------------------------------------
nb_cores <- parallel::detectCores() - 1
nb_cores <- ifelse(nb_cores > 122, 122, nb_cores)
tictoc::tic("whole parallel phase")
cl <- parallel::makeCluster(nb_cores)
parallel::clusterExport(cl, c("params", "R0_SLIAR"))
tictoc::tic("parLapply")
result = parallel::parLapply(cl = cl, X = params.sobol.list,
                             fun =  function(x) R0_SLIAR(x, params))
tictoc::toc()
parallel::stopCluster(cl)
tictoc::toc()


## -----------------------------------------------------------------------------
tictoc::tic("lapply")
result = lapply(X = params.sobol.list,
                FUN =  function(x) R0_SLIAR(x, params))
tictoc::toc()
tictoc::tic("vectorised")
result = R0_SLIAR(params.sobol, params)
tictoc::toc()


## ----convert-Rnw-to-R,warning=FALSE,message=FALSE-----------------------------
# From https://stackoverflow.com/questions/36868287/purl-within-knit-duplicate-label-error
rmd_chunks_to_r_temp <- function(file){
  callr::r(function(file, temp){
    out_file = sprintf("CODE/%s", gsub(".Rnw", ".R", file))
    knitr::purl(file, output = out_file, documentation = 1)
  }, args = list(file))
}
rmd_chunks_to_r_temp("basic-computational-analysis.Rnw")


## ----eval=FALSE---------------------------------------------------------------
## pp = ggplot(...)
## print(pp)

