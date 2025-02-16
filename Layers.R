
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
#You can set the visual properties of your geom manually as an argument of your geom function 
#(outside of aes()) instead of relying on a variable mapping to determine the appearance. 

#Mapping an unordered discrete (categorical) variable (class) to an ordered aesthetic
#(size or alpha) is generally not a good idea because it implies a ranking that
#does not in fact exist.

# Excercise ---------------------------------------------------------------

#1 Create a scatterplot of hwy vs. displ where the points are pink filled in triangles.
ggplot(mpg,  aes(x = displ, y = hwy)) + 
  geom_point(color = "deeppink", shape=17)
#Why did the following code not result in a plot with blue points?
  
  ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, color = "blue"))
#-because it is in aes area, it not have variable information it shoud be after aes
  ggplot(mpg) + 
    geom_point(aes(x = displ, y = hwy ),color = "blue")
  #or
  ggplot(mpg,aes(x = displ, y = hwy ) ) + 
    geom_point(color = "blue")
#What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point
  ggplot(mpg) + 
    geom_point(aes(x = displ, y = hwy),stroke=5) 
  
  ggplot(mpg) + 
    geom_point(aes(x = displ, y = hwy),stroke=1)
  ggplot(mpg) + 
    geom_point(aes(x = displ, y = hwy))
#-Stroke changes the size of the border for shapes
  
#What happens if you map an aesthetic to something other than a variable name, like aes(color = displ < 5)? Note, you’ll also need to specify x and y.
  ggplot(mpg) + 
    geom_point(aes(x = displ, y = hwy,color = displ < 5))
#display two group in color one where argument is less the 5 and second where argument is more that 5
  
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
ggplot(mpg, aes())
  
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