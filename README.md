Usage
-----

You'll need Docker and the ability to run Docker as your current user

Build the container:

    > docker build . -t nfl_gamble
    
This Docker container is based on rocker/verse. To run rstudio server:

    > docker run -v `pwd`:/home/rstudio -p 8787:8787 -e PASSWORD=mypass -t nfl_gamble
    
Then connect to the machine on port 8787.

***

### Make
Use Makefile as recipe book for building artifacts found in derived directories. 

##### Example:
In local project directory, to build artifact

    > make Derived_Data/NFL.Clean.Cols.csv
    
***

Introduction
------------

This project contains NFLFastR data gathering and modeling.  

Guide to nflfastR can be found [Here](https://cran.r-project.org/web/packages/nflfastR/readme/README.html)

***

Introductory Plots
------------------


![](README_Graphics/Forced.Fumbles.2020.gif)

![](README_Graphics/PAM.Cluster.Logos.pn

