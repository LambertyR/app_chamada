// ignore_for_file: prefer_const_constructors

import 'package:chamada_univel/view/login.dart';
import 'package:flutter/material.dart';

import '../data/instancia_sqlite_datasource.dart';

class Bottom_Navigation_Bar extends StatefulWidget {
  const Bottom_Navigation_Bar({super.key});

  @override
  State<Bottom_Navigation_Bar> createState() => _Bottom_Navigation_Bar();
}

class _Bottom_Navigation_Bar extends State<Bottom_Navigation_Bar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                InstanciaSQLiteDataSource().deletarInstancias();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyApp();
                }));
              }),
          label: "Sair",
        )
      ],
    );
  }
}
