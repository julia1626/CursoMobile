import 'package:cine_favorite/views/registro.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance; //controlador das ações de autenticação do usuário
  final _emailfield = TextEditingController();
  final _senhafield = TextEditingController();
  bool _ocultarSenha = true;

  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailfield.text.trim(),
        password: _senhafield.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Falha ao Fazer Login: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailfield,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhafield,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: () => setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }),
                  icon: Icon(
                    _ocultarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _ocultarSenha,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _signIn, child: Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroView()),
              ),
              child: Text("Não tem uma conta? Registre-se Aqui"),
            ),
          ],
        ),
      ),
    );
  }
}
