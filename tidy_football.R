##### Cleaner #####

## Libraries ##
library(tidyverse)
# library(nflfastR)
# you don't need this unless you want to get data the other way (later)

## Load in Data ##
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

## Regular SZN ##
reg.szn.pbp15_19 <- pbp15.19 %>% 
  filter(season_type == "REG")

reg.szn.pbp20 <- pbp20 %>% 
  filter(season_type == "REG")

## Variable Selection ##
reg.szn.clean.cols.15_19 <- reg.szn.pbp15_19 %>% 
  select(
    #first we want the game situation
    game_id, home_team, away_team, season_type, posteam, defteam, game_seconds_remaining, 
    half_seconds_remaining, quarter_seconds_remaining, home_timeouts_remaining, 
    away_timeouts_remaining, yrdln, ydstogo, total_home_score, total_away_score, 
    #then we want a description of the play (will take out desc eventually)
    timeout, shotgun, no_huddle, qb_dropback, qb_kneel, qb_spike, qb_scramble,
    qb_hit, yards_gained, desc,
    #we also want to know what type of play it was
    rush_attempt, pass_attempt, play_type, 
    #pass plays
    pass_length, air_yards, yards_after_catch, complete_pass, incomplete_pass, interception, 
    #rush plays
    run_location, run_gap, fumble_forced, fumble_lost, 
    #defense strengths: turnovers will count positive for non-posteam. solo_tackle are good for team morale
    solo_tackle, sack, interception, fumble_forced, fumble_lost, 
    #kicks/special teams (will prpbably want to take out later, punts not considered)
    extra_point_attempt, extra_point_result, field_goal_attempt, field_goal_result, 
    two_point_attempt, two_point_conv_result, 
    #lots of probabilities
    no_score_prob, opp_fg_prob, opp_safety_prob, opp_td_prob, fg_prob, safety_prob, td_prob, 
    extra_point_prob, two_point_conversion_prob,
    #expected points
    ep, epa, total_home_epa, total_away_epa, total_home_rush_epa, total_away_rush_epa, 
    total_home_pass_epa, total_away_pass_epa, air_epa, xyac_epa, xyac_success, 
    xyac_fd, xyac_mean_yardage, xyac_median_yardage, 
    #win probabilities
    home_wp, away_wp, wpa, home_wp_post, away_wp_post, 
    #individual player ids
    passer_player_id, passer_player_name, receiver_player_id, receiver_player_name, 
    rusher_player_id, rusher_player_name,
    #gambling
    result, total, spread_line, total_line
  )

write.csv(reg.szn.clean.cols.15_19, "Derived_Data/NFL.Clean.Cols.csv")