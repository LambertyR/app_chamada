// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/aluno_sqlite_datasource.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/presenca_entity.dart';
import 'package:chamada_univel/data/presenca_sqlite_datasource.dart';
import 'package:chamada_univel/view/add_aluno.dart';
import 'package:chamada_univel/view/listar_presencas.dart';
import 'package:chamada_univel/view/menu_principal.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'add_disciplina.dart';
import 'bottom_navigation_bar.dart';

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
  List<AlunoDisciplinaEntity> alunoPresente = [];

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
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MenuPrincipal())),
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
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<AlunoDisciplinaEntity>>(
                future: AlunoDisciplinaSQLiteDataSource()
                    .getAlunosPorDisciplina(disciplina),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AlunoDisciplinaEntity>> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        AlunoDisciplinaEntity item = snapshot.data![index];
                        if (!alunoPresente.any((element) =>
                            element.aluno_disciplinaID ==
                            item.aluno_disciplinaID)) {
                          alunoPresente.add(item);
                        }
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
                                  item.falta = value;
                                  if (item.falta!) {
                                    alunoPresente.removeWhere((aluno) =>
                                        aluno.aluno_disciplinaID ==
                                        item.aluno_disciplinaID);
                                  } else {
                                    alunoPresente.add(item);
                                  }
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Presenca(disciplina: disciplina)));
                },
                child: Text('Listar Presenças'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < alunoPresente.length; i++) {
                    if (!alunoPresente[i].falta!) {
                      PresencaEntity presenca = PresencaEntity();
                      presenca.aluno_disciplina = alunoPresente[i];
                      presenca.data = DateTime.parse(
                          DateFormat('yyyy-MM-dd').format(DateTime.now()));

                      PresencaSQLiteDataSource().create(presenca);
                    }
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Presenças Marcadas!"),
                        );
                      });
                },
                child: Text('Salvar Presenças'),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddAluno(disciplina: disciplina)));
            }));
  }
}
