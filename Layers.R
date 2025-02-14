
# Aesthetic mappings ------------------------------------------------------


library(tidyverse)
mpg
?mpg
#1. displ: A car’s engine size, in liters. A numerical variable.
#2. hwy: A car’s fuel efficiency on the highway, in miles per gallon (mpg). A car with a low fuel efficiency consumes more fuel than a car with a high fuel efficiency when they travel the same distance. A numerical variable.
#3. class: Type of car. A categorical variable.


ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()
#The shape palette can deal with a maximum of 6 discrete values because more than 6
#becomes difficult to discriminate; you have 7. Consider specifying shapes
#manually if you must have them.

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "blue")
#Mapping an unordered discrete (categorical) variable (class) to an ordered aesthetic
#(size or alpha) is generally not a good idea because it implies a ranking that
#does not in fact exist.

# Geometric objects -------------------------------------------------------

# Left
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# Right
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()

# Left
ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) + 
  geom_smooth()

# Right
ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + 
  geom_point() +
  geom_smooth(aes(linetype = drv))
# Left
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

# Middle
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv))

# Right
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    shape = "circle open", size = 3, color = "red"
  )


# Left
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2)

# Middle
ggplot(mpg, aes(x = hwy)) +
  geom_density()

# Right
ggplot(mpg, aes(x = hwy)) +
  geom_boxplot()
install.packages("ggridges")
library(ggridges)

ggplot(mpg, aes(x = hwy, y = drv, fill = drv, color = drv)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)

# Exercises ---------------------------------------------------------------

#1 What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
  
#2 Earlier in this chapter we used show.legend without explaining it:
  
  ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)

#What does show.legend = FALSE do here? What happens if you remove it? Why do you think we used it earlier?
  
#3 What does the se argument to geom_smooth() do?
  
#4 Recreate the R code necessary to generate the following graphs. Note that wherever a categorical variable is used in the plot, it’s drv.


# Facets ------------------------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl, scales = "free")

ggplot(mpg) + 
  geom_point(aes(x = drv, y = cyl))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ cyl, nrow = 2)
Exercises