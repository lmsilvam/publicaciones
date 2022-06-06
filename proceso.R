library(tidyverse)
library(stringi)
library(kable)

data <- read_csv("data.csv")
citescore <- read_delim("citescore.csv", 
                        delim = ";", escape_double = FALSE, trim_ws = TRUE)

# Construir tabla de autores a partir del campo Author
autores <- data %>% 
  select(Author) %>% 
  separate_rows(Author, sep=';') %>% 
  unique()

revistas <- data %>% 
  filter(`Item Type` == "journalArticle") %>% 
  rename('PubTitle' = `Publication Title`) %>% 
  mutate(PubTitle = stri_trans_general(str=str_replace_all(PubTitle, ',', ';'), id="Latin-ASCII")) %>% 
  group_by(PubTitle) %>% 
  tally() %>% 
  arrange(PubTitle)

scopus <- citescore %>% 
  rename('Area' = `Scopus Sub-Subject Area`) %>% 
  select(Title, Area, Quartile) %>% 
  distinct(Title, .keep_all = T)

total=merge(revistas, scopus, by.x='PubTitle', by.y='Title', all.x = T)
soloind=merge(revistas, scopus, by.x='PubTitle', by.y='Title')

