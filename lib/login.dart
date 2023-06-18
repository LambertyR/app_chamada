// ignore_for_file: prefer_const_constructors
import 'package:chamada_univel/recuperar_senha.dart';
import 'package:flutter/material.dart';

import 'menu_principal.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text('',
                    style: TextStyle(
                      fontSize: 20,
                    ))),
            Container(
              padding: const EdgeInsets.all(10),
              // ignore: prefer_const_constructors
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
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
                  child: const Text('Login'),
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
            // ignore: sort_child_properties_last
            Row(children: <Widget>[
              TextButton(
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('Cadastre aqui');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Cadastro()),
                    // );
                  })
            ], mainAxisAlignment: MainAxisAlignment.center),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Recuperar_Senha();
                }));
              },
              child: const Text(
                'Esqueci a senha',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
