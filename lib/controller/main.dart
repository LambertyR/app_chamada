import 'package:flutter/material.dart';
import '../view/login.dart';
import '../view/style.dart';

void main() => runApp(new MaterialApp(
      title: "Chamada",
      home: Scaffold(
        body: new MyApp(),
      ),
      debugShowCheckedModeBanner: false,
      theme: style(),
    ));
