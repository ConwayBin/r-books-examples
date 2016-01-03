library(ggplot2)


# scatter plot ------------------------------------

# base
plot(mtcars$wt, mtcars$mpg)

# ggplot2
qplot(mtcars$wt, mtcars$mpg)
qplot(wt, mpg, data = mtcars)
ggplot(mtcars, aes(wt, mpg)) + geom_point()
# -------------------------------------------------



# line graph --------------------------------------

# base
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure) # add points

lines(pressure$temperature, pressure$pressure/2, col="red") # add another line in red
points(pressure$temperature, pressure$pressure/2, col="red") # add another points in red

# ggplot2
qplot(pressure$temperature, pressure$pressure, geom="line")
qplot(temperature, pressure, data = pressure, geom="line")
ggplot(pressure, aes(x = temperature, y = pressure)) + geom_line()

qplot(temperature, pressure, data = pressure, geom = c("line", "point"))
ggplot(pressure, aes(x = temperature, y = pressure)) + geom_line() + geom_point()
# -------------------------------------------------




# bar graph ---------------------------------------

# base
barplot(BOD$demand, names.arg = BOD$Time)

table(mtcars$cyl)
barplot(table(mtcars$cyl)) # plot as bar graph table of counts

# ggplot2
#qplot(BOD$Time, BOD$demand, geom = "bar", stat = "identity") # ????
#qplot(factor(BOD$Time), BOD$demand, geom = "bar", stat = "identity") # ????
#qplot(Time, demand, data = BOD, geom = "bar", stat = "identity")

ggplot(BOD, aes(x = Time, y = demand)) + geom_bar(stat = "identity")
ggplot(BOD, aes(x = factor(Time), y = demand)) + geom_bar(stat = "identity")

ggplot(mtcars, aes(x = factor(cyl))) + geom_bar()
# -------------------------------------------------



# histograms --------------------------------------

# base
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10)

# ggplot2
qplot(mtcars$mpg, binwidth = 4)
qplot(mpg, data = mtcars, binwidth = 12)
ggplot(mtcars, aes(x = mpg)) + geom_histogram(binwidth = 4)
# -------------------------------------------------


# box plots ---------------------------------------

# base
plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len ~ supp, data = ToothGrowth) # ~ means "explained with" i.e. 'len' explained with 'supp'
boxplot(len ~ dose, data = ToothGrowth) 
boxplot(len ~ dose + supp, data = ToothGrowth) # or 'len' depands on 'dose' and 'supp'

# ggplot2
qplot(ToothGrowth$supp, ToothGrowth$len, geom = "boxplot")
qplot(supp, len, data = ToothGrowth, geom = "boxplot")
ggplot(ToothGrowth, aes(x = supp, y = len)) + geom_boxplot()
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom = "boxplot")
qplot(interaction(supp, dose), len, data = ToothGrowth, geom = "boxplot")
ggplot(ToothGrowth, aes(x = interaction(supp, dose), y = len)) + geom_boxplot()
# -------------------------------------------------



# functions curves --------------------------------

# base
curve(x^3 - 5*x, from = -4, to = 4)
curve(x^2, from = -4, to = 4)
curve(x^2 + 10, from = -40, to = 40)

myfun <- function(xvar) {
  1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from = -100, to = 100)
curve(1 - myfun(x), add = TRUE, col = "red") # add red line

# ggplot2
# qplot(c(0,20), fun = myfun, stat = "function", geom = "line")
ggplot(data.frame(x = c(0,20)), aes(x = x)) + stat_function(fun = myfun, geom = "line")

# -------------------------------------------------
