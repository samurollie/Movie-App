import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_selector/Models/movieList.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<MovieList> futuraLista;
  String search;
  var resultado = new MovieList();

  Future<MovieList> _getMovieList() async {
    final response = await http
        .get('http://www.omdbapi.com/?apikey=5cd3eeca&s=${this.search}');

    if (response.statusCode == 200) {
      return MovieList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load results');
    }
  }

  @override
  void initState() {
    super.initState();
    futuraLista = _getMovieList();

    print(futuraLista);
  }

  @override
  Widget build(BuildContext context) {
    search = ModalRoute.of(context).settings.arguments;

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
        child: FutureBuilder(
          future: futuraLista,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              this.resultado = snapshot.data;
              print(
                  "O nome do primeiro filme e: ${this.resultado.movies[0].title}");
              return Padding(
                // Fazer aqui todo o resultado da página
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      "Exibindo ${snapshot.data.movies.length} resultados para $search:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                        // child: listaFilmes(),
                        ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  listaFilmes() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            resultado.movies[0].title,
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
//http://www.omdbapi.com/?apikey=5cd3eeca&s=$search -> Lista de filmes com aquele nome
//http://www.omdbapi.com/?apikey=5cd3eeca&t=$title -> O filme em si
//http://www.omdbapi.com/?apikey=5cd3eeca&t=shrek -> Retorna Shrek, o filme
//http://www.omdbapi.com/?apikey=5cd3eeca&s=shrek -> Retorna os filmes com shrek no título.

/* Future<http.Response> createMovie(String title) {
      return http.get('http://www.omdbapi.com/?apikey=5cd3eeca&t=$title');
    } 
      // Future filmes =
  //     http.get('http://www.omdbapi.com/?apikey=5cd3eeca&t=$title');
    
    */

/**
     * terminar esse ngc daqui (Pegar o futuraLista do get e passar por coisa do movie.dart) pra retornar o Map com os resultados 
     */
