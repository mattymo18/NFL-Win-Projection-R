##### load in libs and data #####
library(tidyverse)
library(ggfortify)
library(cluster)
library(Rtsne)
library(nflfastR)
library(ggimage)
library(factoextra)
reg.szn <- read_csv("Derived_Data/NFL.Clean.Cols.csv")

##### clean up a bit and summarize to get team identities #####
team.ident <-  reg.szn %>%
  separate(game_id, sep = "_", into = c("Szn.Year", "Szn.Week", "Away", "Home")) %>% 
  filter(Szn.Year >= 2018) %>% 
  select(-c(Szn.Week, Away, Home)) %>% 
  filter(!is.na(epa) & !is.na(wpa)) %>% 
  filter(!is.na(rush_attempt) & !is.na(pass_attempt) &
           !is.na(interception) &!is.na(complete_pass) &
           !is.na(fumble_lost) & !is.na(yards_gained) &
           !is.na(sack)) %>% 
  group_by(posteam) %>% 
  summarise(total.epa = sum(epa), 
            total.wpa = sum(wpa), 
            epa.per.game = total.epa/(16*length(unique(Szn.Year))), 
            wpa.per.game = total.wpa/(16*length(unique(Szn.Year))), 
            avg.yrds.togo = sum(ydstogo)/n(),
            avg.yrds.gain = sum(yards_gained)/n(),
            rush.att = sum(rush_attempt),
            pass.att = sum(pass_attempt), 
            int = sum(interception), 
            completions = sum(complete_pass), 
            TDs = sum(touchdown), 
            rush.TDs = sum(rush_touchdown), 
            pass.TDs = sum(pass_touchdown), 
            fumbles.lost = sum(fumble_lost), 
            field.goal.att = sum(field_goal_attempt), 
            total.sacks = sum(sack)) %>% 
  arrange(desc(total.epa)) %>%
  filter(!is.na(posteam))
team.ident

teams_colors_logos
team.ident.logo <- left_join(team.ident %>% 
                               rename(team_abbr = posteam), teams_colors_logos)

##### clustering #####

set.seed(18)

### PAM ###
g1 <- autoplot(pam(team.ident[, -1], 4), frame = T, fram.type = 'norm') +
  geom_image(aes(image = team.ident.logo$team_logo_espn), size = .05) +
  labs(title = "PAM Cluster Team Identities (2018-2020)", 
       caption = "Data Source: nflfastR") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none",
        plot.title = element_text(size=25, hjust=0.5, face="bold", colour="black", vjust=-1),
        plot.caption = element_text(size=12, hjust=0.5, face="italic", color="red"),
        plot.background = element_blank())
ggsave("README_Graphics/PAM.Cluster.Logos.png", plot = g1)

### K-Means ###
km.res <- kmeans(scale(team.ident[, -1]), 5, nstart = 25)
g2 <- fviz_cluster(km.res, data = team.ident[ ,-1], geom = c("point")) +
  geom_image(aes(image = team.ident.logo$team_logo_espn), size = .07) +
  labs(title = "K-Means Cluster Team Identities (2018-2020)", 
       caption = "Data Source: nflfastR") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none",
        plot.title = element_text(size=25, hjust=0.5, face="bold", colour="black", vjust=-1),
        plot.caption = element_text(size=12, hjust=0.5, face="italic", color="red"),
        plot.background = element_blank(), 
        plot.margin = margin(0, 1, 0, 1, unit = "cm"))
ggsave("Derived_Graphics/K-Means.Clustering.Logos.png", plot = g2)