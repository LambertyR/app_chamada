// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/aluno_sqlite_datasource.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/view/add_aluno.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'add_disciplina.dart';
import 'bottom_navigation_bar.dart';
import 'menu_principal_copy.dart';

class Alunos extends StatelessWidget {
  DisciplinaEntity disciplina;

  Alunos({
    required this.disciplina,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: disciplina.nome!,
      theme: style(),
      home: AlunosHP(disciplina: disciplina),
    );
  }
}

class AlunosHP extends StatefulWidget {
  late DisciplinaEntity disciplina;

  AlunosHP({
    required this.disciplina,
  });
  @override
  _AlunosHP createState() => _AlunosHP(disciplina: disciplina);
}

class _AlunosHP extends State<AlunosHP> {
  late DisciplinaEntity disciplina;
  List<bool> isChecked = List<bool>.filled(100, false, growable: true);
  _AlunosHP({
    required this.disciplina,
  });

  @override
  void didUpdateWidget(AlunosHP oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_Navigation_Bar(),
      appBar: AppBar(
        title: Text(disciplina.nome as String),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                AlunoDisciplinaSQLiteDataSource()
                    .deletarAlunoPorDisciplina(disciplina);
                setState(() {});
              },
              child: Text(
                "Excluir Todos",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<AlunoDisciplinaEntity>>(
        future: AlunoDisciplinaSQLiteDataSource()
            .getAlunosPorDisciplina(disciplina),
        builder: (BuildContext context,
            AsyncSnapshot<List<AlunoDisciplinaEntity>> snapshot) {
          if (snapshot.hasData && snapshot != []) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                //isChecked.length = snapshot.data!.length;
                AlunoDisciplinaEntity item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.green),
                  onDismissed: (direction) {
                    setState(() {});
                    AlunoDisciplinaSQLiteDataSource()
                        .deletarAlunoDisciplina(item);
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(item.aluno?.nome as String),
                    trailing: Checkbox(
                      side: BorderSide(color: Colors.white),
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: isChecked[index],
                      onChanged: (value) {
                        setState(() {
                          isChecked[index] = value!;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAluno(disciplina: disciplina)));
        },
      ),
    );
  }
}
/*
class _GerarAlunos extends StatefulWidget {
  AlunoDisciplinaEntity aluno_disciplina;

  _GerarAlunos({Key? key, required this.aluno_disciplina}) : super(key: key);

  @override
  State<_GerarAlunos> createState() =>
      _GerarAlunosState(aluno_disciplina: aluno_disciplina);
}

class _GerarAlunosState extends State<_GerarAlunos> {
  bool isChecked = false;
  late AlunoDisciplinaEntity aluno_disciplina;

  _GerarAlunosState({
    required this.aluno_disciplina,
  });

  @override
  Widget build(BuildContext context) {
    return 
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
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.green,
                      Colors.green.shade900,
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
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Data: " + formattedDate,
                      style: TextStyle(
                        color: Colors.white,
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
                        Navigator.pop(context, false);
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
*/