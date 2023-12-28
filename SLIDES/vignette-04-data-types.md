---
marp: true
title: Vignette 04 - Data types and simple operations
description: Julien Arino - R for modellers - Vignette 04 - Data types and simple operations.
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
# Vignette 04<br>Data types and simple operations

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

- [Assignment](#assignment)
- [Lists](#lists)
- [Vectors](#vectors)
- [Matrices](#matrices)
- [Data frames](#data-frames)

---

# Assignment

Two ways:

```R
X <- 10
```

or

```R
X = 10
```

First version is preferred by R purists.. I don't really care

---

# Lists

A very useful data structure, quite flexible and versatile. Empty list: `L <- list()`. Convenient for things like parameters. For instance

```R
L <- list()
L$a <- 10
L$b <- 3
L[["another_name"]] <- "Plouf plouf"
> L[1]
$a
[1] 10
> L[[2]]
[1] 3
> L$a
[1] 10
> L[["b"]]
[1] 3
> L$another_name
[1] "Plouf plouf"
```

---

# Vectors

```R
> x = 1:10
> y <- c(x, 12)
> y
[1]  1  2  3  4  5  6  7  8  9 10 12
> z = c("red", "blue")
> z
[1] "red"  "blue"
z = c(z, 1)
> z
[1] "red"  "blue" "1"
```
Note that in `z`, since the first two entries are characters, the added entry is also a character. Contrary to lists, vectors have all entries of the same type

---

# Vector operations

Say you write `x=1:10`, i.e., make the vector
```R
> x
[1]  1  2  3  4  5  6  7  8  9 10
```
Then `x+1` gives
```R
> x+1
[1]  2  3  4  5  6  7  8  9 10 11
 ```
i.e., adds 1 to all entries in the vector

---

# <!--fit-->Use `seq` to make more complex sequences

```R
> x = seq(from = 2, to = 10, by = 1.25)
> x
[1] 2.00 3.25 4.50 5.75 7.00 8.25 9.50
> y = seq(from = 2, to = 100, length.out = 10)
> y
 [1]   2.00000  12.88889  23.77778  34.66667  45.55556  56.44444
 [7]  67.33333  78.22222  89.11111 100.00000
```

---

# Matrices

Matrix (or vector) of zeros
```R
A <- mat.or.vec(nr = 2, nc = 3)
```

Matrix with prescribed entries

```R
B <- matrix(c(1,2,3,4), nr = 2, nc = 2)
> B
     [,1] [,2]
[1,]    1    3
[2,]    2    4
C <- matrix(c(1,2,3,4), nr = 2, nc = 2, byrow = TRUE)
> C
     [,1] [,2]
[1,]    1    2
[2,]    3    4
```

Remark that here and elsewhere, naming the arguments (e.g., `nr = 2`) allows to use arguments in any order

---

# Matrix operations

Probably the biggest annoyance in R compared to other languages

- The notation `A*B` is the *Hadamard product* $A\circ B$ (what would be denoted `A.*B` in matlab), not the standard matrix multiplication
- Matrix multiplication is written `A %*% B`

---

# For the matlab-ers here

- R does not have the keyword `end` to access the last entry in a matrix/vector/list..
- Use `length` (lists or vectors), `nchar` (character chains), `dim` (matrices.. careful, of course returns 2 values)

---

# Data frames