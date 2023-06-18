// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData style() {
  ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.red,
    colorScheme: ColorScheme.light(),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: Color.fromARGB(255, 24, 45, 233)),

    //Botão flutuante
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFB617),
      foregroundColor: Colors.white,
      hoverColor: Colors.indigo[900],
    ),
    scaffoldBackgroundColor: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFB617),
          foregroundColor: Colors.indigo[900],
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Color(0xFFFFB617)), // Cor do texto
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold), // Estilo do texto
        ),
      ),
    ),
    // APP Bar
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFB617),
      iconTheme: IconThemeData(color: Colors.indigo[900]),
      titleTextStyle: TextStyle(
        color: Colors.indigo[900],
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Icones
    iconTheme: IconThemeData(color: Colors.indigo[900]),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Color(0xFFFFB617),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      floatingLabelStyle: TextStyle(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Textos
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    // Bottom Menu
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFB617),
        unselectedItemColor: Colors.indigo[900],
        selectedItemColor: Colors.indigo[900]),
    listTileTheme: ListTileThemeData(
      textColor: Color(0xFFFFB617),
      iconColor: Color(0xFFFFB617),
      tileColor: Colors.indigo[600],
    ),
  );
}
