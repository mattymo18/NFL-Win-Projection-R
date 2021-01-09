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

#### To dinstinguish between play types:
rush_attempt = 1 0r 0 <br />
pass_attempt = 1 or 0 <br />
(both 0) = kick, or sack <br />
play_type: NA, kickoff, pass, run, punt, field_goal, extra_point, no_play, qb_spike, qb_kneel <br />

#### Game distinction:
game_id : year_month_Awayteam_Hometeam ex: 2010_01_ARI_SF <br />
home_team: Abbreviation of home team <br />
away_team: Abbrevation of away team <br />
season_type: REG or POST <br />

#### For game situation:
game_seconds_remaining = 0:3600 <br />
half_seconds_remaining = 0:1800 <br />
quarter_seconds_remaining = 0:900 <br />
home_timeouts_remaining = 0:3 <br />
away_timeouts_remaining = 0:3 <br />
yrdln = home_team (or away_team) numerical value for yardline <br />
ydstogo = number of yards for a first down or touchdown <br />
total_home_score = 0:99 <br />
total_away_score = 0:99 <br />

#### Timeouts:
timeout_team = home_team (or away_team) <br />
timeout = binary <br />
home_timeouts_remaining = 0:3 <br />
away_timeouts_remaining = 0:3 <br />

#### For play description:
shotgun = binary <br />
no_huddle = binary <br />
qb_dropback = binary <br />
qb_kneel = binary <br />
qb_spike = binary <br />
qb_scramble = binary <br />

#### For pass plays:
pass_length = NA, short, deep <br />
air_yards = NA, yards the ball traveled <br />
yards_after_catch <br />

#### For run plays:
run_location = NA, left, right, middle <br />
run_gap = NA, tackle, end, guard <br />

#### For kicks: 
field_goal_result = NA, made, missed, blocked <br />
kick_distance = yards of kick or punt <br />

#### For other plays:
extra_point_result = NA, good, failed, blocked <br />
two_point_conv_result = NA, success, failure <br />

#### Probabilities:
ep = expected points <br />
no_score_prob = probability of no more scoring this half <br />
opp_fg_prob= probability next score opponent field goal this half <br />
opp_safety_prob = probability next score opponent safety this half <br />
opp_td_prob = probability of next score opponent touchdown this half <br />
fg_prob = probability next score field goal this half <br />
safety_prob = probability next score safety this half <br />
td_prob = probability text score touchdown this half <br />

##### All Binaries: 1 = True, 0 = False


