#' ---
#' title: Short live demonstration of the `clustglm` package
#' author: Original documentation written by Louise McMillan from the VUW clustering group. Modified by FKCH.
#' date: Last modified July 2025
#' ---

rm(list = ls())
library(clustglm) # pak::pak("vuw-clustering/clustglm")
library(tidyverse)
library(ade4)
library(DHARMa)


##-----------------------
#' # Load and prepare data
##-----------------------
data("aviurba")

avi_resp <- aviurba$fau
sel_rare_spp <- which(colSums(avi_resp) < 5) #' Remove species with fewer than five records
 
avi_resp <- avi_resp[,-sel_rare_spp]
avi_traits <- aviurba$traits[-sel_rare_spp,] 


#' ## The function `mat2df` is used to create a long data frame including all the information. 
avi_dat <- mat2df(y = avi_resp,
                  xr.df = aviurba$mil,
                  xc.df = avi_traits,
                  responsename = "count",
                  factorname1 = "site", 
                  factorname2 = "species")
head(avi_dat)


##-----------------------
#' # Example 1: GLM with row and column standardization i.e., *no clustering*
#' The interaction terms introduced in later models will focus on pattern detection i.e., patterns of association between certain (types of) species and (types of) sites, after allowing for these main effects.
##-----------------------
fit_glm <- clustglm(formula = count ~ site + species,
                    family = "poisson",
                    data = avi_dat)

summary(fit_glm)


##-----------------------
#' # Example 2: Row pattern detection models
#' We define a new factor \code{siteclust} to represents the clustered sites; each level of this factor corresponds to a cluster and the number of clusters is fixed by \code{nclust}. The model formula contains an interaction term \code{siteclust:species}, which specifies that the site clustering is driven by the patterns of changing species compositions over the sites.
##-----------------------
fit_siteclust2 <- clustglm(formula = count ~ site + species + siteclust:species,
                           family = "poisson",
                           data = avi_dat,
                           fact4clust = "site",
                           clustfactnames = "siteclust",
                           nclust = 2,
                           start.control = list(randstarts = 5),
                           verbose = 1)

fit_siteclust3 <- clustglm(formula = count ~ site + species + siteclust:species,
                           family = "poisson",
                           data = avi_dat,
                           fact4clust = "site",
                           clustfactnames = "siteclust",
                           nclust = 3,
                           start.control = list(randstarts = 5),
                           verbose = 1)

# fit_siteclust4 <- clustglm(formula = count ~ site + species + siteclust:species,
#                            family = "poisson",
#                            data = avi_dat,
#                            fact4clust = "site",
#                            clustfactnames = "siteclust",
#                            nclust = 4,
#                            start.control = list(randstarts = 5),
#                            verbose = 1)


#' ## Compare the various using AICs/BICs, to choose the number of clusters, say.
comparison(list(fit_glm,
                fit_siteclust2, 
                fit_siteclust3
                # fit_siteclust4
                ))



#' ## Summaries and outputs of best model
summary(fit_siteclust2)

round(fit_siteclust2$pp.list$siteclust, 3) #' Posterior probabilities of site cluster membership
apply(fit_siteclust2$pp.list$siteclust, 1, which.max) #' Classifications of sites into clusters, with the highest posterior probability cluster being the classification for each site
get_classifications <- apply(fit_siteclust2$pp.list$siteclust, 1, which.max)

findpars(fit_siteclust2)



#' ## Profile plot shows how the estimated species profiles, giving an idea of which species occur more often or less often than expected across the profiles there.
profplot_fit_siteclust <- profileplot(model = fit_siteclust2,
                                      x.factor = "species",
                                      trace.factor = "siteclust",
                                      sort.x = 1,
                                      legend = TRUE)
round(profplot_fit_siteclust, 3)

avi_resp[get_classifications == 1, profplot_fit_siteclust %>% rownames()]


profplot_fit_siteclust <- profileplot(model = fit_siteclust2,
                                      x.factor = "species",
                                      trace.factor = "siteclust",
                                      sort.x = 2,
                                      legend = TRUE)
round(profplot_fit_siteclust, 3)

aviurba$fau[get_classifications == 2, profplot_fit_siteclust %>% rownames()]


simulateResiduals(fit_siteclust3$final.glm) %>% 
    plot



##-----------------------
#' # Example 3: Column pattern detection model
#' We define a new factor \code{speciesclust} to represents the clustered species; each level of this factor corresponds to a cluster and the number of clusters is fixed by \code{nclust}. The model formula contains an interaction term \code{site:speciesclust}, which specifies that the species clustering is driven by their distribution over the sites
##-----------------------
fit_speciesclust2 <- clustglm(formula = count ~ site + species + site:speciesclust,
                              family = "poisson", 
                              data = avi_dat,
                              fact4clust = "species", 
                              clustfactnames = "speciesclust",
                              nclust = 2,
                              start.control = list(randstarts = 5),
                              verbose = 1)

fit_speciesclust3 <- clustglm(formula = count ~ site + species + site:speciesclust,
                              family = "poisson", 
                              data = avi_dat,
                              fact4clust = "species", 
                              clustfactnames = "speciesclust",
                              nclust = 3,
                              start.control = list(randstarts = 5),
                              verbose = 1)

# fit_speciesclust4 <- clustglm(formula = count ~ site + species + site:speciesclust,
#                               family = "poisson", 
#                               data = avi_dat,
#                               fact4clust = "species", 
#                               clustfactnames = "speciesclust",
#                               nclust = 4,
#                               start.control = list(randstarts = 5),
#                               verbose = 1)

#' ## Compare the various using AICs/BICs, to choose the number of clusters, say.
comparison(list(fit_glm,
                fit_speciesclust2, 
                fit_speciesclust3
                # fit_speciesclust4
                ))


#' ## Summaries and outputs of best model
summary(fit_speciesclust2)
round(fit_speciesclust2$pp.list$speciesclust, 3) #' Posterior probabilities of species cluster membership
apply(fit_siteclust3$pp.list$siteclust, 1, which.max) #' Classifications of species into clusters, with the highest posterior probability cluster being the classification for each species
get_classifications <- apply(fit_speciesclust2$pp.list$speciesclust, 1, which.max) 



#' ## Profile plot shows how the estimated species guilds are defined if terms of their distributions/patterns across sites 
profplot_fit_speciesclus <- profileplot(model = fit_speciesclust2,
                                      x.factor = "site",
                                      trace.factor = "speciesclust",
                                      sort.x = 1,
                                      legend = TRUE)
round(profplot_fit_speciesclus, 3)

avi_resp[profplot_fit_speciesclus %>% rownames(), get_classifications == 1]


profplot_fit_speciesclus <- profileplot(model = fit_speciesclust2,
                                        x.factor = "site",
                                        trace.factor = "speciesclust",
                                        sort.x = 2,
                                        legend = TRUE)
round(profplot_fit_speciesclus, 3)

avi_resp[profplot_fit_speciesclus %>% rownames(), get_classifications == 2]



simulateResiduals(fit_speciesclust2$final.glm) %>% 
    plot



##-----------------------
## Example 4: Biclustering pattern detection model
#' Simultaneous clustering of sites and species. The [clustglm GitHub page](https://github.com/vuw-clustering/clustglm/blob/main/vignettes/clustglmTutorial.Rmd) has more information about getting for starting values for clustering models, which is particularly relevant for biclustering as results can be more sensitive here.
##-----------------------
fit_sitespeciesclust33 <- clustglm(formula = count ~ site + species + siteclust:speciesclust,
                                   family = "poisson",
                                   data = avi_dat,
                                   fact4clust = c("site","species"),
                                   clustfactnames = c("siteclust","speciesclust"),
                                   nclust = c(3, 3),
                                   start.control = list(randstarts = 5), 
                                   verbose = 1)


summary(fit_sitespeciesclust33)

profileplot(model = fit_sitespeciesclust33,
            x.factor = "speciesclust",
            trace.factor = "siteclust",
            sort.x = 1, 
            legend = TRUE)

findpars(fit_sitespeciesclust33)


comparison(list(fit_glm,
                fit_siteclust3, 
                fit_speciesclust2,
                fit_sitespeciesclust33))


avi_resp[apply(fit_sitespeciesclust33$pp.list$siteclust, 1, which.max) == 1, 
         apply(fit_sitespeciesclust33$pp.list$speciesclust, 1, which.max) == 2]
 
avi_resp[apply(fit_sitespeciesclust33$pp.list$siteclust, 1, which.max) == 2, 
         apply(fit_sitespeciesclust33$pp.list$speciesclust, 1, which.max) == 1]


#' See the [clustglm GitHub page](https://github.com/vuw-clustering/clustglm/blob/main/vignettes/clustglmTutorial.Rmd) for even info and other applications e.g., in capture-recapture models. But please note there are **lots of limitations!** to the current implementation.
#' Also note that the package provides an option from ordination. This was explored in [Hui et al., 2014](https://doi.org/10.1111/2041-210X.12236) but I strongly err against using clustering for model-based ordination in favor of GLLVMs!

