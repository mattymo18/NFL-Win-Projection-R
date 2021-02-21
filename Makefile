.PHONY: clean

clean: 
	rm Derived_Data/*.csv
	rm Derived_Graphics/*.png
	rm Derived_Graphics/*.gif
	rm README_Graphics/*.png
	rm README_Graphics/*.png
	
Derived_Data/NFL.Clean.Cols.csv:\
 tidy_football.R
	Rscript tidy_football.R
	
Derived_Data/Final.Anime.csv\
README_Graphics/Forced.Fumbles.2020.gif:\
 tidy_anime.R
	Rscript tidy_anime.R
	
README_Graphics/PAM.Cluster.Logos.png:\
 Derived_Data/NFL.Clean.Cols.csv\
 nfl_cluster.R
	Rscript nfl_cluster.R