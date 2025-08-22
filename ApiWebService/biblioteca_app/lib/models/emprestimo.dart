class Emprestimo {
  // atributos
  final String? id; // pode ser nulo inicialmente -> id será atribuído pelo BD
  final String usuario_id;
  final String livro_id;
  DateTime? data_emprestimo; 
  DateTime? data_devolucao;
  bool devolvido;

  // construtor
  Emprestimo({this.id, required this.usuario_id, required this.livro_id, this.data_emprestimo, this.data_devolucao, this.devolvido = false,});

  // métodos
  // toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario_id": usuario_id,
        "livro_id": livro_id,
        "data_emprestimo": data_emprestimo?.toIso8601String(),
        "data_devolucao": data_devolucao?.toIso8601String(),
        "devolvido": devolvido,
      }; 

  // fromJson
  factory Emprestimo.fromJson(Map<String, dynamic> json) => Emprestimo(
        id: json["id"]?.toString(),
        usuario_id: json["usuario_id"].toString(),
        livro_id: json["livro_id"].toString(),
        data_emprestimo: json["data_emprestimo"] != null
            ? DateTime.parse(json["data_emprestimo"])
            : null,
        data_devolucao: json["data_devolucao"] != null
            ? DateTime.parse(json["data_devolucao"])
            : null,
        devolvido: json["devolvido"] ?? false, 
      );
}
