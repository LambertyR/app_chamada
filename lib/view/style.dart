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
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      hoverColor: Colors.indigo[900],
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.green), // Cor do texto
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold), // Estilo do texto
        ),
      ),
    ),
    // APP Bar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Icones
    iconTheme: IconThemeData(color: Colors.white),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.green),
      focusColor: Colors.green,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      floatingLabelStyle: TextStyle(
        backgroundColor: Colors.transparent,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Textos

    // Bottom Menu
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white),

    listTileTheme: ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
      tileColor: Colors.grey.shade800,
    ),
  );
}
