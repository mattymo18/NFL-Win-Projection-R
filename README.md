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

Guide to NFLFast R can be found here: https://cran.r-project.org/web/packages/nflfastR/readme/README.html

