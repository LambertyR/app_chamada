// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'view/bottom_navigation_bar.dart';
import 'menu_principal.dart';

class Alunos extends StatelessWidget {
  String disciplina = '';

  Alunos({
    required this.disciplina,
  });
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Alunos"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFB617),
                      Colors.yellowAccent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Disciplina: " + disciplina,
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Data: " + formattedDate,
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              gerarCabecalho(),
              gerarAlunos(context),
              Expanded(
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: ElevatedButton(
                      child: const Text('Salvar'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Menu_Principal();
                        }));
                      },
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Bottom_Navigation_Bar(),
      ),
      theme: style(),
    );
  }
}

class _GerarAlunos extends StatefulWidget {
  final String nomeAluno;

  const _GerarAlunos({Key? key, required this.nomeAluno}) : super(key: key);

  @override
  State<_GerarAlunos> createState() => _GerarAlunosState();
}

class _GerarAlunosState extends State<_GerarAlunos> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(widget.nomeAluno),
      trailing: Checkbox(
        side: BorderSide(color: Color(0xFFFFB617)),
        checkColor: Colors.white,
        activeColor: Color(0xFFFFB617),
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

Widget gerarCabecalho() {
  return ListTile(
    title: Text("NOME"),
    trailing: Text(
      "Marcar Falta",
    ),
  );
}

Widget gerarAlunos(context) {
  List<String> nomeAlunos = [
    "Aluno 1",
    "Aluno 2",
    "Aluno 3",
    "Aluno 4",
    "Aluno 5",
    "Aluno 6",
    "Aluno 7",
    "Aluno 8",
    "Aluno 9",
    "Aluno 10",
    "Aluno 11",
    "Aluno 12"
  ];

  List<Widget> alunos = [];

  for (int i = 0; i < nomeAlunos.length; i++) {
    alunos.add(_GerarAlunos(nomeAluno: nomeAlunos[i]));
  }

  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: alunos),
  );
}
