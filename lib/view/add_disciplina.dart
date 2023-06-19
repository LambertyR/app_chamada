// ignore_for_file: prefer_const_constructors
//import 'package:chamada_univel/recuperar_senha.dart';
import 'package:chamada_univel/view/bottom_navigation_bar.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';

import 'menu_principal.dart';

class AddDisciplina extends StatelessWidget {
  const AddDisciplina({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Adicionar Disciplina'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: _AddDisciplina(),
        bottomNavigationBar: Bottom_Navigation_Bar(),
      ),
      theme: style(),
    );
  }
}

class _AddDisciplina extends StatelessWidget {
  String email = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            // Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.all(10),
            //     margin: const EdgeInsets.only(bottom: 50, top: 30),
            //     child: const Text(

            //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            //     )),

            Container(
              padding: const EdgeInsets.all(10),

              // ignore: prefer_const_constructors
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Nome da Disciplina',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  child: const Text('Adicionar'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                )),
          ],
        ));
  }
}
