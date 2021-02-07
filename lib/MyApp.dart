import 'package:flutter/material.dart';

import 'movieInfo.dart';
import 'Result_Page.dart';
import 'home_Page.dart';

class MyApp extends StatelessWidget {
  final secondaryColor = Color(0xff0745ff);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber[700],
        accentColor: Color(0xff0745ff),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/result': (context) => ResultPage(),
        '/movie': (context) => MovieInfo(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
