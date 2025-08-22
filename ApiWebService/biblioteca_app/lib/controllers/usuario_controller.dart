//classe de controller
import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  //métodos
  //GET do usuário
  Future<List<Usuario>> fetchAll() async{
    //pega a lista de usuario no formato List<dynamic>
    final list = await ApiService.getList("usuarios?_sort=nome");

    //retornar a lista de Usuários Convertidas
    return list.map((item) => Usuario.fromJson(item)).toList();
  }
  //GET de um unico Usuário
  Future<Usuario?> fetchOne(String id) async {
    final usuario = await ApiService.getOne("usuarios/$id");
    return Usuario.fromJson(usuario);
  }
  //Post 

  //Put

  //Delete
}