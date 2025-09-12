import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();
  bool _ocultarSenha = true;
  bool _ocultarConfirmarSenha = true;

  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      //após o registro o usuario ja é logado no sistema AuthView -> Joga ele para a tela de tarefas
      Navigator.pop(context); //Fecha a Tela de registro
    } on FirebaseAuthException catch (e) {
      //erro específico do FireBaseAuth
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Registrar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: ()=>setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }),
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off))),
              obscureText: _ocultarSenha,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                suffix: IconButton(
                  onPressed: ()=>setState(() {
                    _ocultarConfirmarSenha = !_ocultarConfirmarSenha;
                  }), 
                  icon: Icon(_ocultarConfirmarSenha ? Icons.visibility : Icons.visibility_off))),
              obscureText: _ocultarConfirmarSenha,
            ),
            SizedBox(height: 20),
            _senhaField.text != _confirmarSenhaField.text
                ? Text(
                    "As Senhas devem ser iguais",
                    style: TextStyle(color: Colors.red),
                  )
                : ElevatedButton(
                    onPressed: _registrar,
                    child: Text("Registrar"),
                  ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              ),
              child: Text("Já tem um cadastro? Faça o Login"),
            ),
          ],
        ),
      ),
    );
  }
}
