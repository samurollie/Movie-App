import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/movie.dart';

class MovieInfo extends StatefulWidget {
  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  Future<Movie> futuroFilme;
  String movieTitle;
  Movie myMovie;

  Future<Movie> _getMovie() async {
    final response = await http
        .get('http://www.omdbapi.com/?apikey=5cd3eeca&t=${this.movieTitle}');

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load results');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        this.movieTitle = ModalRoute.of(context).settings.arguments;
      });
      futuroFilme = _getMovie();
    });
  }

  Widget futureResponse() {
    return FutureBuilder(
      future: futuroFilme,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          myMovie = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${myMovie.title} (${myMovie.year})",
                      style: TextStyle(fontSize: 40),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      semanticsLabel:
                          "${myMovie.title} (${myMovie.year}.\nSinopse:${this.myMovie.plot}.\nGeneros: ${this.myMovie.genre}.\nEstrelando: ${this.myMovie.actors}.\nIMDB Rating: ${this.myMovie.imdbRating}.\nIMDB ID: ${this.myMovie.imdbID}.",
                    ),
                  ),
                  Flexible(
                    child: myMovieScreen(),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Semantics(
          label: "Aguarde, carregando resultados!",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  Widget myMovieScreen() {
    String posterUrl = (this.myMovie.poster == "N/A")
        ? "https://via.placeholder.com/300x300?text=Not+Found"
        : this.myMovie.poster;

    return ListView(
      children: [
        Divider(),
        Image.network(
          posterUrl,
          semanticLabel: "Pôster do filme ${this.myMovie.title}",
          height: 280,
        ),
        Container(
          height: 10,
        ),
        Divider(),
        MovieInfoPageText(
          text: "${this.myMovie.plot}",
          fontStyle: FontStyle.italic,
        ),
        Divider(),
        MovieInfoPageText(
          text: "Generos: ${this.myMovie.genre}",
          fontStyle: FontStyle.normal,
        ),
        Divider(),
        MovieInfoPageText(
          text: "Estrelando: ${this.myMovie.actors}",
          fontStyle: FontStyle.normal,
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("IMDB Rating: ${this.myMovie.imdbRating}"),
              Text("IMDB ID: ${this.myMovie.imdbID}"),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Image.asset(
          'assets/img/clapperboard.png',
          semanticLabel: "Movie Info",
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: futureResponse(),
      ),
    );
  }
}

class MovieInfoPageText extends StatelessWidget {
  final String text;
  final fontStyle;

  MovieInfoPageText({Key key, @required this.text, @required this.fontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 15, fontStyle: this.fontStyle),
      ),
    );
  }
}
