import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  //métodos
  //Get do usuário
  Future<List<Emprestimo>> fetchAll() async {
    //pega a lista de usuario no formato List<dynamic>
    final list = await ApiService.getList("emprestimos?_sort=nome");
    //retornar a Lista de Usuários Convertidas
    return list.map((item) => Emprestimo.fromJson(item)).toList();
  }

  //Get de um unico Usuário
  Future<Emprestimo> fetchOne(String id) async {
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return Emprestimo.fromJson(emprestimo);
  }

  //Post -> Criar um Novo usuário
  Future<Emprestimo> create(Emprestimo emprestar) async {
    final created = await ApiService.post("emprestimos", emprestar.toJson());
    return Emprestimo.fromJson(created);
  }

  //Put -> Alterar um Usuário
  Future<Emprestimo> update(Emprestimo emprestar) async {
    final updated = await ApiService.put("emprestimos", emprestar.toJson(), emprestar.id!);
    return Emprestimo.fromJson(updated);
  }

  // Delete -> Deletar um Usuário
  Future<void> delete(String id) async {
    await ApiService.delete("emprestimos", id);
  }
}
