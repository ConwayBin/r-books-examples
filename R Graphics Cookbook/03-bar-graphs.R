library(gcookbook)
library(ggplot2)

# bar graphs typically used to diplay:
# numeric values on the y-axis
# different categories on the x-axis


# basic bar graph --------------------------
ggplot(pg_mean, aes(x = group, y = weight)) + geom_bar(stat = "identity")

ggplot(BOD, aes(x = Time, y = demand)) + geom_bar(stat="identity")
ggplot(BOD, aes(x = factor(Time), y = demand)) + geom_bar(stat="identity") # convert Time to discrete (categorical) variable with factor()

ggplot(pg_mean, aes(x = group, y = weight)) + geom_bar(stat = "identity", fill = "lightblue", colour = "black") # fill with lightblue colour and black frame 
# ------------------------------------------

# grouping bars together -------------------
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(stat = "identity")
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "dodge", stat = "identity")

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "fill", stat = "identity")
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "identity", stat = "identity")
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "jitterdodge", stat = "identity")
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "jitter", stat = "identity")
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + geom_bar(position = "nudge", stat = "identity")

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) + 
  geom_bar(position = "dodge", stat = "identity", colour = "black") +
  scale_fill_brewer(palette = "Pastel1")
# ------------------------------------------



# bag graph of counts ----------------------

ggplot(diamonds, aes(x = cut)) + geom_bar()
ggplot(diamonds, aes(x = carat)) + geom_bar()
ggplot(diamonds, aes(x = carat)) + geom_bar(binwidth = 0.5)
ggplot(diamonds, aes(x = carat)) + geom_histogram()

# ------------------------------------------



# colors in a bar graph --------------------

upc <- subset(uspopchange, rank(Change)>40)
upc

# ------------------------------------------
