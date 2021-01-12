import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _movieTitle = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieTitle),
      ),
    );
  }
}
