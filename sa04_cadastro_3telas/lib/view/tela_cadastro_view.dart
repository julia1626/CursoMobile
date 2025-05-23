import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _dataNascimento = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cadastro"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Cadastro"),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo Nome
                  TextFormField(
                    decoration: InputDecoration(labelText: "Digite seu Nome"),
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => _nome = value!,
                  ),
                  // Campo Email
                  TextFormField(
                    decoration: InputDecoration(labelText: "Digite seu Email"),
                    validator: (value) => value!.contains("@")
                        ? null
                        : "Por favor, insira um email válido",
                    onSaved: (value) => _email = value!,
                  ),
                  // Campo Senha
                  TextFormField(
                    decoration: InputDecoration(labelText: "Digite sua Senha"),
                    obscureText: true,
                    validator: (value) => value!.length < 6
                        ? "A senha deve ter no mínimo 6 caracteres"
                        : null,
                    onSaved: (value) => _senha = value!,
                  ),
                  // Campo Data de Nascimento
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Digite sua Data de Nascimento"),
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => _dataNascimento = value!,
                  ),
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    child: Text("Enviar"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/"),
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados do Formulário"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nome: $_nome"),
              Text("Email: $_email"),
              Text("Senha: $_senha"),
              Text("Data de Nascimento: $_dataNascimento"),
            ],
          ),
        ),
      );
    }
  }
}
