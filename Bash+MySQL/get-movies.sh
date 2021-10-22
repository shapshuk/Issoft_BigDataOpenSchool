N=NULL
GENRES=NULL
YEAR_FROM=NULL
YEAR_TO=NULL
REGEXP=NULL
SETUPDB=false

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -n)
      N="$2"
      shift # past argument
      shift # past value
      ;;
    -genres)
      GENRES="'$2'"
      shift # past argument
      shift # past value
      ;;
    -year_from)
      YEAR_FROM="$2"
      shift # past argument
      shift # past value
      ;;
    -year_to)
      YEAR_TO="$2"
      shift # past argument
      shift # past argumenT
    ;;
    -regexp)
      REGEXP="'$2'"
      shift # past argument
      shift # past value
      ;;
    -setupdb)
      SETUPDB=true
      shift # past argument
      ;;  
  esac

done

    echo "$GENRES"
    echo Print username and password

    read -p 'Username: ' username
    read -sp 'Password: ' password

    echo 

if [ "$SETUPDB" = true ] ; then
    wget -q https://files.grouplens.org/datasets/movielens/ml-latest-small.zip
    unzip -u -q ml-latest-small.zip ml-latest-small/movies.csv ml-latest-small/ratings.csv
    sudo cp ml-latest-small/*.csv /var/lib/mysql-files/
    rm -r ml-latest-small.zip ml-latest-small
    mysql --user="${username}" --password="${password}"  < initalization.sql
    mysql --user="${username}" --password="${password}"  < usp_find_top_rated_movies.sql
fi    
    # mysql --batch --user="${username}" --password="${password}" --database="movie_ratings_db" --execute="CALL usp_find_top_rated_movies(${N}, '${REGEXP}', ${YEAR_FROM}, ${YEAR_TO}, '${GENRES}');" | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g"
    # echo "CALL usp_find_top_rated_movies(${N}, ${REGEXP}, ${YEAR_FROM}, ${YEAR_TO}, ${GENRES});"
    mysql --database=movie_ratings_db -B -r -s --user=$username --password=$password -e "CALL usp_find_top_rated_movies(${N}, ${REGEXP}, ${YEAR_FROM}, ${YEAR_TO}, ${GENRES});" | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > tmp.csv 



