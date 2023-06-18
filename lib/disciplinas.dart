// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:chamada_univel/alunos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'login.dart';

class Disciplinas extends StatelessWidget {
  const Disciplinas({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        gerarDisciplinas(context),
      ],
    );
  }
}

Widget gerarDisciplinas(context) {
  List<String> nomeDisciplinas = [
    "Matematica",
    "Português",
    "Educação Física",
    "História",
    "Geografia"
  ];

  List<Widget> disciplinas = [];

  for (int i = 0; i < nomeDisciplinas.length; i++) {
    disciplinas.add(disciplinaCard(context, nomeDisciplinas[i]));
  }

  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: disciplinas),
  );
}

Widget disciplinaCard(context, String nomeDisciplina) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return new Alunos(disciplina: nomeDisciplina);
        }),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.purple,
            Colors.purpleAccent,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NomeDiscipina(nomeDisciplina),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight, child: SetaDireita()))
        ],
      ),
    ),
  );
}

Widget SetaDireita() {
  return Container(
    alignment: Alignment.centerRight,
    child: Icon(
      Icons.arrow_forward_rounded,
      color: Colors.white,
      size: 50,
    ),
  );
}

Widget NomeDiscipina(String nomeDisciplina) {
  return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: Column(children: [
        Text(
          nomeDisciplina,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 35),
        )
      ]));
}
