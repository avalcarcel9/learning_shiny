########################
# Created by: Alessandra Valcarcel 
# Create date: November 16, 2021
# Description: Working through Shiny book script for chapter 4
########################

library(shiny)
library(vroom)
library(tidyverse)

setwd('chapter_4')

# get the data on to your own computer
dir.create("neiss")
#> Warning in dir.create("neiss"): 'neiss' already exists
download <- function(name) {
  url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss/"
  download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
}
download("injuries.tsv.gz")
download("population.tsv")
download("products.tsv")

injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products <- vroom::vroom("neiss/products.tsv")
population <- vroom::vroom("neiss/population.tsv")

# product with an interesting story: 649, “toilets”
selected = injuries %>% 
  dplyr::filter(prod_code == 649)

# basic summaries
nrow(selected)
#> [1] 2993
selected %>% 
  dplyr::count(location, wt = weight, sort = TRUE)

selected %>% 
  dplyr::count(body_part, wt = weight, sort = TRUE)

selected %>% 
  dplyr::count(diag, wt = weight, sort = TRUE)

summary <- selected %>% 
  dplyr::count(age, sex, wt = weight)

summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

# convert the variable to a factor, order by the frequency of the levels, and
# then lump together all levels after the top 5
injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))

# a little function to automate this for any variable
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}

injuries %>%
  mutate(diag = fct_infreq(fct_lump(diag)), n = 5) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))
