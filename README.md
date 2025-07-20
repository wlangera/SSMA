# SSMA
This repository will soon contain content for the summer school in (model-based) multivariate analysis.

See https://bertv.folk.ntnu.no/index.html for more details.

## PROGRAM
**This is a preliminary program and thus subject to change**.

The days last from 09:00 to 17:00(ish), and a session after dinner. Each day will consist of a mix of lectures, in-class discussion, live demonstration, and interactive exercises / case studies.

## Monday (Background day)
* Welcome, logistics, and overview
* Some background of multivariate methods in ecology
* Generalised Linear Models and multispecies extensions
* Introduction to the gllvm R-package

## Tuesday (JSDMs day)
* Multispecies mixed effects Models
* Background of Joint Species Distribution Models
* Accommodating spatial or temporal autocorrelation
* Phylogenetic mixed models

## Wednesday (Ordination day)
* Background to ordination
* Accommodating nested study designs
* Bringing covariates into the ordination
* Unimodal/quadratic ordination 

## Thursday (Workflow/presentation day)
* GLLVMs from A-Z: application, results, inference
* Participant presentations (more details TBA, but will operate on a first-come basis) 
* Excursion
* (Re)analysing article Part I

## Friday ("What else is out there?" day)
* Concepts in model-based clustering
* Other packages for (model-based) multivariate analysis
* (Re)analysing article Part II & General Discussion
* Analysis of own data

# Detailed schedule
|   Day   |Time         |Subject                                                         |Lecturer|
|---------|-------------|:---------------------------------------------------------------|:-------|
|Monday   |<sub>09:00 - 09:30</sub>| Welcome, introduction, getting started              |Bert    |
|         |<sub>09:30 - 10:15</sub>| [Lecture: Modeling data from ecological communities](https://github.com/BertvanderVeen/SSMA/blob/main/Monday/CommunityData.pdf)           |        |
|         |<sub>10:15 - 10:45</sub>| ☕ Break                                             |        |
|         |<sub>10:45 - 11:15</sub>| Discussion: properties of community data            |        | <!-- short group-based disucssion (getting to know each other), also what they expect to be an issue/should be addressed -->
|         |<sub>11:15 - 12:00</sub>| [Lecture: Generalised Linear Models for multiple species](https://github.com/BertvanderVeen/SSMA/blob/main/Monday/GLMs.pdf)      |        | <!-- distributions and such-->
|         |<sub>12:00 - 13:00</sub>| 🍽 Lunch                                            |        |
|         |<sub>13:00 - 14:00</sub>| Practical 2: Fitting GLMs                           |        | <!--add VGLM to this practical-->
|         |<sub>14:00 - 14:45</sub>| [Lecture: Finding a good multispecies GLM](https://github.com/BertvanderVeen/SSMA/blob/main/Monday/ModelComparison.pdf)                     |        |<!-- what it means to have multiple species -->
|         |<sub>14:45 - 15:15</sub>| ☕ Break                                             |        |
|         |<sub>15:15 - 16:15</sub>| Practical 3: Comparing multispecies GLMs            |        | <!-- model selection, hypo testing ?-->
|         |<sub>16:15 - 17:00</sub>| Lecture: Introduction to the gllvm R-package                 |Bert/Pekka   |
|         |<sub>17:00 - 19:30</sub>| Free time + 🍽 Dinner                                        |        |
|         |<sub>19:30 - 20:30</sub>| Recap of the day                                    |Bert    |
|---------|-------------|----------------------------------------------------------------|--------|
|Tuesday  |<sub>09:00 - 09:45</sub>| Lecture: Multispecies mixed effects models                   |Jenni   |
|         |<sub>09:45 - 10:45</sub>| Practical 4: Fitting mixed-effects models           |        |
|         |<sub>10:45 - 11:15</sub>| ☕ Break                                             |        |
|         |<sub>11:15 - 12:00</sub>| Lecture: Joint Species Distribution Models (JSDMs)           |Pekka   |
|         |<sub>12:00 - 13:00</sub>| 🍽 Lunch                                            |        |
|         |<sub>13:00 - 14:00</sub>| Practical 5: Fitting JSDMs                          |        |
|         |<sub>14:00 - 14:45</sub>| Lecture: Accommodating spatial or temporal autocorrelation   |        |
|         |<sub>14:45 - 15:15</sub>| ☕ Break                                             |        |
|         |<sub>15:15 - 16:15</sub>| Practical 6: Spatial or temporal JSDMs              |        |
|         |<sub>16:15 - 17:00</sub>| [Lecture: Hierarchical environmental responses](https://github.com/BertvanderVeen/SSMA/blob/main/Tuesday/HierarchicalResponses.pdf)                |Bert    |
|         |<sub>17:00 - 19:30</sub>| Free time + 🍽 Dinner                                        |        |
|         |<sub>19:30 - 20:30</sub>| Practical 7: Traits and the phylogenetic model      |Bert    |
|---------|-------------|----------------------------------------------------------------|--------|
|Wednesday|<sub>09:00 - 09:45</sub>| [Lecture: Model-based ordination](https://github.com/BertvanderVeen/SSMA/blob/main/Wednesday/ModelbasedOrdination.pdf)                              |Bert    |
|         |<sub>09:45 - 10:45</sub>| Practical 8: Model-based unconstrained              |        |
|         |<sub>10:45 - 11:15</sub>| ☕ Break                                             |        |
|         |<sub>11:15 - 12:00</sub>| [Lecture: Bringing covariates into the ordination](https://github.com/BertvanderVeen/SSMA/blob/main/Wednesday/OrdWithPred.pdf)             |        |
|         |<sub>12:00 - 13:00</sub>| 🍽 Lunch                                            |        |
|         |<sub>13:00 - 14:00</sub>| Practical 9: Ordination with covariates             |        |
|         |<sub>14:00 - 14:45</sub>| [Lecture: Conditioning and nested designs](https://github.com/BertvanderVeen/SSMA/blob/main/Wednesday/Conditioning.pdf)                     |        |
|         |<sub>14:45 - 15:15</sub>| ☕ Break                                             |        |
|         |<sub>15:15 - 16:15</sub>| Practical 10: Partial ordination                    |        | <!-- bringing together 3 formula interfaces, and the ideas of partial, residual ordination, and accommodating nested designs -->
|         |<sub>16:15 - 17:00</sub>| [Lecture: Unimodal responses](https://github.com/BertvanderVeen/SSMA/blob/main/Wednesday/Unimodal.pdf)                                  |        |
|         |<sub>17:00 - 19:30</sub>| Free time + 🍽 Dinner                                        |        |
|         |<sub>19:30 - 20:30</sub>| Practical 11: Unimodal responses                    |Bert    |
|---------|-------------|----------------------------------------------------------------|--------|
|Thursday |<sub>09:00 - 09:45</sub>| [Lecture: GLLVMs from A-Z](https://github.com/BertvanderVeen/SSMA/blob/main/Thursday/analysis_A-Z/full_analysis.pdf)                                     |Audun   |
|         |<sub>09:45 - 12:30</sub>| 🎤 Participant presentations                        |        |
|         |<sub>12:30 - 13:15</sub>| 🍽 Lunch                                            |        |
|         |<sub>13:15 - 17:00</sub>| 🚶 Excursion                                        |        |
|         |<sub>17:00 - 19:30</sub>| Free time + 🍽 Dinner                                        |        |
|         |<sub>19:30 - 20:30</sub>| (Re)analysing article Part I                        |Bert/Audun|
|---------|-------------|----------------------------------------------------------------|--------|
|Friday   |<sub>08:45 - 09:00</sub>| Wrap-up                                             |Bert    |
|         |<sub>09:00 - 09:45</sub>| [Lecture: Concepts in model-based clustering](https://github.com/BertvanderVeen/SSMA/blob/main/Friday/modelbasedclustering.pdf)                  |Francis |
|         |<sub>09:45 - 10:30</sub>| [Lecture: Other packages for multivariate analysis](https://github.com/BertvanderVeen/SSMA/blob/main/Friday/otherPackages.pdf) |Bert  |
|         |<sub>10:30 - 11:30</sub>| Practical 12: Comparing ordinations                 |        |
|         |<sub>11:30 - 12:30</sub>| 🍽 Early lunch                                      |        |
|         |<sub>12:30 - 14:00</sub>| (Re)analysing article Part II / Discussion          |        |
|         |<sub>14:00 - 16:00</sub>| Analysis of own data                                |        |

# Packages to install
The latest stable version of all of these packages can be installed from CRAN courtesy of the `install.packages` function.
- gllvm
- mvabund
- DHARMa
- vegan
- labdsv
- ggplot2
- rnaturalearth
- rnaturalearthdata
- sf

<!-- auxiliary topics 
a) How to choose an ordination
b) Cross-validation and prediction
c) Similarity of JSDMs, ordination, and what we can learn from each other
d) Random canonical coefficients

-->
