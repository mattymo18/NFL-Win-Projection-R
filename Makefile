.PHONY: clean

clean: 
	rm Derived_Data/*.csv
	
Derived_Data/NFL.Clean.Cols.csv:\
 tidy_football.R
	Rscript tidy_football.R