import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario.dart';

class UsuarioFormView extends StatefulWidget {
  final Usuario? user; // se for nulo, é cadastro novo

  const UsuarioFormView({super.key, this.user});

  @override
  State<UsuarioFormView> createState() => _UsuarioFormViewState();
}

class _UsuarioFormViewState extends State<UsuarioFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = UsuarioController();

  final _nomeField = TextEditingController();
  final _emailField = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nomeField.text = widget.user!.nome;
      _emailField.text = widget.user!.email;
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final usuario = Usuario(
        id: widget.user?.id, // mantém id se for edição
        nome: _nomeField.text,
        email: _emailField.text,
      );

      try {
        if (widget.user == null) {
          await _controller.create(usuario); // cria novo
        } else {
          await _controller.update(usuario); // edita existente
        }
        Navigator.pop(context); // volta para list view (navbar reaparece)
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar usuário: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.user == null ? "Novo Usuário" : "Editar Usuário"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeField,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o nome" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailField,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o email";
                  }
                  if (!value.contains("@")) {
                    return "Email inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
