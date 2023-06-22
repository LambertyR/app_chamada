// ignore_for_file: prefer_const_constructors
//import 'package:chamada_univel/recuperar_senha.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/data/perfil_entity.dart';
import 'package:chamada_univel/data/perfil_sqlite_datasource.dart';
import 'package:chamada_univel/view/bottom_navigation_bar.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';
import 'menu_principal.dart';

class AddDisciplina extends StatelessWidget {
  const AddDisciplina({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Adicionar Disciplina'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MenuPrincipal();
              })),
            )),
        body: _AddDisciplina(),
        bottomNavigationBar: Bottom_Navigation_Bar(),
      ),
      theme: style(),
    );
  }
}

class _AddDisciplina extends StatelessWidget {
  TextEditingController nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),

              // ignore: prefer_const_constructors
              child: TextField(
                controller: nomeController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Nome da Disciplina',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                    child: const Text('Adicionar'),
                    onPressed: () async {
                      DisciplinaEntity disciplina = new DisciplinaEntity();
                      disciplina.nome = nomeController.text;
                      disciplina.perfil = (await PerfilSQLiteDataSource()
                          .buscarPerfil()) as PerfilEntity?;

                      if (await DisciplinaSQLiteDataSource()
                          .create(disciplina)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Sucesso!"),
                                content: Text("A Disciplina " +
                                    nomeController.text +
                                    " foi adicionada."),
                              );
                            });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MenuPrincipal();
                        }));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Falha ao Adicionar Disciplina!"),
                                //content: Text("Verifique o usuário."),
                              );
                            });
                      }
                      // -----------------------------------------------------------
                    })),
          ],
        ));
  }
}
