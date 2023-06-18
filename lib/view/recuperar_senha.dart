
// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Recuperar_Senha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text("Recuperar Senha"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context, false),
            )),
        body: _Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.email),
        ),
      ),
      theme: style(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: [sizedBox(), textoMaior(), textoMenor(), fieldEmail()],
        ));
  }
}

Widget textoMaior() {
  return Text(
    'Recuperar Senha',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}

Widget textoMenor() {
  return Text(
    'Informe o E-mail do cadastro',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}

Widget fieldEmail() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: "E-mail",
    ),
  );
}

Widget sizedBox() {
  return SizedBox(
    width: 200,
    height: 200,
    child: Image.network(
        "https://cdn.pixabay.com/photo/2019/10/06/11/40/lock-4529981_960_720.png"),
  );
}
