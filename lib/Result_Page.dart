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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                'Resultados de "$search":',
                style: TextStyle(fontSize: 20),
              ),
            ),
            FutureBuilder(
              future: futuraLista,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "Exibindo ${snapshot.data.movies.length} resultados para $search:",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            /*  RaisedButton(
              child: Text('Teste'),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/movie',
                  arguments:
                      search, // <-- Mudar pra o nome do filme selecionado
                );
              },
            ) */
          ],
        ),
      ),
    );
  }

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
