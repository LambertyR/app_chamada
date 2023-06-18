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
      hoverColor: Colors.blue,
    ),
    scaffoldBackgroundColor: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFB617),
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
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFB617),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      floatingLabelStyle: TextStyle(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
