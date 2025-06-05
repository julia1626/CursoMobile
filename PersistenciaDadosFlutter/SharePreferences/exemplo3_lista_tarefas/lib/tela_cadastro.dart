// tela simples 

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastro extends StatelessWidget{
  //atributos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmacaoSenhaController = TextEditingController();

  TelaCadastro({super.key});

  //métodos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cadastro"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmacaoSenhaController,
              decoration: InputDecoration(labelText: "Confirmar Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => _cadastrarUsuario(context) , 
              child: Text("Cadastrar"))
          ],
        ),
      ),
    );
  }
  
  _cadastrarUsuario(BuildContext context) async{
    String nome = _nomeController.text.trim();
    String senha = _senhaController.text.trim();
    String confirmarSenha = _confirmacaoSenhaController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nomeExistente = prefs.getString(nome) ?? "";
    if(nome.isEmpty || senha.isEmpty || confirmarSenha.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha Todos os Campos!!!")));
    } else if(nomeExistente.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário Já Cadastrado!!!")));
    } else if(senha != confirmarSenha){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("As senhas não podem ser diferentes!!!")));
    }else{
      prefs.setString(nome,senha); //salva no cache a senha para o usuario
    Navigator.pushNamed(context, "/"); //navega para a tela de login
    }
  }
}