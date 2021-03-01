import 'package:flutter/material.dart';

import 'homePage.dart';
import 'movieInfo.dart';
import 'resultPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange[300],
        accentColor: Color(0xff0745ff),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.deepOrange[300],
          thickness: 5,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
