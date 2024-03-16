# Example code for Vignette 07
# parLapply and friends
# Sensitivity of R0
library(parallel)
library(sensitivity)
library(latex2exp)
library(ggplot2)

R0 = function(p) {
  return(p$beta/(p$gamma+p$d))
}

one_run_R0 = function(p) {
  return(R0(p))
}

pars.list = list(
  beta = c(0.001, 0.5),
  gamma = c(1/10, 1/2),
  d = c(1/(100*365.25), 1/(20*365.25)))

for (nb_sims in c(100, 1000, 10000)) {
  writeLines(paste0("nb_sims = ", nb_sims))
  tictoc::tic("Sample generation")
  pars.sobol = parameterSets(par.ranges = pars.list, 
                             samples = nb_sims, 
                             method = "sobol")
  pars.sobol = as.data.frame(pars.sobol)
  colnames(pars.sobol) = names(pars.list)
  # For parLapply, we need to make a list of lists
  pars.sobol.list = split(pars.sobol, seq(nrow(pars.sobol)))
  # Clean up (can be costly in memory)
  # rm(pars.sobol)
  tictoc::toc()
  
  # Sequential version
  tictoc::tic("sequential")
  result = lapply(X = pars.sobol.list,
                  FUN = one_run_R0)
  tictoc::toc()
  
  # Parallel version
  # Detect number of cores, use all but 1
  no_cores <- parallel::detectCores() - 1
  # Initiate cluster
  tictoc::tic("whole parallel phase")
  cl <- makeCluster(no_cores)
  # Export needed variables
  clusterExport(cl,
                c("R0",
                  "one_run_R0"))
  # Run computation
  tictoc::tic("parLapply")
  result = parLapply(cl = cl, X = pars.sobol.list,
                     fun =  one_run_R0)
  tictoc::toc()
  # Stop cluster
  stopCluster(cl)
  tictoc::toc()
  writeLines("")
  
  # To compute partial rank correlation coefficients (PRCC),
  # we need to make a vector of the results
  result = data.frame(value = unlist(result))
  # Now compute 
  # (using the parallel results) and plot
  R0_changes = pcc(pars.sobol, result,
               rank = TRUE, semi = FALSE)
  # Labels for the plots
  x_labels = c(TeX("$\\beta$"), 
               TeX("$\\gamma$"), 
               TeX("$d$"))
  #PRCC_values = reshape2::melt(R0_changes, id.vars = "names")
  ggplot(data = R0_changes) + #, 
         #aes(names, value, col = variable)) + 
    xlab("Parameter") +
    ylab("Partial rank correlation coefficients") +
    ylim(-1,1) +
    scale_color_discrete(labels = c(TeX("$V_{max}$"), 
                                    TeX("$F_{U_{max}}$"), 
                                    TeX("$F_{B_{max}}$"))) +
    theme_minimal() 
  ggsave(filename = "FIGS/sensitivities-PRCC-values.png",
         width = 20, height = 15, units = "cm")
}

library(extrafont)
library(ggplot2)
if( 'xkcd' %in% fonts()) {
  p <- ggplot() + geom_point(aes(x=mpg, y=wt), data=mtcars) +
    theme(text = element_text(size = 16, family = "xkcd"))
} else {
  warning("Not xkcd fonts installed!")
  p <- ggplot() + geom_point(aes(x=mpg, y=wt), data=mtcars)
}
p

download.file("http://simonsoftware.se/other/xkcd.ttf",
              dest="xkcd.ttf", mode="wb")
system("mkdir ~/.fonts")
system("cp xkcd.ttf ~/.fonts")
font_import(pattern = "[X/x]kcd", prompt=FALSE)
fonts()
fonttable()
if(.Platform$OS.type != "unix") {
  ## Register fonts for Windows bitmap output
  loadfonts(device="win")
} else {
  loadfonts()
}
