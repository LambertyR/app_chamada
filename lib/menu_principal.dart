// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/add_disciplina.dart';
import 'package:chamada_univel/bottom_navigation_bar.dart';
import 'package:chamada_univel/disciplinas.dart';
import 'package:flutter/material.dart';

class Menu_Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Disciplinas'),
        ),
        backgroundColor: Color.fromARGB(255, 26, 26, 26),
        body: Disciplinas(),
        bottomNavigationBar: Bottom_Navigation_Bar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          hoverColor: Colors.amber,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddDisciplina();
            }));
          },
          child: Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
