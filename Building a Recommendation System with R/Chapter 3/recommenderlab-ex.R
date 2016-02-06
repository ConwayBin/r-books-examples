### R code from vignette source 'recommenderlab.Rnw'
### for sampling
library(recommenderlab)
set.seed(1234)

m <- matrix(sample(c(as.numeric(0:5), NA), 50, replace = TRUE, prob = c( rep(.4/6,6), .6)), 
            ncol = 10,
            dimnames = list(user=paste("u", 1:5, sep=''), item = paste("i", 1:10, sep='')))
m


r <- as(m, "realRatingMatrix")
r
#as(r,"dgCMatrix")

# check if identical
identical(as(r, "matrix"), m)


as(r, "list")
head(as(r, "data.frame"))


# normalised to removed user rating bias
r_m <- normalize(r)
r_m2 <- normalize(r, method = "Z-score")
r_m
as(r_m, "matrix")
r_m2
as(r_m2, "matrix")

###################################################
### code chunk number 8: recommenderlab.Rnw:1119-1121 (eval = FALSE)
###################################################
image(r, main = "Raw Ratings")
image(r_m, main = "Normalized Ratings (center)")
image(r_m2, main = "Normalized Ratings (z-scores)")


###################################################
### code chunk number 9: image1
###################################################
print(image(r, main = "Raw Ratings"))


###################################################
### code chunk number 10: image2
###################################################
print(image(r_m, main = "Normalized Ratings"))


###################################################
### code chunk number 11: recommenderlab.Rnw:1154-1156
###################################################
r_b <- binarize(r, minRating=4)
as(r_b, "matrix")


# load dataset
data(Jester5k)
Jester5k

# sample 1000
r <- sample(Jester5k, 1000) 
r

# inspect first user
rowCounts(r[1,])  # amount of voted jokes by user
as(r[1,], "list") # all votes from user
rowMeans(r[1,])   # averate vote from user



# plot 3 histogram at the same time
par(mfrow=c(3,1))

# plot ratings histogram
hist(getRatings(r), breaks=100)

# plot normalized ratings histogram
hist(getRatings(normalize(r)), breaks=100)
hist(getRatings(normalize(r, method = "Z-score")), breaks=100)


# plot 2 histogram at the same time
par(mfrow = c(2, 1))
# number of jokes voted by user
hist(rowCounts(r), breaks=50)
# mean rating for each joke
hist(colMeans(r), breaks=20)


recommenderRegistry$get_entries(dataType = "realRatingMatrix")

r <- Recommender(Jester5k[1:1000], method = "POPULAR")
r

# check created model
names(getModel(r))
topn <- getModel(r)$topN
topn
attributes(topn)

# get next 2 users to predict
recom <- predict(r, Jester5k[1001:1002], n = 5)
recom

# list recommendations for selected users
as(recom, "list")


###################################################
### code chunk number 25: recommenderlab.Rnw:1323-1326
###################################################
recom3 <- bestN(recom, n = 3)
recom3
as(recom3, "list")

# predict ratings
recom <- predict(r, Jester5k[1001:1002], type="ratings")
recom
as(recom, "matrix")[,1:10]


###################################################
### code chunk number 27: recommenderlab.Rnw:1357-1360
###################################################
e <- evaluationScheme(Jester5k[1:1000], method="split", train=0.9, 
                      given=15, goodRating=5)
e


###################################################
### code chunk number 28: recommenderlab.Rnw:1366-1371
###################################################
r1 <- Recommender(getData(e, "train"), "UBCF")
r1

r2 <- Recommender(getData(e, "train"), "IBCF")
r2


###################################################
### code chunk number 29: recommenderlab.Rnw:1378-1382
###################################################
p1 <- predict(r1, getData(e, "known"), type="ratings")
p1
p2 <- predict(r2, getData(e, "known"), type="ratings")
p2


###################################################
### code chunk number 30: recommenderlab.Rnw:1388-1394
###################################################
error <- rbind(
  calcPredictionAccuracy(p1, getData(e, "unknown")),
  calcPredictionAccuracy(p2, getData(e, "unknown"))
)
rownames(error) <- c("UBCF","IBCF")
error


###################################################
### code chunk number 31: recommenderlab.Rnw:1407-1410
###################################################
scheme <- evaluationScheme(Jester5k[1:1000], method="cross", k=4, given=3,
                           goodRating=5)
scheme


###################################################
### code chunk number 32: recommenderlab.Rnw:1417-1420
###################################################
results <- evaluate(scheme, method="POPULAR", type = "topNList", 
                    n=c(1,3,5,10,15,20))
results


###################################################
### code chunk number 33: recommenderlab.Rnw:1431-1432
###################################################
getConfusionMatrix(results)[[1]]


###################################################
### code chunk number 34: recommenderlab.Rnw:1444-1445
###################################################
avg(results)


###################################################
### code chunk number 35: roc1
###################################################
plot(results, annotate=TRUE)


###################################################
### code chunk number 36: precrec1
###################################################
plot(results, "prec/rec", annotate=TRUE)


###################################################
### code chunk number 37: recommenderlab.Rnw:1491-1507
###################################################
set.seed(2016)
scheme <- evaluationScheme(Jester5k[1:1000], method="split", train = .9, 
                           k=1, given=-5, goodRating=5)
scheme

algorithms <- list(
  "random items" = list(name="RANDOM", param=NULL),
  "popular items" = list(name="POPULAR", param=NULL),
  "user-based CF" = list(name="UBCF", param=list(nn=50)),
  "item-based CF" = list(name="IBCF", param=list(k=50)),
  "SVD approximation" = list(name="SVD", param=list(approxRank = 50))
)

## run algorithms
results <- evaluate(scheme, algorithms, type = "topNList", 
                    n=c(1, 3, 5, 10, 15, 20))


###################################################
### code chunk number 38: recommenderlab.Rnw:1512-1513
###################################################
results


###################################################
### code chunk number 39: recommenderlab.Rnw:1519-1521
###################################################
names(results)
results[["user-based CF"]]


###################################################
### code chunk number 40: roc2
###################################################
plot(results, annotate=c(1,3), legend="bottomright")


###################################################
### code chunk number 41: precrec2
###################################################
plot(results, "prec/rec", annotate=3, legend="topleft")


###################################################
### code chunk number 42: recommenderlab.Rnw:1564-1566
###################################################
## run algorithms
results <- evaluate(scheme, algorithms, type = "ratings") 


###################################################
### code chunk number 43: recommenderlab.Rnw:1571-1572
###################################################
results


###################################################
### code chunk number 44: real
###################################################
plot(results, ylim = c(0,100))


###################################################
### code chunk number 45: recommenderlab.Rnw:1595-1601
###################################################
Jester_binary <- binarize(Jester5k, minRating=5)
Jester_binary <- Jester_binary[rowCounts(Jester_binary)>20]
Jester_binary
scheme_binary <- evaluationScheme(Jester_binary[1:1000], 
                                  method="split", train=.9, k=1, given=3)
scheme_binary


###################################################
### code chunk number 46: recommenderlab.Rnw:1604-1606
###################################################
results_binary <- evaluate(scheme_binary, algorithms, 
                           type = "topNList", n=c(1,3,5,10,15,20))


###################################################
### code chunk number 47: roc3
###################################################
plot(results_binary, annotate=c(1,3), legend="bottomright")

