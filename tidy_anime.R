##### Load in Libs #####

library(tidyverse)
library(gganimate)
library(gifski)
library(png)

##### Load in Data from nflfastR #####
seasons <- 2015:2019

pbp15.19 <- purrr::map_df(seasons, function(x) {
  readRDS(
    url(
      glue::glue("https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_{x}.rds")
    )
  )
})

seasons <- 2020

pbp20 <- purrr::map_df(seasons, function(x) {
  readRDS(
    url(
      glue::glue("https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_{x}.rds")
    )
  )
})

DF <- rbind(pbp15.19, pbp2020)

##### Cleaning #####
DF1 <- DF %>% 
  separate(game_date, sep = "-", into = c("Year", "Month", "Day.Date")) %>% 
  select(game_id, Year, week, forced_fumble_player_1_player_name) %>% 
  filter(Year == 2020) %>% 
  rename("Name" = forced_fumble_player_1_player_name) %>% 
  filter(!is.na(Name)) %>% 
  group_by(week, Name) %>% 
  summarise(Count = n()) %>% 
  arrange(week)
DF1

DF.Final <- DF1 %>% 
  select(week, Name, Count)

#this removes postseason and the people that only had one week with a forced fumble, this will give us some more movement.
Frcd.Fumb.Peop <- DF.Final %>% 
  filter(week <= 16) %>% 
  group_by(Name) %>% 
  filter(n() > 2)

#lets build a week 0 with every player
FF0.re <- data.frame("week" = 0,
                     "Name" = unique(Frcd.Fumb.Peop$Name), 
                     "Count" = 0)
#adding .re, we are going to rebuild every data frame week by week with joins and mixing NAs

######## Week 1 #########
FF1 <- Frcd.Fumb.Peop %>% 
  filter(week == 1) %>% 
  select(-X)

FF1.re <- left_join(data.frame("week" = 1,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF1)
FF1.re[is.na(FF1.re)] <- 0
#ok, this is now correct for week 1, now this issue will be making sure the week 1 carry over to week 2 and change if they got a fumble, im thinking we copy FF1.re, change the week to 2, then join?

######## Week 2 #########
FF2 <- Frcd.Fumb.Peop %>% 
  filter(week == 2) %>% 
  select(-X)

FF1.Copy <- FF1.re
FF1.Copy$week <- 2 #ok we are going to use this and add the vectors as we go to get the aggregate for the right week

FF2.re <- left_join(data.frame("week" = 2,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF2)
FF2.re[is.na(FF2.re)] <- 0

FF2.re$Count <- FF2.re$Count + FF1.re$Count
#ok, i think this is the correct method for aggreagating, I should be able to copy and paste now. 


######## Week 3 #########
FF3 <- Frcd.Fumb.Peop %>% 
  filter(week == 3) %>% 
  select(-X)

FF2.Copy <- FF2.re
FF2.Copy$week <- 3 #ok we are going to use this and add the vectors as we go to get the aggregate for the right week

FF3.re <- left_join(data.frame("week" = 3,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF3)
FF3.re[is.na(FF3.re)] <- 0

FF3.re$Count <- FF3.re$Count + FF2.re$Count

######## Week 4 #########
FF4 <- Frcd.Fumb.Peop %>% 
  filter(week == 4) %>% 
  select(-X)

FF3.Copy <- FF3.re
FF3.Copy$week <- 4 

FF4.re <- left_join(data.frame("week" = 4,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF4)
FF4.re[is.na(FF4.re)] <- 0

FF4.re$Count <- FF4.re$Count + FF3.re$Count

######## Week 5 #########
FF5 <- Frcd.Fumb.Peop %>% 
  filter(week == 5) %>% 
  select(-X)

FF4.Copy <- FF4.re
FF4.Copy$week <- 5 

FF5.re <- left_join(data.frame("week" = 5,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF5)
FF5.re[is.na(FF5.re)] <- 0

FF5.re$Count <- FF5.re$Count + FF4.re$Count

######## Week 6 #########
FF6 <- Frcd.Fumb.Peop %>% 
  filter(week == 6) %>% 
  select(-X)

FF5.Copy <- FF5.re
FF5.Copy$week <- 6 

FF6.re <- left_join(data.frame("week" = 6,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF6)
FF6.re[is.na(FF6.re)] <- 0

FF6.re$Count <- FF6.re$Count + FF5.re$Count

######## Week 7 #########
FF7 <- Frcd.Fumb.Peop %>% 
  filter(week == 7) %>% 
  select(-X)

FF6.Copy <- FF6.re
FF6.Copy$week <- 7 

FF7.re <- left_join(data.frame("week" = 7,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF7)
FF7.re[is.na(FF7.re)] <- 0

FF7.re$Count <- FF7.re$Count + FF6.re$Count

######## Week 8 #########
FF8 <- Frcd.Fumb.Peop %>% 
  filter(week == 8) %>% 
  select(-X)

FF7.Copy <- FF7.re
FF7.Copy$week <- 8 

FF8.re <- left_join(data.frame("week" = 8,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF8)
FF8.re[is.na(FF8.re)] <- 0

FF8.re$Count <- FF8.re$Count + FF7.re$Count

######## Week 9 #########
FF9 <- Frcd.Fumb.Peop %>% 
  filter(week == 9) %>% 
  select(-X)

FF8.Copy <- FF8.re
FF8.Copy$week <- 9 

FF9.re <- left_join(data.frame("week" = 9,
                               "Name" = unique(Frcd.Fumb.Peop$Name)), FF9)
FF9.re[is.na(FF9.re)] <- 0

FF9.re$Count <- FF9.re$Count + FF8.re$Count

######## Week 10 #########
FF10 <- Frcd.Fumb.Peop %>% 
  filter(week == 10) %>% 
  select(-X)

FF9.Copy <- FF9.re
FF9.Copy$week <- 10 

FF10.re <- left_join(data.frame("week" = 10,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF10)
FF10.re[is.na(FF10.re)] <- 0

FF10.re$Count <- FF10.re$Count + FF9.re$Count

######## Week 11 #########
FF11 <- Frcd.Fumb.Peop %>% 
  filter(week == 11) %>% 
  select(-X)

FF10.Copy <- FF10.re
FF10.Copy$week <- 11 

FF11.re <- left_join(data.frame("week" = 11,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF11)
FF11.re[is.na(FF11.re)] <- 0

FF11.re$Count <- FF11.re$Count + FF10.re$Count

######## Week 12 #########
FF12 <- Frcd.Fumb.Peop %>% 
  filter(week == 12) %>% 
  select(-X)

FF11.Copy <- FF11.re
FF11.Copy$week <- 12 

FF12.re <- left_join(data.frame("week" = 12,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF12)
FF12.re[is.na(FF12.re)] <- 0

FF12.re$Count <- FF12.re$Count + FF11.re$Count

######## Week 13 #########
FF13 <- Frcd.Fumb.Peop %>% 
  filter(week == 13) %>% 
  select(-X)

FF12.Copy <- FF12.re
FF12.Copy$week <- 13 

FF13.re <- left_join(data.frame("week" = 13,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF13)
FF13.re[is.na(FF13.re)] <- 0

FF13.re$Count <- FF13.re$Count + FF12.re$Count

######## Week 14 #########
FF14 <- Frcd.Fumb.Peop %>% 
  filter(week == 14) %>% 
  select(-X)

FF13.Copy <- FF13.re
FF13.Copy$week <- 14 

FF14.re <- left_join(data.frame("week" = 14,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF14)
FF14.re[is.na(FF14.re)] <- 0

FF14.re$Count <- FF14.re$Count + FF13.re$Count

######## Week 15 #########
FF15 <- Frcd.Fumb.Peop %>% 
  filter(week == 15) %>% 
  select(-X)

FF14.Copy <- FF14.re
FF14.Copy$week <- 15 

FF15.re <- left_join(data.frame("week" = 15,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF15)
FF15.re[is.na(FF15.re)] <- 0

FF15.re$Count <- FF15.re$Count + FF14.re$Count

######## Week 16 #########
FF16 <- Frcd.Fumb.Peop %>% 
  filter(week == 16) %>% 
  select(-X)

FF15.Copy <- FF15.re
FF15.Copy$week <- 16 

FF16.re <- left_join(data.frame("week" = 16,
                                "Name" = unique(Frcd.Fumb.Peop$Name)), FF16)
FF16.re[is.na(FF16.re)] <- 0

FF16.re$Count <- FF16.re$Count + FF15.re$Count

DF.Final.Anime <- do.call("rbind", list(FF0.re, FF1.re, FF2.re, FF3.re, FF4.re, FF5.re,
                                        FF6.re, FF7.re, FF8.re, FF9.re, FF10.re,
                                        FF11.re, FF12.re, FF13.re, FF14.re, FF15.re, FF16.re))

##### write good data #####
write.csv(DF.Final.Anime, "Derived_Data/Final.Anime.csv")


##### gif #####

anim <- DF.Final.Anime %>% 
  group_by(Name) %>% 
  arrange(week) %>% 
  mutate(prev.count = lag(Count)) %>% 
  ungroup() %>% 
  group_by(week) %>% 
  arrange(desc(Count), prev.count) %>% 
  mutate(x = seq(1, n())) %>% 
  ungroup() %>% 
  filter(week <= 16) %>% 
  ggplot(aes(x = x, y = Count, fill = Name, color = Name)) +
  geom_tile(aes(y = Count/2, 
                height = Count, 
                width = .9, 
                fill = Name), alpha = .7) +
  geom_text(aes(y = Count, label = as.character(round(Count, 0))), vjust = 0, hjust = 0, size = 5) +
  geom_text(aes(y = 0, label = paste(Name, " ")), vjust = .2, hjust = 1, size = 6) +
  coord_flip(clip = "off", expand = TRUE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  theme_minimal() +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="black", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="red"),
        plot.caption =element_text(size=12, hjust=0.5, face="italic", color="red"),
        plot.background=element_blank(), 
        plot.margin = margin(0, 5, 0, 5, "cm")) +
  transition_states(week, transition_length = 2, state_length = 1) +
  ease_aes('cubic-in-out') +
  labs(title = 'Total Forced Fumbles in Week: {closest_state}', 
       caption = 'Data Source: nflfastR') +
  exit_fade()


animate(anim, 320, fps = 20,  width = 1200, height = 1000, 
        renderer = gifski_renderer("Derived_Graphics/Forced.Fumbles.2020.gif"))