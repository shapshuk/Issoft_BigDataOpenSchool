import csv
import re
from argparse import ArgumentParser

RATINGS_PATH = "ml-latest-small/ratings.csv" 
MOVIES_PATH = "ml-latest-small/movies.csv"

class Movie:
    rating = 0
    ratings_sum = 0
    ratings_counter = 0

    # parsing movies.csv to movie objects
    def __init__(self, row):
        self.id = int(row[0])
        self.title = re.sub('\ \((\d*?)\)', '', row[1].replace('"', ''))
        self.genres = row[2]
        match = re.search('(?<=\()\d+?(?=\))', row[1])
        if match:
            self.year = int(match.group())
        else:
            self.year = 0

    def __str__(self) -> str:
        return f"{self.genres},{self.title},{self.year},{self.rating}"


def count_ratings(movie_dict):
    with open(RATINGS_PATH, "r") as ratings_f:
        ratings_reader=csv.reader(ratings_f)
        next(ratings_reader, None)
        for row in ratings_reader:
            try:
                movie_id = int(row[1]) 
                movie_dict[movie_id].ratings_sum += float(row[2])
                movie_dict[movie_id].ratings_counter += 1
            except IndexError:
                print(row)
    for movie in movie_dict.values():
        if movie.ratings_counter >= 1:
            movie.rating = round(movie.ratings_sum / movie.ratings_counter, 1)        
        else:
            movie.rating = 0

# this function returns all movies sorted by rating as movie_list
def get_movie_list():
    with open(MOVIES_PATH, "r") as movies_f:
        movie_reader = csv.reader(movies_f)
        movie_dict = {}
        next(movie_reader, None)

        for row in movie_reader:
            movie = Movie(row)
            movie_dict[movie.id] = movie
        
        count_ratings(movie_dict)
        movie_list = [movie for movie in movie_dict.values()]
        movie_list.sort(key = lambda x: x.rating, reverse = True)
        return movie_list


def filter_by_title(movie_list, regex):
    movie_list = [movie for movie in movie_list if re.search(regex, movie.title)]
    return movie_list


def filter_by_year_from(movie_list, year_from):
    movie_list = [movie for movie in movie_list if movie.year >= year_from]
    return movie_list


def filter_by_year_to(movie_list, year_to):
    movie_list = [movie for movie in movie_list if movie.year <= year_to]
    return movie_list


def get_top_by_genres(movie_list, genres, N):
    N = int(N) if N else len(movie_list)
    # if genres were not provided it will return top N movies from movie list
    # if N is also not provided it will return movie list as is
    if not genres:
        return movie_list[:min(N, len(movie_list))]        
    list = []
    for genre in genres.split('|'):
        filtered = [movie for movie in movie_list if genre.lower() in movie.genres.lower()]
        list += filtered[:min(N, len(filtered))]
    return list
            

def print_result(movie_list):
    print("genre,title,year,rating")
    for movie in movie_list:
        print(movie)


if __name__ == "__main__":
    parser = ArgumentParser()
    
    # parsing input arguments string
    parser.add_argument("-N")
    parser.add_argument("-genres")
    parser.add_argument("-year_from")
    parser.add_argument("-year_to")
    parser.add_argument("-regexp")

    args = parser.parse_args()

    movie_list = get_movie_list()

    if args.year_from:
        movie_list = filter_by_year_from(movie_list, int(args.year_from))
    if args.year_to:
        movie_list = filter_by_year_to(movie_list, int(args.year_to))
    if args.regexp:
        movie_list = filter_by_title(movie_list, args.regexp)

    movie_list = get_top_by_genres(movie_list, args.genres, args.N)

    print_result(movie_list)
    