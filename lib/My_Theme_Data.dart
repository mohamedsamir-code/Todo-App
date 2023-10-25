import 'package:flutter/material.dart';

class MyThemeData {
  static const Color lightScaffildBackground =
      Color.fromARGB(255, 223, 236, 219);
  static const Color darkScaffildBackground = Color.fromARGB(255, 6, 14, 30);
  static const Color darkContairnerBackground = Color.fromARGB(200, 6, 15, 40);
  static final ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
              fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, color: Colors.black45),
          titleSmall: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: lightScaffildBackground);
  static final ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
              fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, color: Colors.white),
          titleSmall: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: darkScaffildBackground);
}
