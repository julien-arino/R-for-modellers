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


## ----convert-Rnw-to-R,warning=FALSE,message=FALSE-----------------------------
# From https://stackoverflow.com/questions/36868287/purl-within-knit-duplicate-label-error
rmd_chunks_to_r_temp <- function(file){
  callr::r(function(file, temp){
    out_file = sprintf("../CODE/%s", gsub(".Rnw", ".R", file))
    knitr::purl(file, output = out_file, documentation = 1)
  }, args = list(file))
}
rmd_chunks_to_r_temp("basic-computational-analysis-2-simulations.Rnw")


## ----eval=FALSE---------------------------------------------------------------
## pp = ggplot(...)
## print(pp)

