import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/views/emprestimo/emprestimo_form_view.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  final _controller = EmprestimoController();
  List<Emprestimo> _emprestimos = [];
  List<Emprestimo> _filtroEmprestimos = [];
  final _buscaField = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _emprestimos = await _controller.fetchAll();
      _filtroEmprestimos = _emprestimos;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroEmprestimos = _emprestimos.where((emp) {
        return emp.usuario_id.toLowerCase().contains(busca) ||
               emp.livro_id.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _openForm({Emprestimo? emprestimo}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmprestimoFormView(emprestimo: emprestimo)),
    );
    _load();
  }

  void _delete(Emprestimo emprestimo) async {
    if (emprestimo.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirma Exclusão"),
        content: const Text("Deseja realmente excluir este empréstimo?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Excluir")),
        ],
      ),
    );
    if (confirm == true) {
      await _controller.delete(emprestimo.id!);
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Empréstimos")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _buscaField,
                    decoration: const InputDecoration(labelText: "Pesquisar Empréstimo"),
                    onChanged: (value) => _filtrar(),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filtroEmprestimos.length,
                      itemBuilder: (context, index) {
                        final emp = _filtroEmprestimos[index];
                        return Card(
                          child: ListTile(
                            title: Text("Usuário: ${emp.usuario_id} | Livro: ${emp.livro_id}"),
                            subtitle: Text(
                              "Empréstimo: ${emp.dataEmprestimo} - Devolução: ${emp.dataDevolucao}\nDevolvido: ${emp.devolvido ? "Sim" : "Não"}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _openForm(emprestimo: emp),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _delete(emp),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
