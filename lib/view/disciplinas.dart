// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/view/add_disciplina.dart';
import 'package:chamada_univel/view/alunos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'login.dart';

// ignore_for_file: prefer_const_constructors

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Disciplinas",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Senhas cadastradas"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                DisciplinaSQLiteDataSource().deletarDisciplinas();
                setState(() {});
              },
              child: Text(
                "Excluir todos",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<DisciplinaEntity>>(
          future: DisciplinaSQLiteDataSource().getAllDisciplina(),
          builder: (BuildContext context,
              AsyncSnapshot<List<DisciplinaEntity>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  DisciplinaEntity item = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.blue),
                    onDismissed: (direction) {
                      DisciplinaSQLiteDataSource().deletarDisciplina(item);
                    },
                    child: ListTile(
                      title: Text(item.nome!),
                      onTap: () { // alterar aqui
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return new Alunos(disciplina: item.nome!);
                          }),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddDisciplina()));
        },
      ),
    );
  }
}



/*
class Disciplinas extends StatelessWidget {
  const Disciplinas({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder<List<DisciplinaEntity>>(
          future: DisciplinaSQLiteDataSource().getAllDisciplina(),
          builder: (BuildContext context,
              AsyncSnapshot<List<DisciplinaEntity>> snapshot) {
            if (snapshot.hasData) {
              
    }});
}

Widget gerarDisciplinas(context) {

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
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.green,
            Colors.green.shade900,
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
*/