// ignore_for_file: prefer_const_constructors
import 'package:chamada_univel/view/cad_usuario.dart';
import 'package:chamada_univel/view/recuperar_senha.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';

import '../data/perfil_sqlite_datasource.dart';
import 'disciplinas.dart';
import 'menu_principal.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Chamada Online'),
        ),
        body: Login(),
      ),
      theme: style(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String email = '';
  String pass = '';
  bool ocultarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Image.network(
                  "https://static.vecteezy.com/ti/vetor-gratis/p1/5165306-cartao-cadeado-icone-cadeado-com-cartao-banco-vetor.jpg"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'e-mail',
                ),
                onChanged: (text) {
                  email = text;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: ocultarSenha,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        ocultarSenha ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        ocultarSenha = !ocultarSenha;
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                onChanged: (text) {
                  pass = text;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Recuperar_Senha()));
              },
              child: const Text(
                'Esqueci a senha',
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (await PerfilSQLiteDataSource()
                        .getPerfilLogin(email, pass)) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MenuPrincipal();
                      }));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Incorreto!"),
                              content: Text("Verifique o usuário e senha."),
                            );
                          });
                    }
                  }),
            ),

            // ignore: sort_child_properties_last
            Row(children: <Widget>[
              const Text('Não possui conta?'),
              TextButton(
                  child: const Text(
                    'Cadastre aqui',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cad_Usuario()),
                    );
                  })
            ], mainAxisAlignment: MainAxisAlignment.center),
          ],
        ));
  }
}




// class Login extends StatelessWidget {
//   String email = '';
//   String pass = '';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30),
//                 )),
//             Container(
//               padding: const EdgeInsets.all(10),
//               // ignore: prefer_const_constructors
//               child: TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(
//                   labelText: 'Login',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Senha',
//                 ),
//               ),
//             ),

//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 margin: const EdgeInsets.only(top: 20, bottom: 20),
//                 child: ElevatedButton(
//                   child: const Text('Login'),
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return Menu_Principal();
//                     }));
//                   },
//                 )),
//             // ignore: sort_child_properties_last
//             Row(children: <Widget>[
//               TextButton(
//                   child: const Text(
//                     'Cadastrar',
//                   ),
//                   onPressed: () {
//                     print('Cadastre aqui');
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => Cadastro()),
//                     // );
//                   })
//             ], mainAxisAlignment: MainAxisAlignment.center),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return Recuperar_Senha();
//                 }));
//               },
//               child: const Text(
//                 'Esqueci a senha',
//               ),
//             ),
//           ],
//         ));
//   }
// }
