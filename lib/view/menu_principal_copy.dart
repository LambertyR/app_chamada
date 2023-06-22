// // ignore_for_file: prefer_const_constructors

// import 'package:chamada_univel/data/instancia_sqlite_datasource.dart';
// import 'package:chamada_univel/view/add_disciplina.dart';
// import 'package:chamada_univel/view/bottom_navigation_bar.dart';
// import 'package:chamada_univel/view/menu_principal.dart';
// import 'package:chamada_univel/view/style.dart';
// import 'package:flutter/material.dart';

// class Menu_Principal extends StatefulWidget {
//   final String email;
//   const Menu_Principal({Key? key, required this.email}) : super(key: key);

//   @override
//   _Menu_Principal createState() {
//     return _Menu_Principal();
//   }
// }

// class _Menu_Principal extends State<Menu_Principal> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Disciplinas'),
//         ),
//         //body: Disciplinas(),
//         bottomNavigationBar: Bottom_Navigation_Bar(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return AddDisciplina();
//             }));
//           },
//           child: Icon(Icons.add_rounded),
//         ),
//       ),
//       theme: style(),
//     );
//   }
// }
