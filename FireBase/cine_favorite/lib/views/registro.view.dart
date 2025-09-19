import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailfield = TextEditingController();
  final _senhafield = TextEditingController();
  final _confirmarsenhafield = TextEditingController();

  void _registrar() async {
    if (_senhafield.text != _confirmarsenhafield.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailfield.text.trim(),
        password: _senhafield.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
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
              controller: _emailfield,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhafield,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmarsenhafield,
              decoration: InputDecoration(labelText: "Confirmar Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _senhafield.text != _confirmarsenhafield.text
                ? Text(
                    "As senhas devem ser iguais",
                    style: TextStyle(color: Colors.red),
                  )
                : ElevatedButton(
                    onPressed: _registrar,
                    child: Text("Registrar"),
                  ),
            TextButton(
              onPressed: () => Navigator.pop,
              child: Text("Já tem uma conta? Faça o Login Aqui"),
            ),
          ],
        ),
      ),
    );
  }
}
