% The FLR platform for quantitative fisheries science
% Iago MOSQUEIRA
% March 2013


# Why?

Schnute *et al.* (2007 and 1998) compared the number of software tools
currently available for fisheries analysis to the Tower of Babel
and concluded that:

\begin{quotation}
"The cosmic plan for confounding
software languages seems to be working remarkably well among the
community of quantitative fishery scientists!"
\end{quotation}

# FLR


The FLR project provides a **platform for quantitative fisheries
science** based on the R statistical language.

The guiding principles of FLR are:

* **openness** - through community involvement and the open source ethos
* **flexibility** - through a design that does not constrain the user to a given paradigm
* **extendibility** - through the provision of tools that are ready to be personalized and adapted

# FLR mission

To **promote and generalize** the use of **good quality, open source,
flexible software** in all areas of quantitative fisheries research and
management advice, with a key focus on Management Strategies Evaluation.

# FLR goals

In detail, FLR aims to facilitate and promote research about:

- Stock assessment and provision of management advice
- Data and model validation through simulation
- Risk analysis
- Capacity development & education
- Promote collaboration and openness in quantitative fisheries science
- Support the development of new models and methods
- Promote the distribution of new models and methods to a wide public.

# FLR development

FLR is a **collaborative development project**, where distinct scientists that constitute *the FLR Core Team* work simultaneously on code, documentation, etc.

# Really, what is FLR?

- Extendable toolbox for implementing bio-economic simulation models of fishery systems
- Tools used by managers (hopefully) as well as scientists
- With many applications including:
    - Fit stock-recruitment relationships,
    - Model fleet dynamics (including economics),
    - Simulate and evaluate management procedures and HCRs,
    - More than just stock assessment (VPA, XSA, ICES uptake)
    - etc....
- A software platform for quantitative fisheries science
- A collection of R packages
- A team of devoted developers
- A community of active users



# Design principles

* 'Classes' to represent different elements of fisheries systems
* 'physical' objects (e.g. FLStock class represents a fish stock)
* ’methodological’ objects (e.g. FLBRP class containing methods to calculate BRP)
* Link objects to create simulations - Lego blocks (MSE example)
* Learning curve: trade off between flexibility and simplicity (no black boxes and no handle turning)

# Packages

\centering
\includegraphics[keepaspectratio, height=0.8\textheight]{graphics/scheme.png}

# MSE - The Lego block approach

\centering
\includegraphics[keepaspectratio, height=0.8\textheight]{graphics/MSE.png}

# Who’s using it ? (2009)
- ICES - 22+ stocks
- STECF - Several including MP & HCR studies
- AFMA - Northern Prawn Fishery
- CECAF - Istam project
- CCAMLR - Patagonian toothfish, Mackerel icefish
- GFCM - Deepwater pink shrimp, Hake in GSA 05
- ICCAT - Bluefin CITES evaluations, Swordfish, Albacore
- IOTC - Albacore, Skipjack, Bigeye, Yellowfin Tuna
- NEAFC - Blue Whiting, NOSS Herring
- NAFO - Greenland Halibut, American Plaice, Placentia Cod
- EC -  Evaluation of new CFP
- JRC - a4a Initiative

# Open All !!

- Open Science
- Open Data
- Open Source
- Reproducible research
- Open Mind !!

# More information

* FLR Project @ \url{http://flr-project.org}
* Source code @ \url{http://r-forge.r-project.org/projects/flr/}
* Repositories `install.packages(repos="http://flr-project.org/R")`
* Teach Yourself FLR wiki @ \url{http://tyflr.flr-project.org}

