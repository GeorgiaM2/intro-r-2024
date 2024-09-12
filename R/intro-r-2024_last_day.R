#### Aggregating and Summarizing Data ####

# Load packages ----
library(readxl)
library(dplyr)
library(ggplot2)

# Read in the excel file ----
df <- read_excel("data/icebreaker_answers.xlsx")
df
summary(df)

# custom summaries of an entire data frame ----
df |> summarize(
  avg_dist = mean(travel_distance), 
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = .6),
  avg_time = mean(travel_time)
)
?summarize

# an aside, if you want an integer, must specify 
df |> mutate(travel_time = as.integer(travel_time))


# assign the summary if you want to save 
# view ()
df_summ <- df |> summarize(
  avg_dist = mean(travel_distance), 
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = .6),
  avg_time = mean(travel_time)
)
View(df_summ)
#view(df_summ) # same as clicking df_summ in Environment window 

# Aggregating and summarizing subsets of a data frame ----
# of a data frame 
df <- df |> 
  mutate(travel_speed = travel_distance / travel_time * 60)
df |> 
  summarise(avg_speed = mean(travel_speed))


# average speed by mode 
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean(travel_speed))

#  sort by avg spee
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean(travel_speed)) |>
  arrange(desc(avg_speed))

#group data frame 
df |> group_by(travel_mode)


df_mode_grp <- df |> group_by(travel_mode)
str(df_mode_grp)


#grouping by multiple variables
# by default summarize will leave data grouped by next higher level
df |> group_by(travel_mode, serial_comma) |>
  summarise(avg_spee = mean(travel_speed))

# Frequencies ----
# so common there are shortcuts
df |> group_by(serial_comma) |>
  summarize(n = n())

df |> group_by(serial_comma) |>
  tally()

df |> count(serial_comma)

# can arrange this also 
df |> count(serial_comma, sort=T) # where T is for TRUE

# calculate a mode split (percentage using each travel mode)
df |> count(travel_mode)

df |> group_by(travel_mode) |>
  summarise(split = n() / nrow(df) * 100) |>
  arrange(desc(split))
  

