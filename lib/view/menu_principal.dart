// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/add_disciplina.dart';
import 'package:chamada_univel/view/bottom_navigation_bar.dart';
import 'package:chamada_univel/view/disciplinas.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';

class Menu_Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Disciplinas'),
        ),
        body: Disciplinas(),
        bottomNavigationBar: Bottom_Navigation_Bar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddDisciplina();
            }));
          },
          child: Icon(Icons.add_rounded),
        ),
      ),
      theme: style(),
    );
  }
}
