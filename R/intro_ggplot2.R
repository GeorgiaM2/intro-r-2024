library(dplyr)
library(ggplot2)
library(readxl)

# load data
df_ice <- read_xlsx("data/icebreaker_answers.xlsx")


tt_ml_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance)) + # creating plot
      geom_point()
tt_ml_fig


tt_ml_ox_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance, color = serial_comma))+ #adding color to points
  geom_point()
tt_ml_ox_fig

tt_ml_ox_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance, color = serial_comma))+
  geom_point() +
xlab("Travel Time") + # changing x & y axes
  ylab("Travel Distance")
tt_ml_ox_fig


tt_ml_2 <- tt_ml_ox_fig +
  theme_bw() # changing background 
tt_ml_2


# create new figure using mode instead of serial_comma
tt_ml_md_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance, color = travel_mode))+ 
  geom_point()
tt_ml_md_fig

# faceting
ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time, y = travel_distance)) +
           geom_point() +
           facet_wrap(travel_mode ~ .,
                      scales = "free")
ice_facet_fig


tt_mode_car_fig <- df_ice |>
  filter(travel_mode == "car") |>
  ggplot(aes(x = travel_time, y = travel_distance)) + 
  geom_point() +
  theme_bw()
tt_mode_car_fig
