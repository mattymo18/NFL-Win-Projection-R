.PHONY: clean

clean: 
	rm Derived_Data/*.csv
	
Derived_Data/NFL.Clean.Cols.csv:\
 tidy_football.R
	Rscript tidy_football.R
	
Derived_Data/Final.Anime.csv\
Dervied_Graphics/Forced.Fumbles.2020.gif:\
 tidy_anime.R
	Rscript tidy_anime.R
	