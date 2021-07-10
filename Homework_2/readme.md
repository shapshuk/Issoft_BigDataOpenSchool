# Homework 2

This script defines top movies by rating for every mentioned genre. The result is csv-like dataset with the header "genre,title,year,rating".

---

This script can process the following arguments:

`-N` - the number of movies with the highest rating. Optional.

`-genres` - filter by genres. Optional.

`-year_from` - filter by the year of movie creation. Optional.

`-year_to` - filter by the year of movie creation. Optional.

`-regexp` - filter (regular expression) for the movie title. Optional.

If there is no arguments, the script will return the whole dataset of movies sorted by it's rating.

---

Examples of the script execution:

`python get-movies.py`

`python get-movies.py -N 100`

`python get-movies.py -N 10 -genres "Action|Comedy" -year_from 1999 -year_to 2007 -regexp \d`

