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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
        centerTitle: true,
      ),
    );
  }
}
