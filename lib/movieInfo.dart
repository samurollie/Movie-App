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
          return Text(
            myMovie.title,
            style: TextStyle(fontSize: 45),
            textDirection: TextDirection.rtl,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Widget myMovieScreen() {
    /* String poster_url =
        (this.myMovie.poster == "N/A") ? "" : this.myMovie.poster; */

    return Column(
      children: [
        futureResponse(),
        Container(
          width: 300,
          height: 300,
          child: Image.network(
              (this.myMovie.poster == "N/A") ? "" : this.myMovie.poster),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
        centerTitle: true,
      ),
      body: myMovieScreen(),
    );
  }
}
