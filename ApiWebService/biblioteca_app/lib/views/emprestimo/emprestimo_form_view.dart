import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/views/emprestimo/emprestimo_list_view.dart';
import 'package:flutter/material.dart';

class EmprestimoFormView extends StatefulWidget {
  final Emprestimo? emprestimo;
  const EmprestimoFormView({super.key, this.emprestimo});

  @override
  State<EmprestimoFormView> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = EmprestimoController();

  final _usuarioField = TextEditingController();
  final _livroField = TextEditingController();
  final _dataEmprestimoField = TextEditingController();
  final _dataDevolucaoField = TextEditingController();
  bool _devolvido = false;

  @override
  void initState() {
    super.initState();
    if (widget.emprestimo != null) {
      _usuarioField.text = widget.emprestimo!.usuario_id;
      _livroField.text = widget.emprestimo!.livro_id;
      _dataEmprestimoField.text = widget.emprestimo!.dataEmprestimo;
      _dataDevolucaoField.text = widget.emprestimo!.dataDevolucao;
      _devolvido = widget.emprestimo!.devolvido;
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        usuario_id: _usuarioField.text.trim(),
        livro_id: _livroField.text.trim(),
        dataEmprestimo: _dataEmprestimoField.text.trim(),
        dataDevolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      await _controller.create(emprestimo);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EmprestimoListView()),
      );
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: widget.emprestimo!.id,
        usuario_id: _usuarioField.text.trim(),
        livro_id: _livroField.text.trim(),
        dataEmprestimo: _dataEmprestimoField.text.trim(),
        dataDevolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      await _controller.update(emprestimo);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EmprestimoListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emprestimo == null ? "Novo Empréstimo" : "Editar Empréstimo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usuarioField,
                decoration: const InputDecoration(labelText: "ID do Usuário"),
                validator: (value) => value!.isEmpty ? "Informe o usuário" : null,
              ),
              TextFormField(
                controller: _livroField,
                decoration: const InputDecoration(labelText: "ID do Livro"),
                validator: (value) => value!.isEmpty ? "Informe o livro" : null,
              ),
              TextFormField(
                controller: _dataEmprestimoField,
                decoration: const InputDecoration(
                  labelText: "Data de Empréstimo",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickDate(_dataEmprestimoField),
                validator: (value) => value!.isEmpty ? "Informe a data de empréstimo" : null,
              ),
              TextFormField(
                controller: _dataDevolucaoField,
                decoration: const InputDecoration(
                  labelText: "Data de Devolução",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickDate(_dataDevolucaoField),
                validator: (value) => value!.isEmpty ? "Informe a data de devolução" : null,
              ),
              Row(
                children: [
                  const Text("Devolvido: "),
                  Switch(
                    value: _devolvido,
                    onChanged: (val) => setState(() => _devolvido = val),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.emprestimo == null ? _save : _update,
                child: Text(widget.emprestimo == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
