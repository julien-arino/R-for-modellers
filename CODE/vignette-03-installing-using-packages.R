# Example code for Vignette 3: Installing and Using Packages

paste(nrow(available.packages()),
      "packages on CRAN on",
      Sys.Date())

# Load several libraries
required_packages = c("ggplot2", "dplyr")
for (p in required_packages) {
  library(p, character.only = TRUE)
}

# Friendly way of loading libraries: if present, load, if not, 
# install and load
required_packages = c("ggplot2", "dplyr")
for (p in required_packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
    library(p, character.only = TRUE)
  }
}


update.packages(ask = FALSE, checkBuilt = TRUE, Ncpus = 6)

# From https://www.r-bloggers.com/2014/11/update-all-user-installed-r-packages-again/
install.packages( 
  lib  = lib <- .libPaths()[1],
  pkgs = as.data.frame(installed.packages(lib), 
                       stringsAsFactors = FALSE)$Package,
  type = 'source'
)
