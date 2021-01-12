class Movie {
  final String title;

  Movie({this.title});
  // Future filmes =
  //     http.get('http://www.omdbapi.com/?apikey=5cd3eeca&t=$title');

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json['Title']);
  }
}
