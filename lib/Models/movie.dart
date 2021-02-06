import 'package:flutter/material.dart';

/* part 'movie.g.dart';

@JsonSerializable() */
class Movie {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbRating;
  String type;
  String imdbID;

  /* Movie();

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  toJson() => _$MovieToJson(this); */

  Movie({
    this.imdbID,
    this.metascore,
    this.imdbRating,
    this.type,
    this.plot,
    this.poster,
    @required this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.language,
    this.country,
    this.awards,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Mapeamento do Json para um Map
    return Movie(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbID: json['imdbID'],
      type: json['Type'],
    );
  }
}
