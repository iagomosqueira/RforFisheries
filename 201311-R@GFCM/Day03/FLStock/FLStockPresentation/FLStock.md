% The FLStock class
%
% November 2013

# FLStock

A class that represents the population dynamics of a fish stock.

Contains:

* Fisheries information:
    * Catches, landings, discards (numbers, weights)
    * Fishing mortality
* Biological information:
    * Stock abundance (numbers, weights)
    * Natural mortality (m)
    * Maturity


# What is it?

A **composite** object - a class made up of other classes

An **FLStock** is made up of **FLQuant** objects

\includegraphics[keepaspectratio, height=0.5\textheight]{graphics/FLStock_composite.png}

# Slots

All FLQuant slots are the same size

17 of them

* **catch**, **catch.n**, **catch.wt**
* **landings**, **landings.n**, **landings.wt**
* **discards**, **discards.n**, **discards.wt**
* **stock**, **stock.n**, **stock.wt**
* **m**, **mat**, **harvest**
* **harvest.spwn**, **m.spwn** 




