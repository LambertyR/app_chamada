// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/aluno_sqlite_datasource.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/presenca_entity.dart';
import 'package:chamada_univel/data/presenca_sqlite_datasource.dart';
import 'package:chamada_univel/view/add_aluno.dart';
import 'package:chamada_univel/view/alunos.dart';
import 'package:chamada_univel/view/menu_principal.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'add_disciplina.dart';
import 'bottom_navigation_bar.dart';

class alunosPresentes extends StatelessWidget {
  DisciplinaEntity disciplina;
  DateTime data;
  alunosPresentes({
    required this.disciplina,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: disciplina.nome!,
      theme: style(),
      home: _alunosPresentes(disciplina: disciplina, data: data),
    );
  }
}

class _alunosPresentes extends StatefulWidget {
  DisciplinaEntity disciplina;
  DateTime data;
  _alunosPresentes({
    required this.disciplina,
    required this.data,
  });
  @override
  _alunosPresentesHP createState() =>
      _alunosPresentesHP(disciplina: disciplina, data: data);
}

class _alunosPresentesHP extends State<_alunosPresentes> {
  DisciplinaEntity disciplina;
  DateTime data;
  _alunosPresentesHP({
    required this.disciplina,
    required this.data,
  });

  @override
  void didUpdateWidget(_alunosPresentes oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_Navigation_Bar(),
      appBar: AppBar(
        title: Text('Presenças de ${disciplina.nome}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MenuPrincipal())),
        ),
      ),
      body: FutureBuilder<List<PresencaEntity>>(
        future:
            PresencaSQLiteDataSource().getAllPresencaPorData(disciplina, data),
        builder: (BuildContext context,
            AsyncSnapshot<List<PresencaEntity>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                PresencaEntity item = snapshot.data![index];
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(item.data!);

                return ListTile(
                  title: Text(
                    item.aluno_disciplina!.aluno!.nome.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.person),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       PresencaSQLiteDataSource().deletarPresencas();
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => Alunos(disciplina: disciplina)));
      //     })
    );
  }
}
