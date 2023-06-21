// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/disciplina_sqlite_datasource.dart';
import 'package:chamada_univel/view/add_disciplina.dart';
import 'package:chamada_univel/view/alunos.dart';
import 'package:chamada_univel/view/bottom_navigation_bar.dart';
import 'package:chamada_univel/view/style.dart';
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
      theme: style(),
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
      bottomNavigationBar: Bottom_Navigation_Bar(),
      appBar: AppBar(
        title: Text("Disciplinas"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                DisciplinaSQLiteDataSource().deletarDisciplinas();
                setState(() {});
              },
              child: Text(
                "Excluir Todas",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<DisciplinaEntity>>(
        future: DisciplinaSQLiteDataSource().getAllDisciplina(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DisciplinaEntity>> snapshot) {
          print("* * * * * * * * MENU PRINCIPAL * * * * * * * *");
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                DisciplinaEntity item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.green),
                  onDismissed: (direction) {
                    DisciplinaSQLiteDataSource()
                        .deletarDisciplina(item.disciplinaID!);
                  },
                  child: disciplinaCard(context, item),
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddDisciplina()));
        },
      ),
    );
  }
}

Widget disciplinaCard(context, DisciplinaEntity disciplina) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return new Alunos(disciplina: disciplina);
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
          NomeDiscipina(disciplina),
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

Widget NomeDiscipina(DisciplinaEntity disciplina) {
  return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: Column(children: [
        Text(
          disciplina.nome!,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 35),
        )
      ]));
}
