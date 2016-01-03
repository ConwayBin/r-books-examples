library(reshape2)

# generate data.frame
long <- expand.grid(
  SITE = c("A","B"),
  TREAT = c("low","med","high"), 
  REP = c(1:5)
)

long$YIELD <- round(rnorm(10)*5 + 15); 

long

# Long-to-wide conversion with the reshape2 package, 
# where SITE and REP remain columns, but the treatment levels of TREAT now become several new columns:
wide <- dcast(long, 
              SITE + REP ~ TREAT, 
              value.var = "YIELD")

wide


# Wide-to-long conversion back to what we had before. 
# The variables that you want to maintain as  columns are SITE and REP, all others will be gathered into a new variable where the remaining columns become treatment levels. 
# You have to fix the variable names to get to the original long:
long2 <- melt(wide, 
              id.vars = c("SITE", "REP"))


names(long2) <- c("SITE","REP","TREAT","YIELD")

long2


# this is example from help of 'dcast'

# Air quality example
names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, 
            id = c("month", "day"), na.rm=TRUE)

acast(aqm, day ~ month ~ variable)
acast(aqm, month ~ variable, mean)
acast(aqm, month ~ variable, mean, margins = TRUE)
dcast(aqm, month ~ variable, mean, margins = c("month", "variable"))

library(plyr) # needed to access . function
acast(aqm, variable ~ month, mean, subset = .(variable == "ozone"))
acast(aqm, variable ~ month, mean, subset = .(month == 5))

#Chick weight example
names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id = 2:4, na.rm=TRUE)

dcast(chick_m, time ~ variable, mean)   # average effect of time
dcast(chick_m, diet ~ variable, mean)   # average effect of diet
acast(chick_m, diet ~ time, mean)       # average effect of diet & time

# How many chicks at each time? - checking for balance
acast(chick_m, time ~ diet, length)
acast(chick_m, chick ~ time, mean)
acast(chick_m, chick ~ time, mean, subset = .(time < 10 & chick < 20))

acast(chick_m, time ~ diet, length)

dcast(chick_m, diet + chick ~ time)
acast(chick_m, diet + chick ~ time)
acast(chick_m, chick ~ time ~ diet)
acast(chick_m, diet + chick ~ time, length, margins="diet")
acast(chick_m, diet + chick ~ time, length, drop = FALSE)

#Tips example
dcast(melt(tips), sex ~ smoker, mean, subset = .(variable == "total_bill"))

ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
acast(ff_d, subject ~ time, length)
acast(ff_d, subject ~ time, length, fill=0)
dcast(ff_d, treatment ~ variable, mean, margins = TRUE)
dcast(ff_d, treatment + subject ~ variable, mean, margins="treatment")

if (require("lattice")) {
  lattice::xyplot(`1` ~ `2` | variable, dcast(ff_d, ... ~ rep), aspect="iso")
}