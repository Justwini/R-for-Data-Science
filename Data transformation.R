library(nycflights13)
library(tidyverse)
install.packages("nycflights13")
glimpse(flights)
#dplyr basics
#Rows
flights|>
  filter(dest=="IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay=mean(arr_delay, na.rm = TRUE)
  )

flights |> 
  filter(dep_delay>120)

flights|> 
  filter(month == 1 & day == 1)

flights |> 
  filter(month == 1 | month == 2)
0--
flights |> 
  filter(month %in% c(1, 2))
jan1 <- flights |> 
  filter(month == 1 & day == 1)
flights |> 
  arrange(year, month, day, dep_time)
flights |> 
  arrange(desc(dep_delay))
flights |> 
  distinct()

flights |> 
  distinct(origin, dest)
flights |> 
  distinct(origin, dest, .keep_all = TRUE)

flights |>
  count(origin, dest, sort = TRUE)
#Exercises
#1 In a single pipeline for each condition, find all flights that meet the condition:
#- Had an arrival delay of two or more hours
#-Flew to Houston (IAH or HOU)
#-Were operated by United, American, or Delta
#-Departed in summer (July, August, and September)
#-Arrived more than two hours late but didn’t leave late
#-Were delayed by at least an hour, but made up over 30 minutes in flight
?flights
View(flights)
View(airlines)
flights |>
  filter(arr_delay>=120)
flights |>
  filter(dest %in% c("IAH","HOU"))
flights |>
  filter(carrier %in% c("UA","AA","DL"))

flights |>
  filter(month %in% c("7","8","9"))
flights |>
  filter(arr_delay>120,dep_delay<=0)
flights |>
  filter(dep_delay>=60,dep_delay-arr_delay>=30)
#2 Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.
flights |> arrange(desc(dep_delay),dep_time)
#3 Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
flights|>
  arrange( arr_delay - dep_delay)
#4 Was there a flight on every day of 2013?
flights|>
  filter(year==2013)|>
distinct(month,day)|>
  count()
#5Which flights traveled the farthest distance? Which traveled the least distance?
  
# 6 Does it matter what order you used filter() and arrange() if you’re using both? Why/why not? Think about the results and how much work the functions would have to do.
#no,
## Columns
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60)

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

flights |> 
  select(year, month, day)

flights |> 
  select(year:day)
flights |> 
  select(!year:day)
flights |> 
  select(where(is.character))

#starts_with("abc"): matches names that begin with “abc”.
#ends_with("xyz"): matches names that end with “xyz”.
#contains("ijk"): matches names that contain “ijk”.
#num_range("x", 1:3): matches x1, x2 and x3.

flights |> 
  select(tail_num = tailnum)
flights |> 
  rename(tail_num = tailnum)
flights |> 
  relocate(time_hour, air_time)
flights |> 
  relocate(year:dep_time, .after = time_hour)
flights |> 
  relocate(starts_with("arr"), .before = dep_time)
##3.3.5 Exercises
#1 Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
  
#2 Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

#3 What happens if you specify the name of the same variable multiple times in a select() call?
  
#4 What does the any_of() function do? Why might it be helpful in conjunction with this vector?
  
  variables <- c("year", "month", "day", "dep_delay", "arr_delay")
  
#5 Does the result of running the following code surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?
  
  flights |> select(contains("TIME"))

#6 Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.

#7 Why doesn’t the following work, and what does the error mean?
  
  flights |> 
  select(tailnum) |> 
  arrange(arr_delay)
#> Error in `arrange()`:
#> ℹ In argument: `..1 = arr_delay`.
#> Caused by error:
#> ! object 'arr_delay' not found

#3.4 The pipe
  flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

#3.5 Groups
  flights |> 
    group_by(month)
  
  #3.5.2 summarize() 
  flights |> 
    group_by(month) |> 
    summarize(
      avg_delay = mean(dep_delay)
    )
  
  flights |> 
    group_by(month) |> 
    summarize(
      avg_delay = mean(dep_delay, na.rm = TRUE)
    )
  
  flights |> 
    group_by(month) |> 
    summarize(
      avg_delay = mean(dep_delay, na.rm = TRUE), 
      n = n()
    )
  #3.5.3 The slice_ functions
  
  flights |> 
    group_by(dest) |> 
    slice_max(arr_delay, n = 1) |>
    relocate(dest)
  
  daily <- flights |>  
    group_by(year, month, day)
  daily
  
  daily_flights <- daily |> 
    summarize(n = n())
  
  daily_flights <- daily |> 
    summarize(
      n = n(), 
      .groups = "drop_last"
    )
  
daily |> 
  ungroup()
  
  daily |> 
    ungroup() |>
    summarize(
      avg_delay = mean(dep_delay, na.rm = TRUE), 
      flights = n()
    )
  

    
#3.5.7 Exercises
#1 Which carrier has the worst average delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights |> group_by(carrier, dest) |> summarize(n()))

#2 Find the flights that are most delayed upon departure from each destination.

#3 How do delays vary over the course of the day? Illustrate your answer with a plot.

#4 What happens if you supply a negative n to slice_min() and friends?

#5 Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?

#6 Suppose we have the following tiny data frame:

df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

#a Write down what you think the output will look like, then check if you were correct, and describe what group_by() does.

df |>
  group_by(y)

#b Write down what you think the output will look like, then check if you were correct, and describe what arrange() does. Also, comment on how it’s different from the group_by() in part (a).

df |>
  arrange(y)

#c Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does.

df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
#d Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. Then, comment on what the message says.

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
# e Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. How is the output different from the one in part (d)?

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")

#f Write down what you think the outputs will look like, then check if you were correct, and describe what each pipeline does. How are the outputs of the two pipelines different?

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x)

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )



  