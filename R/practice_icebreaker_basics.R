#### Practice Problem: Loading and manipulating a data frame ####
# Don't forget: Comment anywhere the code isn't obvious to you!

# Load the readxl and dplyr packages
library(readxl)
library(dplyr)
# Use the read_excel function to load the class survey data
practice_class_1 <- read_excel("data/icebreaker_answers.xlsx")
# Take a peek!
practice_class_1
# Create a travel_speed column in your data frame using vector operations and 
#   assignment
practice_class_1$travel_speed <- 
  (practice_class_1$travel_distance / practice_class_1$travel_time * 60) 
# Look at a summary of the new variable--seem reasonable?
summary(travel_speed)
boxplot(practice_class_1$travel_speed ~ practice_class_1$travel_mode) #quick box plot 
hist(practice_class_1$travel_speed) # quick histogram
# Choose a travel mode, and use a pipe to filter the data by your travel mode
practice_class_1 |> 
  filter(travel_mode == "bus"
         )
# Note the frequency of the mode (# of rows returned)
5
# Repeat the above, but this time assign the result to a new data frame
bus_trav <- practice_class_1 |> 
  filter(travel_mode == "bus"
  )
# Look at a summary of the speed variable for just your travel mode--seem 
#   reasonable?
summary(bus_trav$travel_speed)

# Filter the data by some arbitrary time, distance, or speed threshold
practice_class_1 |>
  filter(travel_speed > 20 & travel_speed < 50)
# Stretch yourself: Repeat the above, but this time filter the data by two 
#   travel modes (Hint: %in%)
practice_class_1 |> 
  filter( travel_mode %in% c("bike", "bus"))
#or
practice_class_1 |>
  filter( travel_mode == "bike" | travel_mode == "bus")
