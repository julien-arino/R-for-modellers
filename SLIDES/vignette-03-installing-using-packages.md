---
marp: true
title: Vignette 03 - Installing  and loading packages
description: Julien Arino - R for modellers - Vignette 03 - Installing and loading packages.
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
# Vignette 03<br>Installing and loading packages

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

# <!--fit-->Note - Required reading/watching for MATH 2740 students

If you are a student in the University of Manitoba's Mathematics of Data Science course (MATH 2740), this is **required** reading & watching

Failure to use the ["friendly" method](#sec:friendly) will result in loss of marks in your `R` assignments!

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
# Outline

- [Packages (a.k.a. libraries)](#sec:packages)
- [Installing a package](#sec:installing)
- [Loading a package](#sec:loading)
- [Be friendly to others!](#sec:friendly)
- [Updating packages](#sec:updating)

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:packages"></a>
# <!--fit-->Packages (a.k.a. libraries)

---

*Packages* (or *libraries*) extend `R` by providing functions or data that is useful in particular contexts

Packages allow to avoid "bloating", since the `R` core remains relatively light and you only install the additional content you need

---

# <!--fit-->CRAN is the main source for packages

```R
> paste(nrow(available.packages()),
+       "packages on CRAN on",
+       Sys.Date())
[1] "20240 packages on CRAN on 2023-12-27"
```

---

# <!--fit-->There are also packages not on CRAN

- For instance, packages on GitHub
- Sometimes packages get removed from CRAN, although the latest versions are typically still available
- Installation is a little different (detailed later)

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:installing"></a>
# <!--fit-->Installing a package

---

# From CRAN

Use the command `install.packages()`

---

# From GitHub

Some packages are only on GitHub; others have their latest (testing) version on GitHub and a stable version on CRAN

Need to use the `devtools` or `remotes` packages (maybe prefer `devtools`)

You can also use the package [githubinstall](https://cran.r-project.org/web/packages/githubinstall/vignettes/githubinstall.html)

---

```R
> library(githubinstall)
> githubinstall("xkcd")
Select a number or, hit 0 to cancel. 

1: DanHenebery/Rxkcd  
2: EDiLD/xkcd2        

Selection: 2
Suggestion:
 - EDiLD/xkcd2  NA
Do you want to install the package (Y/n)?  
Downloading GitHub repo EDiLD/xkcd2@master
```

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:loading"></a>
# <!--fit-->Loading a package

---

# Loading a package

Once a package is installed, you load it with the command `library()`

No need to use quotation marks: `library(ggplot2)`

---

# Loading several packages

To load several packages with a single command, you need to use a loop and the option `character.only = TRUE`

```R
required_packages = c("ggplot2", "dplyr")
for (p in required_packages) {
  library(p, character.only = TRUE)
}
```

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:friendly"></a>
# <!--fit-->Be friendly to others!

---

# <!--fit-->When distributing your code, think of those using it

If you are using a slightly unusual library, it is possible that a person you share your code with does not have that library installed

In this case, it is nice to them if you spare them having to do the work to install the library

But it is also possible that they already have the library

In this case, it will be annoying to them if you trigger an installation of the library (especially under linux, since there libraries are compiled for installation)

---

So the way to proceed is to **test** whether the library is installed

- If it is, load it
- If it is not, install it then load it

```R
if (!require(package_name)) {
    install.packages("package_name")
    library(package_name)
}
```
> `require` is designed for use inside other functions; it returns `FALSE` and gives a warning (rather than an error as `library()` does by default) if the package does not exist.

---

# Example using several libraries

```R
required_packages = c("ggplot2", "dplyr")
for (p in required_packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
    library(p, character.only = TRUE)
  }
}
```

---

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, black)" -->
<a id="sec:updating"></a>
# <!--fit-->Updating packages

---

# Using RStudio

---

# From the R command line

```R
update.packages(ask = FALSE, checkBuilt = TRUE, Ncpus = 6)
```

- `ask = FALSE`: do not ask for confirmation
- `checkBuilt = TRUE`: check with which version of `R` the package was built and call package *old* if this is a earlier major version (e.g., built with 4.2 when the current is 4.3)
- `Ncpus = 6`: run compilations (if needed) using that many threads

---

# Packages and `R` major versions

Packages are stored by default in your home folder under the current major version of `R` (currently 4.3)

```
~/R/x86_64-pc-linux-gnu-library/4.3/
```

When the major version changes, you therefore need to do something with all your current packages..

There is no planned mechanisms for doing this

Easiest: export list of libraries in the previous version, then install all of them

---

Set `lib` to be previous R version, say, 4.2:

```R
lib = "/home/jarino/x86_64-pc-linux-gnu-library/4.2"
```

then get list of packages

```R
installed_packages = as.data.frame(installed.packages(lib))$Package
```
