library(tidycensus) # acts as gateway to the Cnsus API for ACS & Deceniial data
# for more info: https://walker-data.com/tidycensus/
library(dplyr) 
library(tidyr)
library(ggplot2)


#### user functions ####
tidy_acs_result <- function(raw_result, include_moe = F) {
  # takes a tidycensus acs result and returns a wide and tidy table 
  if(isTRUE(include_moe)) {
    
  new_df <- raw_result |> pivot_wider(id_cols = GEOID:NAME,
                                      names_from = varialbe,
                                      values_from = estimate:moe)
  } else {
    new_df <- raw_result |> pivot_wider(id_cols = GEOID:NAME,
                                        names_from = variable,
                                        values_from = estimate)
  }
  return(new_df)
}

##### Run on first use if not already stored in R ##
census_api_key("", install=F)  # installs into Ruser environment 
readRenviron("~/.Renviron")
####

#### user functions ####

####

# get a serchable census variable table ----
v19 <- load_variables(2019, "acs5")
v19 |> filter(grepl("^B08006_", name)) |> 
  print(n=25)

# get age data for transit, wfh, and total workers ----
# ? get_acs
comm_19_raw <- get_acs(geography = "tract",
                       variables = c(wfh = "B08006_017",
                                     transit = "B08006_008",
                                     tot ="B08006_001"),
                       county = "Multnomah",
                       state = "OR",
                       year = 2019,
                       survey = "acs5",
                       geometry = FALSE) # can retrieve library(sf)
                                        #spatial geoms pre-joined 

comm_19_raw

#
comm_19 <- comm_19_raw |>
  pivot_wider(id_cols = GEOID, 
              names_from = variable,
              values_from = estimate:moe)
comm_19
 
comm_19 <- tidy_acs_result(comm_19_raw)
comm_19

# get 2022acs data ----
comm_22_raw <- get_acs(geography = "tract",
                       variables = c(wfh = "B08006_017",
                                     transit = "B08006_008",
                                     tot ="B08006_001"),
                       county = "Multnomah",
                       state = "OR",
                       year = 2022,
                       survey = "acs5",
                       geometry = FALSE) # can retrieve library(sf)
#spatial geoms pre-joined 

comm_22_raw

#applying our unction to pivot wider andd drop moe's 
comm_22 <- tidy_acs_result(comm_22_raw)
comm_22

# is the change in 2021 to 2022 and wfh corralate with transit changes
# join the years ----
comm_19_22 <- comm_19 |> inner_join(comm_22,
                                    by="GEOID",
                                    suffix = c("_19", "_22")) |>
  select(-starts_with("NAME"))
comm_19_22


# create some change variables ----
comm_19_22 <- comm_19_22 |>
  mutate(wfh_chg = wfh_22 - wfh_19,
         transit_chg = transit_22 - transit_19)
summary(comm_19_22 |> select(ends_with("_chg")))

# plot them ----
p <- comm_19_22 |>
  ggplot(aes(x = wfh_chg, y = transit_chg))
p + geom_point() # to get a scatter plot

p + geom_point() + geom_smooth(method = "lm") +
  labs(x = "change in WFH", y = "change in transit", title = "ACS 2022 vs 2019 (5-year)") +
annotate("text", x = 800, y = 50,
         label = paste("r=", 
                      round(cor(comm_19_22$wfh_chg,
                           comm_19_22$transit_chg), 2)))

# simple linear (default pearson) correlation 
cor(comm_19_22$wfh_chg, comm_19_22$transit_chg)

# modle it ----
# model formula is dependent variable ~ 1 + X1 + X2 ...
m <- lm(transit_chg ~ wfh_chg,
        data = comm_19_22)
summary(m)

# model is an object ready for re-use!!
head(m$model) # model comes data included!

scen1 <- comm_19_22 |>
  mutate(wfh_chg = wfh_chg * 1.5)

scnen1_pred <- predict(m, newdata = scen1)


#difference in otal daily transit impact from 50% increase in wfh 
sum(comm_19_22$transit_chg)
sum(scnen1_pred)


# update (model, date =) function rre-estimates model on new data 
