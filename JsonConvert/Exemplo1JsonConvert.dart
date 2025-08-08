import 'dart:convert';

void main() {
  //string no formato json ->
  String jsonString =
      '{"usuario":"João", "login":"joao_user","senha":1234,"ativo":true}';
  //converti a string em MAP -> usando Json. Convert (decode)
  Map<String, dynamic> usuario = json.decode(jsonString);
  //acesso aos elementos (atributos) do Json
  print(usuario["ativo"]);

  //manipular Json usando o MAP
  usuario['ativo'] = false;

  // fazer o encode Map => Json(texto)
  jsonString = jsonEncode(usuario);

  //mostrar o texto no formato JSON
  print(jsonString);
}
