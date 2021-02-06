import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

// part 'movieList.g.dart';

@JsonSerializable()
class MovieList {
  List<Movie> movies;
  String totalResults;
  String response;

  /* MovieList();
  factory MovieList.fromJson(Map<String, dynamic> json) =>
      _$MovieListFromJson(json);

  toJson() => _$MovieListToJson(this); */
  MovieList({this.movies, this.totalResults, this.response});

  MovieList.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      // Resultou em alguma coisa
      movies = new List<Movie>(); // Crio uma lista de filmes
      json['Search'].forEach((v) {
        // Pego cada um dos filmes e salvo na lista
        movies.add(new Movie.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }
}
