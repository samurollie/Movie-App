import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String _movieTitle;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Movie Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AssetImgOnCircle(
              path: 'assets/img/clapperboard.png',
              label: 'Claquete indicando o logotipo do Movie Info',
              color: Colors.white,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                children: [
                  Container(height: 15),
                  Text(
                    'Bem vindo ao Movie Info!\nInsira abaixo o filme desejado:',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Insira o nome do filme',
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      onChanged: (text) {
                        _movieTitle = text;
                      },
                    ),
                  ),
                  Container(height: 15),
                  RaisedButton(
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                      semanticLabel: "Pesquisar filme",
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/result',
                        arguments: _movieTitle,
                      );
                    },
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

class AssetImgOnCircle extends StatelessWidget {
  final String path;
  final String label;
  final Color color;

  const AssetImgOnCircle(
      {Key key, @required this.path, this.label, @required this.color})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        this.path,
        semanticLabel: this.label,
      ),
    );
  }
}
