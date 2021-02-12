import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_selector/Models/movieList.dart';

import 'Models/movie.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<MovieList> futuraLista;
  String search;

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

    Future.delayed(Duration.zero, () {
      setState(() {
        this.search = ModalRoute.of(context).settings.arguments;
      });
      print(this.search);
      // _yourFunction(args);
      futuraLista = _getMovieList();
    });

    print(futuraLista);
  }

  Widget listaDeFilmes(List<Movie> resultado) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: resultado.length,
      itemBuilder: (context, i) {
        print(i);
        return _buildRow(resultado[i]);
      },
    );
  }

  Widget _buildRow(Movie movie) {
    String poster = (movie.poster == "N/A")
        ? "https://via.placeholder.com/300x300?text=Not+Found"
        : movie.poster;

    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: ListTile(
        // dense: true,
        leading: Image.network(poster),
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          movie.year,
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {
          setState(() {
            Navigator.of(context).pushNamed(
              '/movie',
              arguments: movie.title,
            );
          });
        },
      ),
    );
  }

  Widget myTileText(Movie movie) {
    return Text(
      """
Titulo: ${movie.title}\n
Ano de lançamento: ${movie.year}\n""",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget futureResponse() {
    return FutureBuilder(
      future: futuraLista,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var resultado = <Movie>[];

          for (Movie i in snapshot.data.movies) {
            resultado.add(i);
          }
          return Column(
            children: [
              Text(
                "Exibindo resultados para '$search':",
                style: TextStyle(fontSize: 20),
              ),
              Flexible(
                child: listaDeFilmes(resultado),
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    // this.search = ModalRoute.of(context).settings.arguments;
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
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: futureResponse(),
        ),
      ),
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
