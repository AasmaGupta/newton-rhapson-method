# Newton-Raphson Method (Animint2)

This is an interactive visualization of the Newton-Raphson method built using the `animint2` package in R.

I recreated this from the animation package examples, but instead of static frames, this version lets you actually interact with the iterations.

---

## What this shows

The Newton-Raphson method is used to find roots of a function using the update:

xₙ₊₁ = xₙ - f(xₙ) / f'(xₙ)

In the visualization:

- The black curve is the function
- The red lines show the tangent at each step
- Vertical and diagonal moves show how the method jumps toward the root
- Points show the sequence of guesses
- The right plot shows how |f(x)| decreases over iterations (log scale)
- The current root estimate updates dynamically

---

## Why I made this

The original animation examples are static (frame-by-frame).  
I wanted to:

- make it interactive    
- show iteration behavior more clearly  

---

## Features

- Click on points to jump to a specific iteration  
- Animation over iterations  
- Linked plots (main graph + convergence)  
- Dynamic root value display  
- Works entirely as a static web page (no server)

---

## Tech used

- R
- ggplot2
- animint2

---

## Live demo

https://aasmagupta.github.io/newton-rhapson-method/

---

## Run locally

```r
install.packages("animint2")

source("medium.r")
