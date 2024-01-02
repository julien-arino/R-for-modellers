# Example code for Vignette 07
# parLapply and friends
# Sensitivity of R0
library(parallel)
library(sensitivity)

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

for (nb_sims in c(1000,10000,100000,1000000)) {
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
  rm(pars.sobol)
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
  tictoc::tic("cluster")
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
}