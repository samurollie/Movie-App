import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _movieTitle = '';
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        title: Text('Movie Info'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/img/clapperboard.png',
                  width: 200,
                  height: 200,
                  semanticLabel: 'Claquete indicando o logotipo do Movie Info',
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 15,
                      top: 15,
                    ),
                    child: Text(
                      'Bem vindo ao Movie Info!\nInsira abaixo o filme desejado:',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Insira o nome do filme',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        _movieTitle = text;
                      },
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/result',
                        arguments: _movieTitle,
                      );
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      semanticLabel: "Pesquisar filme",
                    ),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
