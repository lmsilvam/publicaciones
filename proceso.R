library(tidyverse)
library(kable)

data <- read_csv("data.csv")

# Construir tabla de autores a partir del campo Author
autores <- data %>% 
  select(Author) %>% 
  separate_rows(Author, sep=';') %>% 
  unique()

revistas <- data %>%
  arrange('Publication Title') %>% 
  group_by('Publication Title') %>% 
  tally() 