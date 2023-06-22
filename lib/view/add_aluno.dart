import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/aluno_entity.dart';
import 'package:chamada_univel/data/aluno_sqlite_datasource.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:flutter/material.dart';

import '../data/perfil_entity.dart';
import '../data/perfil_sqlite_datasource.dart';
import 'bottom_navigation_bar.dart';
import 'style.dart';

class AddAluno extends StatefulWidget {
  DisciplinaEntity disciplina;

  AddAluno({
    required this.disciplina,
  });
  @override
  _AddAluno createState() {
    return _AddAluno(disciplina: disciplina);
  }
}

class _AddAluno extends State<AddAluno> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController registroController = TextEditingController();
  DisciplinaEntity disciplina;

  _AddAluno({
    required this.disciplina,
  });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: style(),
      home: Scaffold(
        bottomNavigationBar: Bottom_Navigation_Bar(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Cadastro de Aluno'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: [IconButton(onPressed: null, icon: Icon(Icons.save))],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: Column(
            children: [
              fieldName(),
              SizedBox(
                height: 10,
              ),
              fieldRegistro(),
              SizedBox(
                height: 10,
              ),
              buttonCadastrar(context),
            ],
          )),
        ),
      ),
    );
  }

  Widget fieldName() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: nomeController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nome',
        ),
      ),
    );
  }

  Widget fieldRegistro() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: registroController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Registro do Aluno (Único)',
        ),
      ),
    );
  }

  Widget buttonCadastrar(context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ElevatedButton(
          onPressed: () async {
            AlunoEntity aluno = new AlunoEntity();
            aluno.nome = nomeController.text;
            aluno.registro = int.parse(registroController.text);
            // Verifica se o aluno já existe
            if (await AlunoSQLiteDataSource().verificaRegistro(aluno)) {
              print('Registro Existe');
              AlunoDisciplinaEntity aluno_disciplina = AlunoDisciplinaEntity();
              aluno_disciplina.aluno = aluno;
              aluno_disciplina.disciplina = disciplina;
              // Registra na tabela aluno_disciplina
              if (await AlunoDisciplinaSQLiteDataSource()
                  .create(aluno_disciplina)) {
                Navigator.pop(context, false);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Sucesso!"),
                        content: Text("Aluno " +
                            nomeController.text +
                            " adicionado à " +
                            (disciplina.nome as String) +
                            "!"),
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Aluno já cadastrado!"),
                        content: Text("Aluno " +
                            nomeController.text +
                            " já está cadastrado em " +
                            (disciplina.nome as String) +
                            "!"),
                      );
                    });
              }
            } else {
              print('Registro não Existe');
              // Cria aluno
              if (await AlunoSQLiteDataSource().create(aluno)) {
                AlunoDisciplinaEntity aluno_disciplina =
                    AlunoDisciplinaEntity();
                aluno_disciplina.aluno = aluno;
                aluno_disciplina.disciplina = disciplina;
                // Cria registro na tabela aluno_disciplina
                if (await AlunoDisciplinaSQLiteDataSource()
                    .create(aluno_disciplina)) {
                  Navigator.pop(context, false);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Sucesso!"),
                          content: Text("Aluno " +
                              nomeController.text +
                              " cadastrado e adicionado à " +
                              (disciplina.nome as String) +
                              "!"),
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erro!"),
                          content: Text(
                              "Falha ao salvar os dados, confira as informações."),
                        );
                      });
                }
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Erro!"),
                        content: Text(
                            "Falha ao salvar os dados, confira as informações."),
                      );
                    });
              }
            }
          },
          child: const Text('Cadastrar'),
        ),
      ),
    );
  }
}
