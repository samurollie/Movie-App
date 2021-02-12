import 'package:flutter/material.dart';

import 'homePage.dart';
import 'movieInfo.dart';
import 'resultPage.dart';

class MyApp extends StatelessWidget {
  final secondaryColor = Color(0xff0745ff);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange[300],
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
