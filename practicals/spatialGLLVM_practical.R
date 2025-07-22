# Load in the packages and the dataset

library(gllvm)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(Matrix)

set.seed(9725)
load("../data/reeffish.Rdata")
head(yreef, c(6,6))
head(Xreef)
head(dcoords)

##### INTRO
## Visualize the locations and years:
world <- ne_countries(scale = "medium", returnclass = "sf")
# limits for plot
lon_min <- min(dcoords[,"lon"])-3
lon_max <- max(dcoords[,"lon"])+2
lat_min <- min(dcoords[,"lat"])-3
lat_max <- max(dcoords[,"lat"])+1

map <- ggplot(data = world) +
  geom_sf() +
  coord_sf(xlim = c(lon_min, lon_max), ylim = c(lat_min, lat_max), expand = FALSE) +
  theme_minimal()

cxyt<-data.frame(lon=jitter(Xreef$Start_Longitude, amount = 0.1), 
                 lat = jitter(Xreef$Start_Latitude, amount = 0.1), year=Xreef$Year)
samples <- cxyt
map +
  geom_point(data = samples, aes(x = lon, y = lat), color = as.numeric(cxyt$year), size = 1) +
  labs(title = "Southeastern U.S.", x = "Longitude", y = "Latitude")

# Fit a simple negative binomial model without LVs or row effects:
Xform = ~ Start_Depth + C.Substrate
fit0 <- gllvm(yreef, Xreef, formula = Xform, family = "negative.binomial", num.lv = 0)
par(mfrow=c(2,3))
plot(fit0)

##### Row-effects with temporal correlation:
#1)  Next, use the `row.eff` formula and the argument `studyDesign` to fit a
##       model with AR(1) correlated random effect for sampling year.
#2)  How strong are the temporal correlations present in the data? Plot the 
##       variance partitionings.
#3)  Calculate and plot the predictions errors for the yearly effects
##       using `getPredictErr()`.
#4)  What suitable structures are there for modeling temporal correlation in
##       `gllvm`, and how do they differ?

fit_ryear <- gllvm(yreef, Xreef, formula = Xform, family = "negative.binomial", 
                   num.lv = 0, row.eff = ??, studyDesign = ??)
# Check for convergence by e.g., plotting gradient values:
plot(c(fit_ryear$TMBfn$gr()))
# Print the model summary
summary(fit_ryear)
# Coefficient plot
coefplot(fit_ryear)


##### Adding spatially correlated LVs:
#5) Use the `lvCor` to incorporate LVs to the model with an exponential 
##    covariance structure. Take note of the time required to fit such a model, 
##    e.g., with `system.time()`.
#6) How is the strength of the spatial correlation in the given data? 
##    Draw also the variance partitioning plot.
#7) Visualize the estimated spatial effects on the map (for a couple of species,
##    say Grayspy vs. Hogfish)
#8) Optional: repeat the above, but instead, use `lvCor` to specify a Matérn 
##    covariace stucture (with $\nu=3/2$ or $5/2$) for the LVs. Alternatively, 
##    continue with `corExp` but see if varying the argument `NN` affects the 
##    estimation (speed).
t1 <- system.time(fit_statLV_ryear <- gllvm(yreef, Xreef, formula = Xform,
                                            family = "negative.binomial", 
                                            studyDesign = ??, row.eff = ??,
                                            num.lv = ??, lvCor = ??, 
                                            distLV = ??, Lambda.struc = ??, 
                                            sd.errors=FALSE))




##### BONUS
#1)  Simulate covariance matrices of increasing sizes and invert them naively 
##      (see the `solve()` function), monitoring the computation time. At what  
##      point does the operation grow noticeably slow?
#2)  As covariance matrices are a bit special vs. a general square matrix, i.e.,
##      they are both symmetric and positive definite, some of the typical matrix 
##      operations can usually be sped up by exploiting these properties. 
##      Compare the naive inversion to ones which are based on Cholesky 
##      decomposition. How drastic are the improvements, if any?
S <- seq(400, 4000, by=400)
Sigma <- rWishart(1, S[7], diag(S[7]))[,,1]
system.time(solve(Sigma))
system.time(chol2inv(chol(Sigma)))
system.time(Matrix::chol2inv(Matrix::chol(Sigma)))


#3) Instead of correlation matrices, generate symmetric sparse matrices, 
##    with various degrees of sparseness, and see how dense `solve()` compares 
##    to specialized sparse matrix inversion algorithms.
Mspar <- Matrix::rsparsematrix(4000, 4000, density=0.25, symmetric=TRUE)
Mspar <- Mspar + diag(rep(1,4000))
Mdens <- as.matrix(Mspar)  # store the same matrix as dense in order to compare
system.time(solve(Mdens))
system.time(solve(Mspar, diag(rep(1,4000)), sparse=TRUE))


## Sparse matrix operations can be incredibly efficient (much moreso than 
##    demonstrated here), but often only if they are of a known pattern, 
##    such as a band matrix:
diags <- matrix(rnorm(4000*1000), 4000, 1000)
Mband <- Matrix::bandSparse(4000, k=4*(0:999), diagonals=diags, symmetric=TRUE)
Matrix::nnzero(Mband) # number of non-zero entries
Mbdens <- as.matrix(Mband)
system.time(solve(Mbdens))
system.time(solve(Mband, diag(rep(1,4000)), sparse=TRUE))



