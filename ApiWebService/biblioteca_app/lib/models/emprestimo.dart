class Emprestimo {
  // atributos
  final String? id; // pode ser nulo inicialmente -> id será atribuído pelo BD
  final String usuario_id;
  final String livro_id;
  final bool devolvido;

  // construtor
  Emprestimo({this.id, required this.usuario_id, required this.livro_id, required this.devolvido,});

  // métodos
  // toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario_id": usuario_id,
        "livro_id": livro_id,
        "devolvido": devolvido,
      }; 

  // fromJson
  factory Emprestimo.fromJson(Map<String, dynamic> json) => Emprestimo(
        id: json["id"]?.toString(),
        usuario_id: json["usuario_id"].toString(),
        livro_id: json["livro_id"].toString(),
        devolvido: json["devolvido"] == 1 ? false : true, 
      );
}
