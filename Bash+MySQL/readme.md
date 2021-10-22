# Get movie ratings (bash + MySQL)

This script defines top movies by rating for every mentioned genre. The result is tmp.csv file whith fields "title,rating,genre".

---

This script can process the following arguments:

`-n` - the number of movies with the highest rating. Optional.

`-genres` - filter by genres. Optional.

`-year_from` - filter by the year of movie creation. Optional.

`-year_to` - filter by the year of movie creation. Optional.

`-regexp` - filter (regular expression) for the movie title. Optional.

`-setupdb` - downloads .csv-files, initiates tables and infills them. Optional.

If there is no arguments, the script will return the whole dataset of movies sorted by it's rating.

---

Examples of the script execution:

`bash get-movies.sh`

`bash get-movies.sh -n 100`

`bash get-movies.sh -n 10 -genres 'Action|Comedy' -year_from 1999 -year_to 2007 -regexp \d -setupdb`

