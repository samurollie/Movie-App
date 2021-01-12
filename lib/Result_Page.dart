import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final String _movieTitle = ModalRoute.of(context).settings.arguments;

    Future<http.Response> createMovie(String title) {
      return http.get('http://www.omdbapi.com/?apikey=5cd3eeca&t=$title');
    }

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
                'Resultados de "$_movieTitle":',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RaisedButton(
              child: Text('Teste'),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/movie',
                  arguments:
                      _movieTitle, // <-- Mudar pra o nome do filme selecionado
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
