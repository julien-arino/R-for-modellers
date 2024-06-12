# Example simulation of a simple SIS model
library(GillespieSSA2)

# Source a file with a few helpful functions for plotting (nice axes labels, crop figure)
source("useful_functions.R")

# Total population
Pop = 100
# Initial number of infectious
I_0 = 1
# Parameters
gamma = 1/5
# R0 would be (beta/gamma)*S0, so beta=R0*gamma/S0
beta = 1.5*gamma/(Pop-I_0)
# Final time
t_f = 100



IC <- c(S = (Pop-I_0), I = I_0)
params <- c(gamma = gamma, beta = beta)
reactions <- list(
  # propensity function effects name for reaction
  reaction("beta*S*I", c(S=-1,I=+1), "new_infection"),
  reaction("gamma*I", c(S=+1,I=-1), "recovery")
)
set.seed(NULL)
sol <- ssa(
    initial_state = IC,
    reactions = reactions,
    params = params,
    method = ssa_exact(),
    final_time = t_f,
    log_firings = TRUE
)

# Prepare y-axis for human readable form
y_axis = make_y_axis(c(0, max(sol$state[,"I"])))

# Are we plotting for a dark background
plot_blackBG = TRUE
if (plot_blackBG) {
  colour = "white"
} else {
  colour = "black"
}

png(file = "../FIGS/one_CTMC_sim.png",
    width = 1200, height = 800, res = 200)
if (plot_blackBG) {
  par(bg = 'black', fg = 'white') # set background to black, foreground white
}
plot(sol$time, sol$state[,"I"],
     type = "l",
     col.axis = colour, cex.axis = 1.25,
     col.lab = colour, cex.lab = 1.1,
     yaxt = "n",
     xlab = "Time (days)", ylab = "Prevalence")
axis(2, at = y_axis$ticks, labels = y_axis$labels, 
     las = 1,
     col.axis = colour,
     cex.axis = 0.75)
dev.off()
crop_figure(file = "../FIGS/one_CTMC_sim.png")


nb_sims = 50
sol = list()
tictoc::tic()
for (i in 1:nb_sims) {
  writeLines(paste("Start simulation", i))
  set.seed(NULL)
  sol[[i]] <-
    ssa(
      initial_state = IC,
      reactions = reactions,
      params = params,
      method = ssa_exact(),
      final_time = t_f,
    )
}
tictoc::toc()

# Determine maximum value of I for plot
I_max = max(unlist(lapply(sol, function(x) max(x$state[,"I"], na.rm = TRUE))))
# Prepare y-axis for human readable form
y_axis = make_y_axis(c(0, I_max))

# We want to show trajectories that go to zero differently from those that go endemic,
# so we do a bit of preprocessing, adding a colour field each solution
for (i in 1:nb_sims) {
  idx_last_I = dim(sol[[i]]$state)[1]
  val_last_I = as.numeric(sol[[i]]$state[idx_last_I,"I"])
  if (val_last_I == 0) {
    sol[[i]]$colour = "dodgerblue4"
    sol[[i]]$lwd = 1
  } else {
    sol[[i]]$colour = ifelse(plot_blackBG, "white", "black")
    sol[[i]]$lwd = 0.5
  }
}

# Now do the plot
png(file = "../FIGS/several_CTMC_sims.png",
    width = 1200, height = 800, res = 200)
if (plot_blackBG) {
  par(bg = 'black', fg = 'white') # set background to black, foreground white
}
plot(sol[[1]]$time, sol[[1]]$state[,"I"]*y_axis$factor,
     xlab = "Time (days)", ylab = "Prevalence",
     type = "l",
     xlim = c(0, t_f), ylim = c(0, I_max), 
     col.axis = colour, cex.axis = 1.25,
     col.lab = colour, cex.lab = 1.1,
     yaxt = "n",
     col = sol[[1]]$colour, lwd = sol[[1]]$lwd)
for (i in 2:nb_sims) {
  lines(sol[[i]]$time, sol[[i]]$state[,"I"]*y_axis$factor,
        type = "l",
        col = sol[[i]]$colour, lwd = sol[[i]]$lwd)
}
axis(2, at = y_axis$ticks, labels = y_axis$labels, 
     las = 1,
     col.axis = colour,
     cex.axis = 0.75)
dev.off()
crop_figure("../FIGS/several_CTMC_sims.png")


