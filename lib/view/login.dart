// ignore_for_file: prefer_const_constructors
import 'package:chamada_univel/view/recuperar_senha.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';

import '../menu_principal.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chamada Online'),
        ),
        body: Login(),
      ),
      theme: style(),
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
              padding: const EdgeInsets.all(10),
              // ignore: prefer_const_constructors
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Login',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  filled: true,
                ),
              ),
            ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  child: const Text('Login'),
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
              ),
            ),
          ],
        ));
  }
}
