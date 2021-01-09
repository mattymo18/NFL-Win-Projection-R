Usage
-----

You'll need Docker and the ability to run Docker as your current user

Build the container:

    > docker build . -t NFL_Gamble
    
This Docker container is based on rocker/verse. To run rstudio server:

    > docker run -v `pwd`:/home/rstudio -p 8765:8765 -e PASSWORD=mypass -t NFL_Gamble
    
Then connect to the machine on port 8765.

### Make
Use Makefile as recipe book for building artifacts found in derived directories. 

##### Example:
In local project directory, to build artifact

    > make Derived_Data/Ecample.csv

Introduction
------------

This project contains NFLFastR data scraping and modeling for win projection. 

Guide to nflfastR can be found here: https://cran.r-project.org/web/packages/nflfastR/readme/README.html

Glossary
--------

####To dinstinguish between play types:
rush_attempt = 1 0r 0
pass_attempt = 1 or 0
(both 0) = kick, or sack
play_type: NA, kickoff, pass, run, punt, field_goal, extra_point, no_play, qb_spike, qb_kneel

####Game distinction:
game_id : year_month_Awayteam_Hometeam ex: 2010_01_ARI_SF
home_team: Abbreviation of home team
away_team: Abbrevation of away team
season_type: REG or POST

####For game situation:
game_seconds_remaining = 0:3600
half_seconds_remaining = 0:1800
quarter_seconds_remaining = 0:900
home_timeouts_remaining = 0:3
away_timeouts_remaining = 0:3
yrdln = home_team (or away_team) numerical value for yardline
ydstogo = number of yards for a first down or touchdown
total_home_score = 0:99
total_away_score = 0:99

####Timeouts:
timeout_team = home_team (or away_team)
timeout = binary
home_timeouts_remaining = 0:3
away_timeouts_remaining = 0:3

####For play description:
shotgun = binary
no_huddle = binary
qb_dropback = binary
qb_kneel = binary
qb_spike = binary
qb_scramble = binary

####For pass plays:
pass_length = NA, short, deep
air_yards = NA, yards the ball traveled
yards_after_catch

####For run plays:
run_location = NA, left, right, middle
run_gap = NA, tackle, end, guard

####For kicks: 
field_goal_result = NA, made, missed, blocked
kick_distance = yards of kick for punts, 

####For other plays:
extra_point_result = NA, good, failed, blocked
two_point_conv_result = NA, success, failure

####Probabilities:
ep = expected points.
no_score_prob = probability of no more scoring this half. 
opp_fg_prob= probability next score opponent field goal this half. 
opp_safety_prob = probability next score opponent safety this half. 
opp_td_prob = probability of next score opponent touchdown this half. 
fg_prob = probability next score field goal this half.
safety_prob = probability next score safety this half.
td_prob = probability text score touchdown this half.


