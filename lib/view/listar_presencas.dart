// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/aluno_sqlite_datasource.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/presenca_entity.dart';
import 'package:chamada_univel/data/presenca_sqlite_datasource.dart';
import 'package:chamada_univel/view/add_aluno.dart';
import 'package:chamada_univel/view/alunos_presentes.dart';
import 'package:chamada_univel/view/menu_principal.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'add_disciplina.dart';
import 'bottom_navigation_bar.dart';

class Presenca extends StatelessWidget {
  DisciplinaEntity disciplina;

  Presenca({
    required this.disciplina,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: disciplina.nome!,
      theme: style(),
      home: _Presenca(disciplina: disciplina),
    );
  }
}

class _Presenca extends StatefulWidget {
  late DisciplinaEntity disciplina;

  _Presenca({
    required this.disciplina,
  });
  @override
  _PresencaHP createState() => _PresencaHP(disciplina: disciplina);
}

class _PresencaHP extends State<_Presenca> {
  late DisciplinaEntity disciplina;
  List<bool> isChecked = List<bool>.filled(100, true, growable: true);
  _PresencaHP({
    required this.disciplina,
  });

  @override
  void didUpdateWidget(_Presenca oldWidget) {
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
            PresencaSQLiteDataSource().getAllPresencaPorDisciplina(disciplina),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => alunosPresentes(
                            disciplina: disciplina, data: item.data!)));
                  },
                  title: Text(
                    formattedDate.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.calendar_month),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
