// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, camel_case_types

import 'package:chamada_univel/data/perfil_sqlite_datasource.dart';
import 'package:chamada_univel/view/style.dart';
import 'package:flutter/material.dart';

import 'package:chamada_univel/data/perfil_entity.dart';

class Cad_Usuario extends StatefulWidget {
  @override
  _Cad_Usuario_State createState() {
    return _Cad_Usuario_State();
  }
}

class _Cad_Usuario_State extends State<Cad_Usuario> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarsenhaController = TextEditingController();
  bool ocultarSenha = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: style(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Cadastro de Usuário'),
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
              fieldEmail(),
              SizedBox(
                height: 10,
              ),
              fieldSenha(),
              SizedBox(
                height: 10,
              ),
              fieldConfirmarSenha(),
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

  Widget fieldEmail() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'E-mail',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: senhaController,
        obscureText: ocultarSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Informe a sua senha",
          labelText: 'Senha',
          helperText: "Digite uma senha para a sua segurança",
          helperStyle: TextStyle(color: Colors.green),
          suffixIcon: IconButton(
            icon: Icon(ocultarSenha ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                ocultarSenha = !ocultarSenha;
              });
            },
          ),
          alignLabelWithHint: false,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget fieldConfirmarSenha() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: confirmarsenhaController,
        obscureText: ocultarSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Confirmar Senha',
          helperText: "Digite novamente a senha",
          helperStyle: TextStyle(color: Colors.green),
          suffixIcon: IconButton(
            icon: Icon(ocultarSenha ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                ocultarSenha = !ocultarSenha;
              });
            },
          ),
          alignLabelWithHint: false,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
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
            if (confirmarsenhaController.text == senhaController.text) {
              PerfilEntity perfil = new PerfilEntity();
              perfil.email = emailController.text;
              perfil.nome = nomeController.text;
              perfil.senha = senhaController.text;

              if (await PerfilSQLiteDataSource().create(perfil)) {
                Navigator.pop(context, false);
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Erro!"),
                        content: Text("Falha ao salvar os dados."),
                      );
                    });
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Dados Incorretos!"),
                      content: Text("Verifique os dados informados."),
                    );
                  });
            }
          },
          child: const Text('Cadastrar'),
        ),
      ),
    );
  }
}
