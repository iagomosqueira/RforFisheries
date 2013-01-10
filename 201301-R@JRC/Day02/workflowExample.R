### My analysis

source("fun.R")
library(ggplot2)

ple4 <- read.csv("../Day01/ple4.csv")
apply(ple4, 2, cv)
pairs(ple4)






v1 <- rnorm(1200)
v2 <- rnorm(1200)
df <- data.frame(a=v1, b=v2)
apply(df, 2, cv)

