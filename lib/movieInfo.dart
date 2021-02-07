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
          return Column(
            children: [
              Container(
                color: Colors.amberAccent,
                width: double.infinity + 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${myMovie.title} (${myMovie.year})",
                    style: TextStyle(fontSize: 40),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                child: myMovieScreen(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget myMovieScreen() {
    /* String poster_url =
        (this.myMovie.poster == "N/A") ? "" : this.myMovie.poster; */

    return ListView(
      children: [
        Container(
          height: 10,
        ),
        Container(
          width: 300,
          height: 300,
          child: Image.network((this.myMovie.poster == "N/A")
              ? "https://via.placeholder.com/300x300?text=Not+Found"
              : this.myMovie.poster),
        ),
        Container(
          height: 10,
        ),
        Divider(
          color: Colors.blueGrey,
          thickness: 2.5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
          child: Text(
            "${this.myMovie.plot}",
            textAlign: TextAlign.justify,
          ),
        ),
        Divider(
          color: Colors.blueGrey,
          thickness: 2.5,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
          child: Text(
            "Genres: ${this.myMovie.genre}",
            textDirection: TextDirection.ltr,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
          child: Text(
            "${this.myMovie.actors}",
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
