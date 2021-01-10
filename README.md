Usage
-----

You'll need Docker and the ability to run Docker as your current user

Build the container:

    > docker build . -t NFL_Gamble
    
This Docker container is based on rocker/verse. To run rstudio server:

    > docker run -v `pwd`:/home/rstudio -p 8765:8765 -e PASSWORD=mypass -t NFL_Gamble
    
Then connect to the machine on port 8765.

***

### Make
Use Makefile as recipe book for building artifacts found in derived directories. 

##### Example:
In local project directory, to build artifact

    > make Derived_Data/Ecample.csv
    
***

Introduction
------------

This project contains NFLFastR data scraping and modeling for win projection. 

Guide to nflfastR can be found here: https://cran.r-project.org/web/packages/nflfastR/readme/README.html

***

Glossary
--------

#### To dinstinguish between play types:
rush_attempt = 1 or 0 <br />
pass_attempt = 1 or 0 <br />
(both 0) = kick, or sack <br />
play_type: NA, kickoff, pass, run, punt, field_goal, extra_point, no_play, qb_spike, qb_kneel <br />

***

#### Game distinction:
game_id : year_month_Awayteam_Hometeam ex: 2010_01_ARI_SF <br />
home_team: Abbreviation of home team <br />
away_team: Abbrevation of away team <br />
season_type: REG or POST <br />

***

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

***

#### Timeouts:
timeout_team = home_team (or away_team) <br />
timeout = binary <br />
home_timeouts_remaining = 0:3 <br />
away_timeouts_remaining = 0:3 <br />

***

#### For play description:
shotgun = binary <br />
no_huddle = binary <br />
qb_dropback = binary <br />
qb_kneel = binary <br />
qb_spike = binary <br />
qb_scramble = binary <br />

***

#### For pass plays:
pass_length = NA, short, deep <br />
air_yards = NA, yards the ball traveled <br />
yards_after_catch = yards gained between time of catch and time of tackle or score <br />

***

#### For run plays:
run_location = NA, left, right, middle <br />
run_gap = NA, tackle, end, guard <br />

***

#### For kicks: 
field_goal_result = NA, made, missed, blocked <br />
kick_distance = yards of kick or punt <br />

***

#### For other plays:
extra_point_result = NA, good, failed, blocked <br />
two_point_conv_result = NA, success, failure <br />

***

#### Probabilities:
no_score_prob = probability of no more scoring this half <br />
opp_fg_prob= probability next score opponent field goal this half <br />
opp_safety_prob = probability next score opponent safety this half <br />
opp_td_prob = probability of next score opponent touchdown this half <br />
fg_prob = probability next score field goal this half <br />
safety_prob = probability next score safety this half <br />
td_prob = probability next score touchdown this half <br />
extra_point_prob = probability next score extra point this half <br />
two_point_conversion_prob = probability next score 2-pt conversion this half <br />

***

#### Expected Values:
ep = expected points <br />
epa = Calculated by subtracting ep of current spot by ep of previous spot at the beginning of each play <br />
total_home_epa = aggregate of home team's epa <br />
total_away_epa = aggregate of away team's epa <br />
total_home_rush_epa = aggregate of home team's epa on rushing plays <br />
total_away_rush_epa = aggregate of away team's epa on rushing plays <br />
total_home_pass_epa = aggregate of home team's epa on passing plays <br />
total_away_pass_epa = aggregate of away team's epa on passing plays <br />
air_epa = epa on pass plays = <br />
xyac_epa = expected value of epa gained after the catch, starting from where the catch was made. Zero yards after the catch would be listed as zero epa <br />
xyac_success = probability play earns positive epa (relative to where play started) based on where ball was caught <br />
xyac_fd = probability play earns a first down based on where the ball was caught <br />
xyac_mean_yardage = average expected yards after the catch based on where the ball was caught <br />
xyac_median_yardage median expected yards after the catch base donw here the ball was caught <br />

##### All Binaries: 1 = True, 0 = False
##### ep calculation from formulation [here:] (https://www.advancedfootballanalytics.com/index.php/home/stats/stats-explained/expected-points-and-epa-explained) <br />


