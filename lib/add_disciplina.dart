// ignore_for_file: prefer_const_constructors
//import 'package:chamada_univel/recuperar_senha.dart';
import 'package:flutter/material.dart';

import 'menu_principal.dart';

class AddDisciplina extends StatelessWidget {
  const AddDisciplina({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chamada Online'),
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Color.fromARGB(255, 26, 26, 26),
        body: Login(),
      ),
    );
  }
}

class Login extends StatelessWidget {
  String email = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 50, top: 30),
                child: const Text(
                  'Adicionar Disciplina',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              // ignore: prefer_const_constructors
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome da Disciplina',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  floatingLabelStyle: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  child: const Text('Adicionar'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Menu_Principal();
                    }));
                  },
                )),
          ],
        ));
  }
}
