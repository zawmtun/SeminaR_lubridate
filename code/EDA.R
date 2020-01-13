library(tidyverse)
library(lubridate)

# Load data
varname <- c(
  "date", "url", "hit_sentence", "influencer", "country",
  "language", "ave", "sentiment", "key_phrases", "keywords",
  "sanofi", "dengue", "dengvaxia", "vaccine", "vax"
)

tw <- data.table::fread("data/dengue_twitter.csv") %>% 
  select(Date, URL, Hit.Sentence, Influencer, Country, Language, AVE, Sentiment, Key.Phrases, Keywords, sanofi:vax) %>% 
  set_names(varname)

tw1 <- tw %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date),
         date_str = as.character(date)) %>% 
  separate(date_str, c("date", "time"), sep = " ") %>% 
  mutate(time = str_sub(time, 1, 5) %>% str_remove(":") %>% as.double()) %>% 
  select(year, month, day, time, everything(), -date)

write_csv(tw1, "data/tw_new.csv")

varname <- c(
  "date", "url", "hit_sentence", "influencer", "country",
  "language", "reach", "ave", "sentiment", "key_phrases",
  "keywords"
)
  
fb <- data.table::fread("data/dengue_fb.csv") %>% 
  select(Date, URL, `Hit Sentence`, Influencer, Country, Language, Reach, AVE, Sentiment, `Key Phrases`, Keywords) %>% 
  set_names(varname)

write_csv(fb, "data/fb_new.csv")

# ave = advertising value equivalent


