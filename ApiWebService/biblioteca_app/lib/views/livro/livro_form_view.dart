import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro.dart';

class LivroFormView extends StatefulWidget {
  final Livro? book; // se for nulo, é cadastro novo

  const LivroFormView({super.key, this.book, Livro? livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();

  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();
  bool _disponivel = true;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _tituloField.text = widget.book!.titulo;
      _autorField.text = widget.book!.autor;
      _disponivel = widget.book!.disponivel;
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: widget.book?.id, // mantém id se for edição
        titulo: _tituloField.text,
        autor: _autorField.text,
        disponivel: _disponivel,
      );

      try {
        if (widget.book == null) {
          await _controller.create(livro); // cria novo
        } else {
          await _controller.update(livro); // edita existente
        }
        Navigator.pop(context); // volta para list view (navbar reaparece)
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar livro: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.book == null ? "Novo Livro" : "Editar Livro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o título" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _autorField,
                decoration: const InputDecoration(labelText: "Autor"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o autor" : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Disponível"),
                value: _disponivel,
                onChanged: (value) {
                  setState(() {
                    _disponivel = value;
                  });
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
