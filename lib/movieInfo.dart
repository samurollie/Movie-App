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

        // By default, show a loading spinner.
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget myMovieScreen() {
    /* String poster_url =
        (this.myMovie.poster == "N/A") ? "" : this.myMovie.poster; */
    String posterUrl = (this.myMovie.poster == "N/A")
        ? "https://via.placeholder.com/300x300?text=Not+Found"
        : this.myMovie.poster;

    return ListView(
      children: [
        Divider(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
        Container(
          // width: 300,
          height: 280,
          child: Image.network(posterUrl),
        ),
        Container(
          height: 10,
        ),
        Divider(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          child: Text(
            "${this.myMovie.plot}",
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Divider(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          child: Text(
            "Generos: ${this.myMovie.genre}",
            style: TextStyle(fontSize: 15),
          ),
        ),
        Divider(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          child: Text(
            "Estrelando: ${this.myMovie.actors}",
          ),
        ),
        Divider(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
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
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        title: Container(
          height: 30,
          child: Image.asset('assets/img/clapperboard.png'),
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
