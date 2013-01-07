# T01_R_Expressions.R - Getting to know the R language
# Day01/T01_Expressions.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science



# EXPRESSIONS

# First operations

# Assignment

# To create objects in our workspace, use <- (alternatively, =)

oa <- 4

ob = 5

# Type its name to inspect, same as show()

ob

show(ob)

# Calling functions, always use ()

length(ob)

log(oa)

exp(ob)

sqrt(oa*ob)

# Arithmetic

ob + ob

ob + 10

oa * 2

ob ^ oa

# Nesting operations

log(((ob + 2) * (oa / 3)) ^ 2)

# Comparison

ob > oa

ob <= oa

# List variables in workspace

ls()


# GETTING HELP

# Each command (or class/method) in R has a help page

help(log)

?log

# Example code can also be extracted

example(log)

# Open html help in browser

help.start()

# Return all functions swhose name contains a string
# e.g. return all functions that have "log" in name

apropos("log")
??log

# Search all workspace and loaded packages
search()

# To get syntax of function call
args(log)

# study demos within R 
demo(graphics)


# ONLINE RESOURCES

# WEBSITES

# CRAN
# http://cran.r-project.org

# R FAQ
# http://cran.r-project.org/doc/FAQ/R-FAQ.html

# Windows R FAQ
# http://cran.r-project.org/bin/windows/base/rw-FAQ.html

# http://www.rseek.org

# Mailing lists
# R Help
# R Devel

# example post & discussion
# https://stat.ethz.ch/pipermail/r-help/2006-May/thread.html#106031

# R Journal
# http://journal.r-project.org/

# Useful source of R inspiration
# http://www.r-bloggers.com/
